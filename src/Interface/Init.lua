local Interface = {}

---@type FrameLib
local FrameLib = require(LibList.FrameLib)
--local SBtn = FrameLib.SimpleButton
---@type InterfaceSkillsBarClass
--local SkillsBar = require('Interface.SkillsBar.SkillsBar')
---@type InterfaceSkillTooltipClass
--local SkillTooltip = require('Interface.SkillsBar.SkillTooltip')

if IsCompiletime() then
    return
end

--================
-- Free origin UI
--================

local console_ui_backdrop = BlzGetFrameByName("ConsoleUIBackdrop", 0)
BlzFrameSetAbsPoint(console_ui_backdrop, FRAMEPOINT_TOP, 0.4, 0)

local function freeFrame(handle)
    BlzFrameSetParent(handle, console_ui_backdrop)
    BlzFrameClearAllPoints(handle)
end

-- Free minimap
freeFrame(BlzGetFrameByName("MiniMapFrame", 0))
-- Free chat
freeFrame(BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 7))
-- Free chat edit
freeFrame(BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 11))
-- Free command buttons
for i = 0, 11 do
    freeFrame(BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, i))
end

-- Hide portrait
BlzFrameSetVisible(BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, 0))
-- Hide inventory
BlzFrameSetVisible(BlzFrameGetParent(BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_ITEM_BUTTON, 0))), false)

return Interface