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

local handle = BlzGetFrameByName("MiniMapFrame", 0)
BlzFrameClearAllPoints(handle)
---@class Minimap
local Minimap = FrameNormalBase.new(handle)
Minimap:setParent(nil)

return Minimap