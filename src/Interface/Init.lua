local Interface = {}

---@type SimpleButton
local SBtn = require(LibList.FrameLib).SimpleButton
---@type InterfaceSkillsBarClass
local SkillsBar = require('Interface.SkillsBar.SkillsBar')
---@type InterfaceSkillTooltipClass
local SkillTooltip = require('Interface.SkillsBar.SkillTooltip')

if IsCompiletime() then
    return
end

function HideOriginUI(name, index)
    local fh = BlzGetOriginFrame(name, index)
    BlzFrameClearAllPoints(fh)
    BlzFrameSetAbsPoint(fh, FRAMEPOINT_CENTER, 3, 3)
    BlzFrameSetScale(fh, 0.001)
end

function HideUI(name, index)
    local fh = BlzGetFrameByName(name, index)
    BlzFrameClearAllPoints(fh)
    BlzFrameSetAbsPoint(fh, FRAMEPOINT_CENTER, 3, 3)
    BlzFrameSetScale(fh, 0.001)
end

-- Hide origin frames.
for i=0,11 do
    --HideOriginUI(ORIGIN_FRAME_MINIMAP, i)
    HideOriginUI(ORIGIN_FRAME_ITEM_BUTTON, i)
    --HideOriginUI(ORIGIN_FRAME_COMMAND_BUTTON, i)
    --HideOriginUI(ORIGIN_FRAME_SYSTEM_BUTTON, i)
    HideOriginUI(ORIGIN_FRAME_PORTRAIT, i)
    --HideOriginUI(ORIGIN_FRAME_MINIMAP, i)
    --HideOriginUI(ORIGIN_FRAME_MINIMAP_BUTTON, i)
    HideOriginUI(ORIGIN_FRAME_TOOLTIP, i)
    HideOriginUI(ORIGIN_FRAME_UBERTOOLTIP, i)
    HideOriginUI(ORIGIN_FRAME_TOP_MSG, i)
    HideUI("ResourceBarFrame", i)
    HideUI("ConsoleUI", i)
end
BlzFrameSetAllPoints(BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0))
--BlzHideOriginFrames(true)
BlzFrameSetVisible(BlzGetFrameByName("ConsoleUIBackdrop",0), false)

Interface.SkillsBar = SkillsBar.new(4)
Interface.SkillsBar:setX(0.4 - Interface.SkillsBar:getWidth()/2)
Interface.SkillsBar:setY(0)

return Interface