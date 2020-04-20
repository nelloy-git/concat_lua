--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

local SimpleStringType = Class.new('SimpleStringType', FrameType)
---@class SimpleStringType : FrameType
local public = SimpleStringType.public
---@class SimpleStringTypeClass : FrameTypeClass
local static = SimpleStringType.static
---@type SimpleStringTypeClass
local override = SimpleStringType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance SimpleStringType | nil
---@return SimpleStringType
function override.new(uniq_name, separate_file, child_instance)
    if FrameType.isExist(uniq_name) then
        Log.error(SimpleStringType, '\"uniq_name\" must be unique.', 2)
    end

    if type(separate_file) ~= 'boolean' then
        Log.error(SimpleStringType, '\"separate_file\" must be boolean.', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleStringType) then
        Log.error(SimpleStringType, '\"child_instance\" must be SimpleStringType or nil.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleStringType)
    instance = FrameType.new(uniq_name, private.createFdf, separate_file, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Can not be used with width, height and anchor parameters.
function public:setAllPoints()
    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.SetAllPoints, '')
    end
end

---@param anchor string | 'TOPLEFT' | 'TOP' | 'TOPRIGHT' | 'LEFT' | 'CENTER' | 'RIGHT' | 'BOTTOMLEFT' | 'BOTTOM' | 'RIGHT'
---@param offset_x number
---@param offset_y number
function public:setAnchor(anchor, offset_x, offset_y)
    private.data[self].anchor = anchor
    private.data[self].anchor_x = offset_x
    private.data[self].anchor_y = offset_y

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Anchor, {anchor, offset_x, offset_y})
    end
end

---@param width number
function public:setWidth(width)
    private.data[self].width = width

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Width, width)
    end
end

---@param height number
function public:setHeight(height)
    private.data[self].height = height

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Height, height)
    end
end

---@param font string
function public:setFont(font, size)
    private.data[self].font = font
    private.data[self].font_size = size

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Font, {font, size})
    end
end

---@param text string
function public:setText(text)
    private.data[self].text = text

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Text, text)
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

---@return string
function public:getText()
    return private.data[self].text
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleButton
function private.newData(self)
    local priv = {
        width = nil,
        height = nil,

        font = nil,
        font_size = nil,
        text = nil,
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.SimpleString = FdfEdit.SimpleString
    private.Field = FdfEdit.SimpleString.Field
end)

---@param name string
---@return string
function private.createFdf(name)
    return private.SimpleString.new(name)
end

return static