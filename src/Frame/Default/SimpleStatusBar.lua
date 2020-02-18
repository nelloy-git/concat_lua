--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')
---@type FrameObj
local FrameObj = require('Object.Frame')

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

---@param simple_bar_type SimpleStatusBar
---@param child_instance SimpleStatusBar | nil
---@return SimpleStatusBar
function override.new(simple_bar_type, child_instance)
    local instance = child_instance or Class.allocate(SimpleStatusBar)
    instance = Frame.new(simple_bar_type, instance)
    private.newData(instance, simple_bar_type)

    return instance
end

--========
-- Public
--========

---@param texture string
function public:setBackground(texture)
    local priv = private.data[self]
    priv.background = texture
    BlzFrameSetTexture(priv.background_frame, texture, 0, true)
end

---@param texture string
function public:setBackground(texture)
    local priv = private.data[self]
    priv.bar = texture
    BlzFrameSetTexture(self:getObj(), texture, 0, true)
end

---@return string
function public:getBackground()
    return private.data[self].background
end

---@return string
function public:getBar()
    return private.data[self].bar
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleStatusBar
---@param simple_bar_type SimpleStatusBar
function private.newData(self, simple_bar_type)
    local priv = {
        background_frame = BlzGetFrameByName(simple_bar_type:getBackgroundFrameName(), 0),
        text_frame = BlzGetFrameByName(simple_bar_type:getTextFrameName(), 0),

        background = simple_bar_type:getBackground(),
        bar = simple_bar_type:getBar(),
        font = simple_bar_type:getFont(),
        font_size = simple_bar_type:getFontSize(),
    }
    private.data[self] = priv
end

return static