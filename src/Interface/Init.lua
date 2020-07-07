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

Interface.SkillsBar = SkillsBar.new(4)
Interface.SkillsBar:setX(0.4)
Interface.SkillsBar:setY(0.3)

return Interface