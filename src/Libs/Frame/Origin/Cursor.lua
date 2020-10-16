--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame or error('')
local Timer = HandleLib.Timer or error('')

---@type FrameNormalImageClass
local Image = require(lib_path..'Normal.Image') or error('')


--========
-- Module
--========

if IsCompiletime() then
    return
end

local count = BlzFrameGetChildrenCount(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0))
local handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), count - 1)
BlzFrameClearAllPoints(handle)

---@class FrameOriginCursor
local Cursor = Frame.link(handle, false)

return Cursor