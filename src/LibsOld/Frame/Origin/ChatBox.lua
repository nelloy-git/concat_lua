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

local handle = BlzGetOriginFrame(ORIGIN_FRAME_CHAT_MSG, 0)
BlzFrameClearAllPoints(handle)

---@class FrameOriginChatBox
local ChatBox = Frame.link(handle, false)
ChatBox:setParent(nil)

return ChatBox