--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameClass
local Frame = require('Class.Frame.Frame')

--=======
-- Class
--=======

local FrameSimpleText = Class.new('FrameSimpleText', Frame)
---@class FrameSimpleText : Frame
local public = FrameSimpleText.public
---@class FrameSimpleTextClass : FrameClass
local static = FrameSimpleText.static
---@type FrameSimpleTextClass
local override = FrameSimpleText.override
local private = {}

--=========
-- Static
--=========

---@param simple_text_type SimpleTextType
---@param child_instance FrameSimpleText
---@return FrameSimpleText
function override.new(simple_text_type, child_instance)
    local instance = child_instance or Class.allocate(FrameSimpleText)
    instance = Frame.new(simple_text_type, instance)
    private.newData(instance, simple_text_type)

    return instance
end

--========
-- Public
--========

---@param text string
function public:setText(text)
    local priv = private[self]
    priv.text = text

    BlzFrameSetText(priv.text_framehandle, text)
end

---@return string
function public:getText()
    return private[self].text
end

---@param font string
---@param size number
function public:setFont(font, size)
    local priv = private[self]
    priv.font = font
    priv.font_size = size

    BlzFrameSetFont(priv.text_framehandle, font, size, 0)
end

function public:getFont()
    return private

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FrameSimpleText
---@param simple_text_type SimpleTextType
function private.newData(self, simple_text_type)
    local priv = {
        text_framehandle = BlzGetFrameByName(simple_text_type:getStringName(), 0),
        text = '',
        font = '',
        font_size = 0,
    }
    private[self] = priv
end

---@param self FrameSimpleText
function private.freeData(self)
    private[self] = nil
end

return static