--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_modname..'.Normal.Base')

--========
-- Module
--========

if IsCompiletime() then
    return
end

local SkillButton = {}

for i = 0, 11 do
    local handle = BlzGetFrameByName("CommandButton_"..tonumber(i), 0)
    BlzFrameClearAllPoints(handle)

    ---@class SkillButton
    SkillButton[i + 1] = FrameNormalBase.new(handle)
    SkillButton[i + 1]:setParent(nil)
    SkillButton[i + 1]:setSize(0.03, 0.03)
end

return SkillButton