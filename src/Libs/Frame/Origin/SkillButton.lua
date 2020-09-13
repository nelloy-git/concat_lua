--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_path..'.Normal.Base')

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

    ---@class FrameOriginSkillButton
    SkillButton[i + 1] = FrameNormalBase.new(handle)
    SkillButton[i + 1]:setParent(nil)
end

return SkillButton