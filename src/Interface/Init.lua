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

--HideDefaultUI.hide()

---@param skills_bar InterfaceSkillsBar
---@param prev_w number
---@param prev_h number
---@param new_w number
---@param new_h number
local function skillsBarAutoPositioning(skills_bar, prev_w, prev_h, new_w, new_h)
    skills_bar:setPos((new_w - skills_bar:getWidth()) / 2, 0)

    -- Minimap
    local minimap = BlzGetFrameByName("MiniMapFrame", 0)
    BlzFrameSetAbsPoint(minimap, FRAMEPOINT_BOTTOMLEFT, FrameLib.getScreenLeftX(), 0)
end

Interface.SkillsBar = SkillsBar.new(4)
Interface.SkillsBar:setUpdateResolutionCallback(skillsBarAutoPositioning)

return Interface