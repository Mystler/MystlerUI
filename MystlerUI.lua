-- AddOn setup
MystlerUI = LibStub("AceAddon-3.0"):NewAddon("MystlerUI", "AceConsole-3.0", "AceEvent-3.0")

-- Register new textures with LibSharedMedia
LSM = LibStub("LibSharedMedia-3.0")
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar01", [[Interface\Addons\MystlerUI\tex\MystlerBar01]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar02", [[Interface\Addons\MystlerUI\tex\MystlerBar02]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar03", [[Interface\Addons\MystlerUI\tex\MystlerBar03]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar04", [[Interface\Addons\MystlerUI\tex\MystlerBar04]])

-- Option helpers
local function setOption(info, value)
    MystlerUI.db.profile[info[#info]] = value
end

local function getOption(info)
    return MystlerUI.db.profile[info[#info]]
end

local function setEnabled(info, value)
    if value then
        MystlerUI:Enable()
    else
        MystlerUI:Disable()
    end
    setOption(info, value)
end

-- AddOn options
local options = {
    type = "group",
    args = {
        enabled = {
            order = 1,
            name = "Enable",
            desc = "Enables / disables all MystlerUI features",
            type = "toggle",
            set = setEnabled,
            get = getOption,
        },
        sound = {
            order = 2,
            name = "Enable Sound FX",
            desc = "Enables / disables playing the custom sound effects",
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
    if UnitClass("player") == "Rogue" then
        if (not UnitBuff("player", "Deadly Poison") and
            not UnitBuff("player", "Wound Poison") and
            not UnitBuff("player", "Instant Poison")) or
            (not UnitBuff("player", "Leeching Poison") and
            not UnitBuff("player", "Crippling Poison")) then
            if self.buffOk then
                self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\poison.ogg]], "Master")
                self:Print("One of your poisons is missing. Ugh, don't be so healthy!")
            end
            self.buffOk = false
        else
            self.buffOk = true
        end
    elseif UnitClass("player") == "Shaman" then
        if not UnitBuff("player", "Lightning Shield") and
            not UnitBuff("player", "Water Shield") then
            if self.buffOk then
                self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\buff.ogg]], "Master")
                self:Print("Don't ya forget yer shields and enchantments!")
            end
            self.buffOk = false
        else
            self.buffOk = true
        end
    end
end

-- Events
function MystlerUI:PLAYER_DEAD()
    self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\defeat.ogg]], "Master")
    self:Print("OMG, you are dead... You DO know that being dead means you're quite not so alive, do you?")
end

function MystlerUI:UNIT_AURA(event, unit)
    if unit == "player" then
        self:BuffCheck()
    end
end

function MystlerUI:RaidChatMessage(event, msg, ...)
    msg = string.lower(msg)
    -- Bloodlust alert for Shaman and Mage
    if UnitClass("player") == "Shaman" or UnitClass("player") == "Mage" then
        if msg == "bl" or msg == "kr" or string.find(msg, "^bl ") or string.find(msg, "^kr ") then
            self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\bloodlust.ogg]], "Master")
            self:Print("Can you feel the Bloodlust? No? Then press that damn button!")
        end
    end
end
