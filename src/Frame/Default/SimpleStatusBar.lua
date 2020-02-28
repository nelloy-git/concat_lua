--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

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
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param texture string
function public:setTexture(texture)
    private.data[self].texture = texture
    BlzFrameSetTexture(self:getObj(), texture, 0, true)
end

---@param percent number
function public:setPercent(percent)
    private.data[self].percent = percent
    BlzFrameSetValue(self:getObj(), percent)
end

---@return string
function public:getTexture()
    return private.data[self].texture
end

---@return number
function public:getPercent()
    return private.data[self].percent
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleStatusBar
---@param frame_type SimpleStatusBar
function private.newData(self, frame_type)
    local priv = {
        texture = frame_type:getTexture(),
        percent = 0,
    }
    private.data[self] = priv

    BlzFrameSetMinMaxValue(self:getObj(), 0, 100)
end

return static