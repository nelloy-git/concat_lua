--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame or error('')

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
    SkillButton[i + 1] = Frame.link(handle, false)
    SkillButton[i + 1]:setParent(nil)
end

return SkillButton