--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')

--=======
-- Class
--=======

local Text = Class.new('Text', Frame)
---@class Text : Frame
local public = Text.public
---@class TextClass : FrameClass
local static = Text.static
local override = Text.override
local private = {}

--========
-- Static
--========

---@param text_type TextType
---@param child_instance Text | nil
---@return Text
function override.new(text_type, child_instance)
    local instance = child_instance or Class.allocate(Text)
    instance = Frame.new(text_type, instance)
    private.newData(instance, text_type)

    return instance
end

--========
-- Public
--========

---@param text string
function public:setText(text)
    local priv = private.data[self]
    priv.text = text

    if priv.color then
        BlzFrameSetText(self:getObj(), string.format('|c%s%s|r', priv.color, priv.text))
    else
        BlzFrameSetText(self:getObj(), text)
    end
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
    BlzFrameSetText(priv.text_framehandle, string.format('|c%s%s|r', priv.color, priv.text))
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

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Text
---@param text_type TextType
function private.newData(self, text_type)
    local priv = {
        text = '',
        font = text_type:getFont(),
        font_size = text_type:getFontSize(),
        color = nil,
    }
    private.data[self] = priv
end

return Text