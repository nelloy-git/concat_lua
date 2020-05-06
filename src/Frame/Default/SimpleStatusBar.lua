--=========
-- Include
--=========


local Class = require(Lib.Class)

---@type FrameClass
local Frame = require('Frame.Frame')
---@type SimpleStatusBarTypeClass
local SimpleStatusBarType = require('Frame.Type.SimpleStatusBar')

--=======
-- Class
--=======

local SimpleStatusBar = Class.new('SimpleStatusBar', Frame)
---@class SimpleStatusBar : Frame
local public = SimpleStatusBar.public
---@class SimpleStatusBarClass : FrameClass
local static = SimpleStatusBar.static
---@type SimpleStatusBarClass
local override = SimpleStatusBar.override
local private = {}

--=========
-- Static
--=========

---@param frame_type SimpleStatusBar
---@param child_instance SimpleStatusBar | nil
---@return SimpleStatusBar
function override.new(frame_type, child_instance)
    if not Class.type(frame_type, SimpleStatusBarType) then
        Log.error(SimpleStatusBar, '\"simple_button_type\" must be SimpleStatusBar', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleStatusBar) then
        Log.error(SimpleStatusBar, '\"child_instance\" must be SimpleStatusBar or nil', 2)
    end

    local instance = child_instance or Class.allocate(SimpleStatusBar)
    instance = Frame.new(frame_type, instance)
    BlzFrameSetMinMaxValue(instance:getObj(), 0, 100)

    return instance
end

--========
-- Public
--========

---@param texture string
function public:setTexture(texture)
    BlzFrameSetTexture(self:getObj(), texture, 0, true)
end

---@param percent number
function public:setPercent(percent)
    BlzFrameSetValue(self:getObj(), percent)
end


return static