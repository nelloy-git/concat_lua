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
function public:setBar(texture)
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

---@param text string
function public:setText(text)
    local priv = private.data[self]
    priv.text = text

    if priv.color then
        BlzFrameSetText(priv.text_frame, string.format('|c%s%s|r', priv.color, priv.text))
    else
        BlzFrameSetText(priv.text_frame, text)
    end
end

---@param font string
function public:setFont(font)
    local priv = private.data[self]
    priv.font = font

    BlzFrameSetFont(priv.text_frame, font, priv.font_size, 0)
end

---@param size number
function public:setFontSize(size)
    local priv = private.data[self]
    priv.font_size = size

    BlzFrameSetFont(priv.text_frame, priv.font, size, 0)
end

---@param red number
---@param green number
---@param blue number
---@param alpha number
function public:setTextColor(red, green, blue, alpha)
    local priv = private.data[self]

    red = red or 0
    if red > 255 then red = 255 end
    if red < 0 then red = 0 end

    green = green or 0
    if green > 255 then green = 255 end
    if green < 0 then green = 0 end

    blue = blue or 0
    if blue > 255 then blue = 255 end
    if blue < 0 then blue = 0 end

    alpha = alpha or 0
    if alpha > 255 then alpha = 255 end
    if alpha < 0 then alpha = 0 end

    priv.color = string.format('%02x%02x%02x%02x', alpha, red, green, blue)
    BlzFrameSetText(priv.text_frame, string.format('|c%s%s|r', priv.color, priv.text))
end

---@param status number
function public:setStatus(status)
    private.data[self].status = status
    BlzFrameSetValue(self:getObj(), status)
end

---@return string
function public:getText()
    return private.data[self].text
end

---@return string
function public:getFont()
    return private.data[self].font
end

---@return number
function public:getFontSize()
    return private.data[self].font_size
end

---@return number
function public:getStatus()
    return private.data[self].status
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
        text = '',
        font = simple_bar_type:getFont(),
        font_size = simple_bar_type:getFontSize(),
        status = 0,
    }
    private.data[self] = priv

    BlzFrameSetMinMaxValue(self:getObj(), 0, 100)
end

return static