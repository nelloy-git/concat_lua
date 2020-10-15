--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame or error('')
local Timer = HandleLib.Timer or error('')

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
--Cursor:setParent(nil)

Timer.new():start(0.01, true, function()
    BlzFrameSetTexture(handle, '', 0, true)
    BlzFrameSetVertexColor(handle, BlzConvertColor(255, 255, 255, 1))
end)

return Cursor