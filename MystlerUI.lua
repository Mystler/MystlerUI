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
            desc = "Only play sounds for spells if the local player uses them.",
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
end

function MystlerUI:OnEnable()
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_DEAD")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function MystlerUI:OnDisable()
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


-- Events
function MystlerUI:PLAYER_ENTERING_WORLD(event, ...)
    SetCVar("cameraDistanceMaxFactor", 2.6)
end

function MystlerUI:PLAYER_DEAD(event, ...)
    self:PlaySoundFile(addonpath.."sfx\\defeat.ogg", "SFX")
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
