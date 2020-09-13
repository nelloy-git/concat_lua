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

local handle = BlzGetFrameByName("MiniMapFrame", 0)
BlzFrameClearAllPoints(handle)
---@class FrameOriginMinimap
local Minimap = FrameNormalBase.new(handle)
Minimap:setParent(nil)

return Minimap