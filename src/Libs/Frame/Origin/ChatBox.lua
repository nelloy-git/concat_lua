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

local handle = BlzGetOriginFrame(ORIGIN_FRAME_CHAT_MSG, 0)
BlzFrameClearAllPoints(handle)
---@class FrameOriginChatBox
local ChatBox = FrameNormalBase.new(handle)
ChatBox:setParent(nil)

return ChatBox