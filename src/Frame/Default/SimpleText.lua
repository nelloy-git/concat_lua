--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')

--=======
-- Class
--=======

local SimpleText = Class.new('SimpleText', Frame)
---@class SimpleText : Frame
local public = SimpleText.public
---@class SimpleTextClass : FrameClass
local static = SimpleText.static
---@type SimpleTextClass
local override = SimpleText.override
local private = {}

--=========
-- Static
--=========

---@param simple_text_type SimpleTextType
---@param child_instance SimpleText
---@return SimpleText
function override.new(simple_text_type, child_instance)
    local instance = child_instance or Class.allocate(SimpleText)
    instance = Frame.new(simple_text_type, instance)
    private.newData(instance, simple_text_type)

    return instance
end

--========
-- Public
--========

---@param text string
function public:setText(text)
    local priv = private.data[self]
    priv.text = text

    BlzFrameSetText(priv.text_framehandle, text)
end

---@return string
function public:getText()
    return private.data[self].text
end

---@param font string
function public:setFont(font)
    local priv = private.data[self]
    priv.font = font

    print(self, priv.font_size)
    BlzFrameSetFont(priv.text_framehandle, font, priv.font_size, 0)
end

---@param size number
function public:setFontSize(size)
    local priv = private.data[self]
    priv.font_size = size

    print(self, size)
    BlzFrameSetFont(priv.text_framehandle, priv.font, size, 0)
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

---@param self SimpleText
---@param simple_text_type SimpleTextType
function private.newData(self, simple_text_type)
    local priv = {
        text_framehandle = BlzGetFrameByName(simple_text_type:getStringName(), 0),
        text = '',
        font = simple_text_type:getDefaultFont(),
        font_size = simple_text_type:getDefaultFontSize(),
    }
    private.data[self] = priv
end

return static