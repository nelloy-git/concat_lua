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

local handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
--BlzFrameClearAllPoints(handle)

---@class FrameOriginGameUI
local GameUI = Frame.link(handle, false)
--Inventory:setParent(nil)

return GameUI