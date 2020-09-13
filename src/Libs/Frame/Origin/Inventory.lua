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

local handle = BlzFrameGetParent(BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_ITEM_BUTTON, 0)))
BlzFrameClearAllPoints(handle)
---@class FrameOriginInventory
local Inventory = FrameNormalBase.new(handle)
Inventory:setParent(nil)

return Inventory