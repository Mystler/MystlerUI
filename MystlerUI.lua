LSM = LibStub("LibSharedMedia-3.0");
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar01", [[Interface\Addons\MystlerUI\tex\MystlerBar01]]);
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar02", [[Interface\Addons\MystlerUI\tex\MystlerBar02]]);
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar03", [[Interface\Addons\MystlerUI\tex\MystlerBar03]]);
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar04", [[Interface\Addons\MystlerUI\tex\MystlerBar04]]);

-- Rogue Poison Alert
local function PoisonAlert()
    if not UnitBuff("player", "Deadly Poison") and
            not UnitBuff("player", "Wound Poison") then
        PlaySoundFile([[Interface\Addons\MystlerUI\sfx\poison.ogg]], "Master");
        return;
    end
    if not UnitBuff("player", "Leeching Poison") and
            not UnitBuff("player", "Crippling Poison") and
            not UnitBuff("player", "Mind-numbing Poison") then
        PlaySoundFile([[Interface\Addons\MystlerUI\sfx\poison.ogg]], "Master");
        return;
    end
end

-- Event Handling
local frame, events = CreateFrame("Frame"), {};
function events:PLAYER_DEAD(...)
    PlaySoundFile([[Interface\Addons\MystlerUI\sfx\defeat.ogg]], "Master");
end
function events:UNIT_AURA(...)
    local unit = ...;
    if unit == "player" then
        if UnitClass("player") == "Rogue" then
            PoisonAlert();
        end
    end
end

-- Event Dispatcher
frame:SetScript("OnEvent", function(self, event, ...) events[event](self, ...); end);
for k, v in pairs(events) do
    frame:RegisterEvent(k);
end
