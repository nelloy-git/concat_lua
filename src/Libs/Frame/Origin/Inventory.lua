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

local handle = BlzFrameGetParent(BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_ITEM_BUTTON, 0)))
BlzFrameClearAllPoints(handle)

---@class FrameOriginInventory
local Inventory = Frame.link(handle, false)
Inventory:setParent(nil)

return Inventory