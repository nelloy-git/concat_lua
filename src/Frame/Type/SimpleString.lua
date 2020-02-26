--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

local SimpleStringType = Class.new('SimpleStringType', FrameType)
---@class SimpleStringType
local public = SimpleStringType.public
---@class SimpleStringTypeClass
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
    local instance = child_instance or Class.allocate(SimpleStringType)
    instance = FrameType.new(uniq_name, private.createFdf, separate_file, instance)
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
        fdf:setField(private.SimpleString.Field.Font, {font, size})
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