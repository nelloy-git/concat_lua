--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

local SimpleTextureType = Class.new('SimpleTextureType', FrameType)
---@class SimpleTextureType : FrameType
local public = SimpleTextureType.public
---@class SimpleTextureTypeClass : FrameTypeClass
local static = SimpleTextureType.static
---@type SimpleTextureTypeClass
local override = SimpleTextureType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance SimpleTextureType | nil
---@return SimpleTextureType
function override.new(uniq_name, separate_file, child_instance)
    if FrameType.isExist(uniq_name) then
        Log.error(SimpleTextureType, '\"uniq_name\" must be unique.', 2)
    end

    if type(separate_file) ~= 'boolean' then
        Log.error(SimpleTextureType, '\"separate_file\" must be boolean.', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleTextureType) then
        Log.error(SimpleTextureType, '\"child_instance\" must be SimpleTextureType or nil.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleTextureType)
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

---@param texture string
function public:setTexture(texture)
    private.data[self].texture = texture

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.File, texture)
    end
end

---@param min_x number
---@param min_y number
---@param max_x number
---@param max_y number
function public:setTexCoord(min_x, min_y, max_x, max_y)
    local priv = private.data[self]

    priv.tex_min_x = min_x
    priv.tex_min_y = min_y
    priv.tex_max_x = max_x
    priv.tex_max_y = max_y

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.TexCoord, {min_x, min_y, max_x, max_y})
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

---@return string | nil
function public:getTexture()
    return private.data[self].texture
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleFrameType
function private.newData(self)
    priv = {
        width = nil,
        height = nil,

        texture = nil,
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.SimpleTexture = FdfEdit.SimpleTexture
    private.Field = FdfEdit.SimpleTexture.Field
end)

---@param name string
---@return string
function private.createFdf(name)
    return private.SimpleTexture.new(name)
end

return static