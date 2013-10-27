-- AddOn setup
MystlerUI = LibStub("AceAddon-3.0"):NewAddon("MystlerUI", "AceConsole-3.0", "AceEvent-3.0");

-- Register new textures with LibSharedMedia
LSM = LibStub("LibSharedMedia-3.0");
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar01", [[Interface\Addons\MystlerUI\tex\MystlerBar01]]);
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar02", [[Interface\Addons\MystlerUI\tex\MystlerBar02]]);
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar03", [[Interface\Addons\MystlerUI\tex\MystlerBar03]]);
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar04", [[Interface\Addons\MystlerUI\tex\MystlerBar04]]);

function MystlerUI:OnInitialize()
    -- Initialize member variables
    MystlerUI.PoisonOK = true;
end

function MystlerUI:OnEnable()
    -- Register events
    MystlerUI:RegisterEvent("PLAYER_DEAD");
    MystlerUI:RegisterEvent("UNIT_AURA");
end

function MystlerUI:OnDisable()
    -- Unregister events
    MystlerUI:UnregisterAllEvents();
end

-- Rogue: Poison alert sound check
function MystlerUI:PoisonAlert()
    if (not UnitBuff("player", "Deadly Poison") and
            not UnitBuff("player", "Wound Poison")) or
            (not UnitBuff("player", "Leeching Poison") and
            not UnitBuff("player", "Crippling Poison") and
            not UnitBuff("player", "Mind-numbing Poison")) then
        if MystlerUI.PoisonOK then
            PlaySoundFile([[Interface\Addons\MystlerUI\sfx\poison.ogg]], "Master");
            MystlerUI:Print("One of your poisons is missing. Remember to reapply it!");
        end
        MystlerUI.PoisonOK = false;
    else
        MystlerUI.PoisonOK = true;
    end
end

-- Events
function MystlerUI:PLAYER_DEAD()
    PlaySoundFile([[Interface\Addons\MystlerUI\sfx\defeat.ogg]], "Master");
    MystlerUI:Print("OMG, you are dead... Try to die less next time, okay?");
end

function MystlerUI:UNIT_AURA(event, unit)
    if unit == "player" then
        if UnitClass("player") == "Rogue" then
            MystlerUI:PoisonAlert();
        end
    end
end
