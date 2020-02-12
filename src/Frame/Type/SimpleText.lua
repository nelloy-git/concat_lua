--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.FrameType')

--=======
-- Class
--=======

local SimpleTextType = Class.new('SimpleTextType', FrameType)
---@class SimpleTextType
local public = SimpleTextType.public
---@class SimpleTextTypeClass
local static = SimpleTextType.static
---@type SimpleTextTypeClass
local override = SimpleTextType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param child_instance SimpleTextType | nil
---@return SimpleTextType
function override.new(uniq_name, child_instance)
    local instance = child_instance or Class.allocate(SimpleTextType)
    instance = FrameType.new(uniq_name, private.createFdf, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return boolean
function public:isSimple()
    return true
end

---@return string
function public:getStringFrameName()
    return private.getStringName(self:getName())
end

---@param width number
function public:setWidth(width)
    private.data[self].width = width

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.SimpleFrame.Field.Width, width)
    end
end

---@param height number
function public:setHeight(height)
    private.data[self].height = height

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.SimpleFrame.Field.Height, height)
    end
end

---@param font string
function public:setFont(font)
    private.data[self].font = font

    local fdf = self:getFdf()
    if fdf then
        local string_fdf = fdf:getField(private.SimpleFrame.Field.String)[1]
        string_fdf:setField(private.SimpleString.Field.Font, {font, private.data[self].font_size})
    end
end

---@param font_size number
function public:setFontSize(font_size)
    private.data[self].font_size = font_size

    local fdf = self:getFdf()
    if fdf then
        local string_fdf = fdf:getField(private.SimpleFrame.Field.String)[1]
        string_fdf:setField(private.SimpleString.Field.Font, {private.data[self].font, font_size})
    end
end

function public:setAnchor(anchor)
    private.data[self].anchor = anchor

    local fdf = self:getFdf()
    if fdf then
        local string_fdf = fdf:getField(private.SimpleFrame.Field.String)[1]
        string:setField(private.SimpleString.Field.Anchor, {anchor, 0, 0})
    end
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
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

---@param name string
---@return string
function private.getStringName(name)
    return name..'String'
end

---@param self SimpleButton
function private.newData(self)
    priv = {
        width = private.default_width,
        height = private.default_height,
        font = private.default_font,
        font_size = private.default_font_size
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

private.default_width = 0.03
private.default_height = 0.03
private.default_font = 'fonts\\nim_____.ttf'
private.default_font_size = 0.009
private.default_anchor = 'CENTER'

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.File = FdfEdit.File
    private.SimpleFrame = FdfEdit.SimpleFrame
    private.SimpleString = FdfEdit.SimpleString
end)

---@param name string
---@return string
function private.createFdf(name)
    local frame = private.SimpleFrame.new(name)
    local fields = private.SimpleFrame.Field
    frame:setField(fields.Width, private.default_width)
    frame:setField(fields.Height, private.default_height)

    local string = private.SimpleString.new(private.getStringName(name))
    string:setField(private.SimpleString.Field.Font, {private.default_font, private.default_font_size})
    string:setField(private.SimpleString.Field.Anchor, {private.default_anchor, 0, 0})
    frame:setField(fields.String, {string})

    return frame
end

return static