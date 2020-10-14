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

local handle = BlzGetFrameByName("MiniMapFrame", 0)
BlzFrameClearAllPoints(handle)

---@class FrameOriginMinimap
local Minimap = Frame.link(handle, false)
Minimap:setParent(nil)

return Minimap