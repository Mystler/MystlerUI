-- AddOn setup
MystlerUI = LibStub("AceAddon-3.0"):NewAddon("MystlerUI", "AceConsole-3.0", "AceEvent-3.0")

-- Register new textures with LibSharedMedia
LSM = LibStub("LibSharedMedia-3.0")
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar01", [[Interface\Addons\MystlerUI\tex\MystlerBar01]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar02", [[Interface\Addons\MystlerUI\tex\MystlerBar02]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar03", [[Interface\Addons\MystlerUI\tex\MystlerBar03]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar04", [[Interface\Addons\MystlerUI\tex\MystlerBar04]])

-- Register some of our sounds
LSM:Register(LSM.MediaType.SOUND, "Assassinen", [[Interface\Addons\MystlerUI\sfx\assassinen.ogg]])
LSM:Register(LSM.MediaType.SOUND, "DunDunDaah", [[Interface\Addons\MystlerUI\sfx\defeat.ogg]])
LSM:Register(LSM.MediaType.SOUND, "DeathComes", [[Interface\Addons\MystlerUI\sfx\ow\deathcomes.ogg]])
LSM:Register(LSM.MediaType.SOUND, "DeathFromAbove", [[Interface\Addons\MystlerUI\sfx\ow\deathfromabove.ogg]])
LSM:Register(LSM.MediaType.SOUND, "DidThatSting", [[Interface\Addons\MystlerUI\sfx\ow\didthatsting.ogg]])
LSM:Register(LSM.MediaType.SOUND, "DieDieDie", [[Interface\Addons\MystlerUI\sfx\ow\die.ogg]])
LSM:Register(LSM.MediaType.SOUND, "HeroesNeverDie", [[Interface\Addons\MystlerUI\sfx\ow\heroesneverdie.ogg]])
LSM:Register(LSM.MediaType.SOUND, "DropTheBeat", [[Interface\Addons\MystlerUI\sfx\ow\letsdropthebeat.ogg]])
LSM:Register(LSM.MediaType.SOUND, "WatchingOverYou", [[Interface\Addons\MystlerUI\sfx\ow\watchingoveryou.ogg]])
LSM:Register(LSM.MediaType.SOUND, "InMySights", [[Interface\Addons\MystlerUI\sfx\ow\ivegotyou.ogg]])
LSM:Register(LSM.MediaType.SOUND, "YourAttention", [[Interface\Addons\MystlerUI\sfx\ow\doihaveyourattention.ogg]])
LSM:Register(LSM.MediaType.SOUND, "BarrierUp", [[Interface\Addons\MystlerUI\sfx\ow\barrierup.ogg]])
LSM:Register(LSM.MediaType.SOUND, "HighNoon", [[Interface\Addons\MystlerUI\sfx\ow\highnoon.ogg]])
LSM:Register(LSM.MediaType.SOUND, "SpeedBoost", [[Interface\Addons\MystlerUI\sfx\ow\speedboost.ogg]])
LSM:Register(LSM.MediaType.SOUND, "ExperienceTranquility", [[Interface\Addons\MystlerUI\sfx\ow\tranquility.ogg]])
LSM:Register(LSM.MediaType.SOUND, "GetBack", [[Interface\Addons\MystlerUI\sfx\ow\getback.ogg]])
LSM:Register(LSM.MediaType.SOUND, "GetBehindMe", [[Interface\Addons\MystlerUI\sfx\ow\getbehindme.ogg]])

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
        if (not UnitBuff("player", "Deadly Poison") and
            not UnitBuff("player", "Wound Poison") and
            not UnitBuff("player", "Agonizing Poison")) or
            (not UnitBuff("player", "Leeching Poison") and
            not UnitBuff("player", "Crippling Poison")) then
            if self.buffOk then
                self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\poison.ogg]], "SFX")
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
    self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\defeat.ogg]], "SFX")
    self:Print("OMG, you are dead... You DO know that being dead means you're quite not so alive, do you?")
end

function MystlerUI:UNIT_AURA(event, unit)
    if unit == "player" then
        self:BuffCheck()
    end
end

function MystlerUI:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
    local timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2 = select(1, ...)
    if type == "SPELL_CAST_SUCCESS" then
        local spell, spellName, spellSchool = select(12, ...)
        -- Priest
        if spell == 47788 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\watchingoveryou.ogg]], "SFX") -- Guardian Spirit
        elseif spell == 64843 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\letsdropthebeat.ogg]], "SFX") -- Divine Hymn
        elseif spell == 2006 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\heroesneverdie.ogg]], "SFX") -- Resurrection
        elseif spell == 212036 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\heroesneverdie.ogg]], "SFX") -- Mass Resurrection
        elseif spell == 73325 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\getback.ogg]], "SFX") -- Leap of Faith
        elseif spell == 62618 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\barrierup.ogg]], "SFX") -- Power Word: Barrier
        -- Rogue
        elseif spell == 51690 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\die.ogg]], "SFX") -- Killing Spree
        elseif spell == 200806 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\didthatsting.ogg]], "SFX") -- Exsanguinate
        elseif spell == 121471 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\deathcomes.ogg]], "SFX") -- Shadow Blades
        elseif spell == 152150 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\deathfromabove.ogg]], "SFX") -- Death From Above
        -- Hunter
        elseif spell == 120360 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\ivegotyou.ogg]], "SFX") -- Barrage
        -- Druid
        elseif spell == 6795 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\doihaveyourattention.ogg]], "SFX") -- Growl
        elseif spell == 740 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\tranquility.ogg]], "SFX") -- Tranquility
        elseif spell == 106898 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\speedboost.ogg]], "SFX") -- Stampeding Roar
        -- Shaman
        elseif spell == 2825 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\highnoon.ogg]], "SFX") -- Bloodlust
        -- Mage
        elseif spell == 80353 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\highnoon.ogg]], "SFX") -- Time Warp
        -- Paladin
        elseif spell == 204150 then self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\ow\getbehindme.ogg]], "SFX") -- Aegis of Light
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
        if msg == "bl" or msg == "kr" or string.find(msg, "^bl ") or string.find(msg, "^kr ") then
            self:PlaySoundFile([[Interface\Addons\MystlerUI\sfx\bloodlust.ogg]], "SFX")
            self:Print("Can you feel the Bloodlust? No? Then press that damn button!")
        end
    end
end
