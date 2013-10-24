LSM = LibStub("LibSharedMedia-3.0")
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar01", [[Interface\Addons\MystlerUI\tex\MystlerBar01]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar02", [[Interface\Addons\MystlerUI\tex\MystlerBar02]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar03", [[Interface\Addons\MystlerUI\tex\MystlerBar03]])
LSM:Register(LSM.MediaType.STATUSBAR, "MystlerBar04", [[Interface\Addons\MystlerUI\tex\MystlerBar04]])

-- Event Handling
local frame, events = CreateFrame("Frame"), {};
function events:PLAYER_DEAD(...)
    PlaySoundFile([[Interface\Addons\MystlerUI\sfx\defeat.ogg]], "Master")
end

-- Event Dispatcher
frame:SetScript("OnEvent", function(self, event, ...) events[event](self, ...); end);
for k, v in pairs(events) do
    frame:RegisterEvent(k);
end
