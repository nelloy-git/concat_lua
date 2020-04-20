--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.API')
local fmt = string.format

---@type SimpleFrameClass
local SimpleFrame = require('Frame.Default.SimpleFrame')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleStringTypeClass
local SimpleStringType = require('Frame.Type.SimpleString')

--=======
-- Class
--=======

local SimpleText = Class.new('SimpleText', SimpleFrame)
---@class SimpleText : SimpleFrame
local public = SimpleText.public
---@class SimpleTextClass : SimpleFrameClass
local static = SimpleText.static
---@type SimpleTextClass
local override = SimpleText.override
local private = {}

--=========
-- Static
--=========

---@param child_instance SimpleText | nil
---@return SimpleText
function override.new(child_instance)
    if child_instance and not Class.type(child_instance, SimpleText) then
        Log.error(SimpleText, fmt('\"child_instance\" must be %s or nil', tostring(SimpleText)), 2)
    end

    local instance = child_instance or Class.allocate(SimpleText)
    instance = SimpleFrame.new(private.text_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param text string | nil
function public:setText(text)
    local priv = private.data[self]
    text = text or ''

    print('set:', text)
    priv.text = text
    --BlzFrameSetText(priv.text_handle, priv.color..text..'|r')
    BlzFrameSetText(priv.text_handle, text)
end

---@param red number | nil
---@param green number | nil
---@param blue number | nil
---@param alpha number | nil
function public:setColor(red, green, blue, alpha)
    local priv = private.data[self]

    red = math.max(math.min(red or 255, 255), 0)
    green = math.max(math.min(green or 255, 255), 0)
    blue = math.max(math.min(blue or 255, 255), 0)
    alpha = math.max(math.min(alpha or 255, 255), 0)
    priv.color = string.format('|c%x%x%x%x', alpha, red, green, blue)
    BlzFrameSetText(priv.text_handle, priv.color..priv.text..'|r')
end

---@param font string
function public:setFont(font)
    local priv = private.data[self]

    priv.font = font
    BlzFrameSetFont(priv.text_handle, font, priv.size, 0)
end

---@param size number
function public:setFontSize(size)
    local priv = private.data[self]

    priv.font_size = size
    BlzFrameSetFont(priv.text_handle, priv.font, size, 0)
end

---@param vert textaligntype | 'TEXT_JUSTIFY_LEFT' | 'TEXT_JUSTIFY_CENTER' | 'TEXT_JUSTIFY_RIGHT'
---@param horz textaligntype | 'TEXT_JUSTIFY_TOP' | 'TEXT_JUSTIFY_MIDDLE' | 'TEXT_JUSTIFY_BOTTOM'
function public:setAlignment(vert, horz)
    BlzFrameSetTextAlignment(private.data[self].text_handle, vert, horz)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.active = setmetatable({}, {__mode = 'k'})

private.default_font = 'fonts\\nim_____.ttf'
private.default_font_size = 0.008
private.default_color = '|cFFFFFFFF'

private.text_type = SimpleFrameType.new('SimpleText', true)
private.text_type:setWidth(0.05)
private.text_type:setHeight(0.05)
    local text_string = SimpleStringType.new('SimpleTextString', false)
    text_string:setFont(private.default_font, private.default_font_size)
    text_string:setAllPoints()
private.text_type:setChildrens({text_string})


---@param self SimpleText
function private.newData(self)
    local priv = {
        text_handle = BlzGetFrameByName('SimpleTextString', 0),

        font = private.default_font,
        font_size = private.default_font_size,
        color = private.default_color,
        text = ''
    }
    private.data[self] = priv
end

return static