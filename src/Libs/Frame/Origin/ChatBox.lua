--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_modname..'.Normal.Base')

--========
-- Module
--========

if IsCompiletime() then
    return
end

local handle = BlzGetOriginFrame(ORIGIN_FRAME_CHAT_MSG, 0)
BlzFrameClearAllPoints(handle)
---@class ChatBox
local ChatBox = FrameNormalBase.new(handle)
ChatBox:setParent(nil)

return ChatBox