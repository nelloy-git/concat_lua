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

local handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 11)
BlzFrameClearAllPoints(handle)

--- Can not be moved outside of default 0.8x0.6 box.
---@class FrameOriginChatEditBox
local ChatEditBox = Frame.link(handle, false)
ChatEditBox:setParent(nil)

return ChatEditBox