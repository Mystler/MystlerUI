local A, L = ...
local addonpath = "Interface\\AddOns\\"..A.."\\"

-- AddOn setup
MystlerUI = LibStub("AceAddon-3.0"):NewAddon("MystlerUI", "AceConsole-3.0", "AceEvent-3.0")

-- Option helpers
local function setOption(info, value)
    MystlerUI.db.profile[info[#info]] = value
    MystlerUI:ApplySettings()
end

local function getOption(info)
    return MystlerUI.db.profile[info[#info]]
end

-- AddOn options
local options = {
    type = "group",
    args = {
        enabled = {
            order = 1,
            name = "Enable",
            desc = "Enables / disables all MystlerUI features.",
            type = "toggle",
            set = setOption,
            get = getOption,
        },
        sound = {
            order = 2,
            name = "Enable Sound FX",
            desc = "Enables / disables playing the custom sound effects.",
            type = "toggle",
            set = setOption,
            get = getOption,
        },
        onlyme = {
            order = 3,
            name = "Only Me",
            desc = "Only play custom sounds for the local player.",
            type = "toggle",
            set = setOption,
            get = getOption,
        },
    },
}

-- Default options
local defaults = {
    profile = {
        enabled = true,
        sound = true,
        onlyme = false,
    },
}

function MystlerUI:OnInitialize()
    -- Initialize DB and options
    self.db = LibStub("AceDB-3.0"):New("MystlerDB", defaults, true)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("MystlerUI", options)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("MystlerUIProfiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))
    -- Add options to WoW settings menu
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MystlerUI")
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MystlerUIProfiles", "Profiles", "MystlerUI")
    -- Register chat command
    self:RegisterChatCommand("mystlerui", "ChatCommand")
    -- Handle profile callbacks
    self.db.RegisterCallback(self, "OnProfileChanged", "ApplySettings")
    self.db.RegisterCallback(self, "OnProfileCopied", "ApplySettings")
    self.db.RegisterCallback(self, "OnProfileReset", "ApplySettings")
    self:ApplySettings()
    -- Initialize member variables
    self.buffOk = true
end

function MystlerUI:OnEnable()
    -- Register events
    self:RegisterEvent("PLAYER_DEAD")
    self:RegisterEvent("UNIT_AURA")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    self:RegisterEvent("CHAT_MSG_RAID", "RaidChatMessage")
    self:RegisterEvent("CHAT_MSG_RAID_LEADER", "RaidChatMessage")
    self:RegisterEvent("CHAT_MSG_RAID_WARNING", "RaidChatMessage")
    self:RegisterEvent("CHAT_MSG_INSTANCE_CHAT", "RaidChatMessage")
    self:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER", "RaidChatMessage")
    self:RegisterEvent("CHAT_MSG_PARTY", "RaidChatMessage")
    self:RegisterEvent("CHAT_MSG_PARTY_LEADER", "RaidChatMessage")
end

function MystlerUI:OnDisable()
    -- Unregister events
    self:UnregisterAllEvents()
end

function MystlerUI:ChatCommand(input)
    if not input or input:trim() == "" then
        -- HACK: Workaround for a bug in Blizzard's code
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0").HandleCommand(self, "mystlerui", "MystlerUI", input)
    end
end

function MystlerUI:ApplySettings()
    -- Check whether we have to enable or disable the AddOn
    if self.db.profile.enabled then
        self:Enable()
    else
        self:Disable()
    end
end

-- Play a sound if enabled
function MystlerUI:PlaySoundFile(...)
    if self.db.profile.sound then
        PlaySoundFile(...)
    end
end

-- Check for important class buffs
function MystlerUI:BuffCheck()
    if UnitClass("player") == "Rogue" and GetSpecialization() == 1 then
        if (not UnitBuff("player", GetSpellInfo(2823)) and -- Deadly Poison
            not UnitBuff("player", GetSpellInfo(8679)) and -- Wound Poison
            not UnitBuff("player", GetSpellInfo(200802))) or -- Agonizing Poison
            (not UnitBuff("player", GetSpellInfo(108211)) and -- Leeching Poison
            not UnitBuff("player", GetSpellInfo(3408))) then -- Crippling Poison
            if self.buffOk then
                self:PlaySoundFile(addonpath.."sfx\\poison.ogg", "SFX")
                self:Print("One of your poisons is missing. Ugh, don't be so healthy!")
            end
            self.buffOk = false
        else
            self.buffOk = true
        end
    end
end

-- Events
function MystlerUI:PLAYER_DEAD()
    self:PlaySoundFile(addonpath.."sfx\\defeat.ogg", "SFX")
    self:Print("OMG, you are dead... You DO know that being dead means you're quite not so alive, do you?")
end

function MystlerUI:UNIT_AURA(event, unit)
    if unit == "player" then
        self:BuffCheck()
    end
end

function MystlerUI:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
    local timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2 = select(1, ...)

    -- Only Me?
    if self.db.profile.onlyme and sourceGUID ~= UnitGUID("player") then
        return
    end

    if type == "SPELL_CAST_SUCCESS" then
        local spellID, spellName, spellSchool = select(12, ...)
        for id, sound in pairs(L.SFXCastSuccessSpellIDs) do
            if id == spellID then
                self:PlaySoundFile(sound, "SFX")
                return
            end
        end
        for name, sound in pairs(L.SFXCastSuccessSpellNames) do
            if name == spellName then
                self:PlaySoundFile(sound, "SFX")
                return
            end
        end
    elseif type == "SPELL_AURA_APPLIED" then
        local spellID, spellName, spellSchool = select(12, ...)
        for name, sound in pairs(L.SFXAuraAppliedSpellNames) do
            if name == spellName then
                self:PlaySoundFile(sound, "SFX")
                return
            end
        end
    end
end

function MystlerUI:ACTIVE_TALENT_GROUP_CHANGED(...)
    self:BuffCheck()
end

function MystlerUI:RaidChatMessage(event, msg, ...)
    msg = string.lower(msg)
    -- Bloodlust alert for Shaman and Mage
    if UnitClass("player") == "Shaman" or UnitClass("player") == "Mage" then
        if string.find(msg, "^bl ") or string.find(msg, "^kr ") then
            self:PlaySoundFile(addonpath.."sfx\\bloodlust.ogg", "SFX")
            self:Print("Can you feel the Bloodlust? No? Then press that damn button!")
        end
    end
end
