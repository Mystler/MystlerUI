local A, L = ...
local addonpath = "Interface\\AddOns\\"..A.."\\"

-- AddOn setup
MystlerUI = LibStub("AceAddon-3.0"):NewAddon("MystlerUI", "AceConsole-3.0", "AceEvent-3.0")

-- Register new textures with LibSharedMedia
LSM = LibStub("LibSharedMedia-3.0")
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar01", addonpath.."tex\\MystlerBar01")
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar02", addonpath.."tex\\MystlerBar02")
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar03", addonpath.."tex\\MystlerBar03")
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar04", addonpath.."tex\\MystlerBar04")

-- Register fonts
LSM:Register(LSM.MediaType.FONT, "Roboto-Bold", addonpath.."fonts\\Roboto-Bold.ttf")
LSM:Register(LSM.MediaType.FONT, "Roboto-Regular", addonpath.."fonts\\Roboto-Regular.ttf")

-- Register some of our sounds
LSM:Register(LSM.MediaType.SOUND, "Assassinen", addonpath.."sfx\\assassinen.ogg")
LSM:Register(LSM.MediaType.SOUND, "DunDunDaah", addonpath.."sfx\\defeat.ogg")
LSM:Register(LSM.MediaType.SOUND, "DeathComes", addonpath.."sfx\\ow\\deathcomes.ogg")
LSM:Register(LSM.MediaType.SOUND, "DeathFromAbove", addonpath.."sfx\\ow\\deathfromabove.ogg")
LSM:Register(LSM.MediaType.SOUND, "DidThatSting", addonpath.."sfx\\ow\\didthatsting.ogg")
LSM:Register(LSM.MediaType.SOUND, "DieDieDie", addonpath.."sfx\\ow\\die.ogg")
LSM:Register(LSM.MediaType.SOUND, "HeroesNeverDie", addonpath.."sfx\\ow\\heroesneverdie.ogg")
LSM:Register(LSM.MediaType.SOUND, "DropTheBeat", addonpath.."sfx\\ow\\letsdropthebeat.ogg")
LSM:Register(LSM.MediaType.SOUND, "WatchingOverYou", addonpath.."sfx\\ow\\watchingoveryou.ogg")
LSM:Register(LSM.MediaType.SOUND, "InMySights", addonpath.."sfx\\ow\\ivegotyou.ogg")
LSM:Register(LSM.MediaType.SOUND, "YourAttention", addonpath.."sfx\\ow\\doihaveyourattention.ogg")
LSM:Register(LSM.MediaType.SOUND, "BarrierUp", addonpath.."sfx\\ow\\barrierup.ogg")
LSM:Register(LSM.MediaType.SOUND, "HighNoon", addonpath.."sfx\\ow\\highnoon.ogg")
LSM:Register(LSM.MediaType.SOUND, "SpeedBoost", addonpath.."sfx\\ow\\speedboost.ogg")
LSM:Register(LSM.MediaType.SOUND, "ExperienceTranquility", addonpath.."sfx\\ow\\tranquility.ogg")
LSM:Register(LSM.MediaType.SOUND, "GetBack", addonpath.."sfx\\ow\\getback.ogg")
LSM:Register(LSM.MediaType.SOUND, "GetBehindMe", addonpath.."sfx\\ow\\getbehindme.ogg")
LSM:Register(LSM.MediaType.SOUND, "Repositioning", addonpath.."sfx\\ow\\repos.ogg")
LSM:Register(LSM.MediaType.SOUND, "TracerBlink", addonpath.."sfx\\ow\\blink.ogg")
LSM:Register(LSM.MediaType.SOUND, "ReinhardtCharge", addonpath.."sfx\\ow\\charge.ogg")
LSM:Register(LSM.MediaType.SOUND, "AnchorsAway", addonpath.."sfx\\ow\\anchors.ogg")
LSM:Register(LSM.MediaType.SOUND, "DontBeShy", addonpath.."sfx\\ow\\dontbeshy.ogg")
LSM:Register(LSM.MediaType.SOUND, "JusticeRains", addonpath.."sfx\\ow\\justice.ogg")
LSM:Register(LSM.MediaType.SOUND, "HoldUpNow", addonpath.."sfx\\ow\\holdupnow.ogg")
LSM:Register(LSM.MediaType.SOUND, "MoooltenCooore", addonpath.."sfx\\ow\\moltencore.ogg")
LSM:Register(LSM.MediaType.SOUND, "OhMyGosh", addonpath.."sfx\\ow\\omg.ogg")
LSM:Register(LSM.MediaType.SOUND, "MeiUltimate", addonpath.."sfx\\ow\\meiult.ogg")
LSM:Register(LSM.MediaType.SOUND, "JunkratGotcha", addonpath.."sfx\\ow\\gotcha.ogg")
LSM:Register(LSM.MediaType.SOUND, "BackInTheSaddleAgain", addonpath.."sfx\\ow\\backinthesaddle.ogg")
LSM:Register(LSM.MediaType.SOUND, "JunkratFireInTheHole", addonpath.."sfx\\ow\\fireinthehole.ogg")
LSM:Register(LSM.MediaType.SOUND, "ISeeYou", addonpath.."sfx\\ow\\iseeyou.ogg")
LSM:Register(LSM.MediaType.SOUND, "IllRaceYa", addonpath.."sfx\\ow\\illraceya.ogg")
LSM:Register(LSM.MediaType.SOUND, "ReaperWraithWalk", addonpath.."sfx\\ow\\wraithwalk.ogg")
LSM:Register(LSM.MediaType.SOUND, "OneManApocalypse", addonpath.."sfx\\ow\\onemanapocalypse.ogg")
LSM:Register(LSM.MediaType.SOUND, "JunkratLaugh", addonpath.."sfx\\ow\\junkratlaugh.ogg")
LSM:Register(LSM.MediaType.SOUND, "SquealForMe", addonpath.."sfx\\ow\\squealforme.ogg")
LSM:Register(LSM.MediaType.SOUND, "RoadhogShutUp", addonpath.."sfx\\ow\\shutup.ogg")
LSM:Register(LSM.MediaType.SOUND, "WereAllAnimals", addonpath.."sfx\\ow\\wereallanimals.ogg")
LSM:Register(LSM.MediaType.SOUND, "JusticeWillBeDone", addonpath.."sfx\\ow\\justicewillbedone.ogg")
LSM:Register(LSM.MediaType.SOUND, "BeShielded", addonpath.."sfx\\ow\\beshielded.ogg")
LSM:Register(LSM.MediaType.SOUND, "DarknessConsumes", addonpath.."sfx\\ow\\thedarkness.ogg")
LSM:Register(LSM.MediaType.SOUND, "AngelOfDeath", addonpath.."sfx\\ow\\angelofdeath.ogg")

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
            desc = "Enables / disables all MystlerUI features.",
            type = "toggle",
            set = setEnabled,
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
        if (not UnitBuff("player", "Deadly Poison") and
            not UnitBuff("player", "Wound Poison") and
            not UnitBuff("player", "Agonizing Poison")) or
            (not UnitBuff("player", "Leeching Poison") and
            not UnitBuff("player", "Crippling Poison")) then
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
        local spell, spellName, spellSchool = select(12, ...)
        -- Priest
        if spellName == "Guardian Spirit" then self:PlaySoundFile(addonpath.."sfx\\ow\\watchingoveryou.ogg", "SFX")
        elseif spell == 64843 then self:PlaySoundFile(addonpath.."sfx\\ow\\letsdropthebeat.ogg", "SFX") -- Divine Hymn
        elseif spellName == "Resurrection" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Mass Resurrection" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Leap of Faith" then self:PlaySoundFile(addonpath.."sfx\\ow\\getback.ogg", "SFX")
        elseif spell == 62618 then self:PlaySoundFile(addonpath.."sfx\\ow\\barrierup.ogg", "SFX") -- Power Word: Barrier
        elseif spellName == "Silence" then self:PlaySoundFile(addonpath.."sfx\\ow\\shutup.ogg", "SFX")
        elseif spellName == "Surrender to Madness" then self:PlaySoundFile(addonpath.."sfx\\ow\\junkratlaugh.ogg", "SFX")
        -- Rogue
        elseif spell == 51690 then self:PlaySoundFile(addonpath.."sfx\\ow\\die.ogg", "SFX") -- Killing Spree
        elseif spell == 200806 then self:PlaySoundFile(addonpath.."sfx\\ow\\didthatsting.ogg", "SFX") -- Exsanguinate
        elseif spell == 121471 then self:PlaySoundFile(addonpath.."sfx\\ow\\deathcomes.ogg", "SFX") -- Shadow Blades
        elseif spell == 152150 then self:PlaySoundFile(addonpath.."sfx\\ow\\deathfromabove.ogg", "SFX") -- Death From Above
        elseif spell == 185767 then self:PlaySoundFile(addonpath.."sfx\\ow\\justice.ogg", "SFX") -- Cannonball Barrage
        elseif spellName == "Shadowstep" then self:PlaySoundFile(addonpath.."sfx\\ow\\repos.ogg", "SFX")
        elseif spellName == "Vendetta" then self:PlaySoundFile(addonpath.."sfx\\ow\\iseeyou.ogg", "SFX")
        elseif spellName == "Sprint" then self:PlaySoundFile(addonpath.."sfx\\ow\\illraceya.ogg", "SFX")
        -- Hunter
        elseif spell == 120360 then self:PlaySoundFile(addonpath.."sfx\\ow\\ivegotyou.ogg", "SFX") -- Barrage
        elseif spell == 194855 then self:PlaySoundFile(addonpath.."sfx\\ow\\fireinthehole.ogg", "SFX") -- Dragonsfire Grenade
        -- Pets
        elseif spellName == "Gift of Chi-Ji" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Eternal Guardian" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Ancient Hysteria" then self:PlaySoundFile(addonpath.."sfx\\ow\\highnoon.ogg", "SFX")
        elseif spellName == "Netherwinds" then self:PlaySoundFile(addonpath.."sfx\\ow\\highnoon.ogg", "SFX")
        -- Druid
        elseif spell == 6795 then self:PlaySoundFile(addonpath.."sfx\\ow\\doihaveyourattention.ogg", "SFX") -- Growl
        elseif spell == 740 then self:PlaySoundFile(addonpath.."sfx\\ow\\tranquility.ogg", "SFX") -- Tranquility
        elseif spell == 61336 then self:PlaySoundFile(addonpath.."sfx\\ow\\dontbeshy.ogg", "SFX") -- Survival Instincts
        elseif spellName == "Stampeding Roar" then self:PlaySoundFile(addonpath.."sfx\\ow\\speedboost.ogg", "SFX")
        elseif spellName == "Displacer Beast" then self:PlaySoundFile(addonpath.."sfx\\ow\\blink.ogg", "SFX")
        elseif spellName == "Wild Charge" then self:PlaySoundFile(addonpath.."sfx\\ow\\charge.ogg", "SFX")
        elseif spellName == "Revitalize" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Revive" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Rebirth" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Dash" then self:PlaySoundFile(addonpath.."sfx\\ow\\illraceya.ogg", "SFX")
        -- Shaman
        elseif spellName == "Bloodlust" then self:PlaySoundFile(addonpath.."sfx\\ow\\highnoon.ogg", "SFX")
        elseif spellName == "Heroism" then self:PlaySoundFile(addonpath.."sfx\\ow\\highnoon.ogg", "SFX")
        elseif spellName == "Ancestral Spirit" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Ancestral Vision" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Feral Lunge" then self:PlaySoundFile(addonpath.."sfx\\ow\\charge.ogg", "SFX")
        -- Mage
        elseif spellName == "Time Warp" then self:PlaySoundFile(addonpath.."sfx\\ow\\highnoon.ogg", "SFX")
        elseif spellName == "Blink" then self:PlaySoundFile(addonpath.."sfx\\ow\\blink.ogg", "SFX")
        elseif spellName == "Combustion" then self:PlaySoundFile(addonpath.."sfx\\ow\\moltencore.ogg", "SFX")
        elseif spellName == "Ice Block" then self:PlaySoundFile(addonpath.."sfx\\ow\\omg.ogg", "SFX")
        elseif spellName == "Icy Veins" then self:PlaySoundFile(addonpath.."sfx\\ow\\meiult.ogg", "SFX")
        elseif spellName == "Polymorph" then self:PlaySoundFile(addonpath.."sfx\\ow\\wereallanimals.ogg", "SFX")
        -- Paladin
        elseif spell == 204150 then self:PlaySoundFile(addonpath.."sfx\\ow\\getbehindme.ogg", "SFX") -- Aegis of Light
        elseif spellName == "Redemption" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Absolution" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Blinding Light" then self:PlaySoundFile(addonpath.."sfx\\ow\\holdupnow.ogg", "SFX")
        elseif spellName == "Divine Steed" then self:PlaySoundFile(addonpath.."sfx\\ow\\backinthesaddle.ogg", "SFX")
        elseif spellName == "Hammer of Justice" then self:PlaySoundFile(addonpath.."sfx\\ow\\justicewillbedone.ogg", "SFX")
        elseif spellName == "Blessing of Protection" then self:PlaySoundFile(addonpath.."sfx\\ow\\beshielded.ogg", "SFX")
        -- Warrior
        elseif spellName == "Intercept" then self:PlaySoundFile(addonpath.."sfx\\ow\\charge.ogg", "SFX")
        elseif spellName == "Charge" then self:PlaySoundFile(addonpath.."sfx\\ow\\charge.ogg", "SFX")
        -- Death Knight
        elseif spellName == "Death Grip" then self:PlaySoundFile(addonpath.."sfx\\ow\\anchors.ogg", "SFX")
        elseif spellName == "Raise Ally" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spell == 212552 then self:PlaySoundFile(addonpath.."sfx\\ow\\wraithwalk.ogg", "SFX") -- Wraith Walk
        elseif spellName == "Asphyxiate" then self:PlaySoundFile(addonpath.."sfx\\ow\\squealforme.ogg", "SFX")
        -- Monk
        elseif spellName == "Reawaken" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        elseif spellName == "Resuscitate" then self:PlaySoundFile(addonpath.."sfx\\ow\\heroesneverdie.ogg", "SFX")
        -- Warlock
        elseif spellName == "Cataclysm" then self:PlaySoundFile(addonpath.."sfx\\ow\\onemanapocalypse.ogg", "SFX")
        -- Demon Hunter
        elseif spell == 198013 then self:PlaySoundFile(addonpath.."sfx\\ow\\angelofdeath.ogg", "SFX") -- Eye Beam
        elseif spellName == "Darkness" then self:PlaySoundFile(addonpath.."sfx\\ow\\thedarkness.ogg", "SFX")
        -- Other
        elseif spellName == "Arcane Torrent" then self:PlaySoundFile(addonpath.."sfx\\ow\\shutup.ogg", "SFX")
        end
    elseif type == "SPELL_AURA_APPLIED" then
        local spell, spellName, spellSchool = select(12, ...)
        -- Hunter
        if spellName == "Freezing Trap" then self:PlaySoundFile(addonpath.."sfx\\ow\\gotcha.ogg", "SFX")
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
            self:PlaySoundFile(addonpath.."sfx\\bloodlust.ogg", "SFX")
            self:Print("Can you feel the Bloodlust? No? Then press that damn button!")
        end
    end
end
