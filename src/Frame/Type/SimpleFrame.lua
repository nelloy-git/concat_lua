--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.FrameType')

--=======
-- Class
--=======

local SimpleFrameType = Class.new('SimpleFrameType', FrameType)
---@class SimpleFrameType  : FrameType
local public = SimpleFrameType.public
---@class SimpleFrameTypeClass : FrameTypeClass
local static = SimpleFrameType.static
---@type SimpleFrameTypeClass
local override = SimpleFrameType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param child_instance SimpleFrameType | nil
---@return SimpleFrameType
function override.new(uniq_name, child_instance)
    local instance = child_instance or Class.allocate(SimpleFrameType)
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

---@param texture string
function public:setTexture(texture)
    private.data[self].texture = texture

    local fdf = self:getFdf()
    if fdf then
        local texture_fdf = fdf:getField(private.SimpleFrame.Field.Texture)[1]
        texture_fdf:setField(private.SimpleTexture.Field.File, texture)
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
function public:getTexture()
    return private.data[self].texture
end

---@return string
function public:getTextureFrameName()
    return private.getTextureName(self:getName())
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param name string
---@return string
function private.getTextureName(name)
    return name..'Texture'
end

---@param self SimpleFrame
function private.newData(self)
    priv = {
        width = private.default_width,
        height = private.default_height,
        texture = private.default_texture
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

private.default_width = 0.03
private.default_height = 0.03
private.default_texture = 'ReplaceableTextures\\CommandButtons\\BTNHeroPaladin'

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.File = FdfEdit.File
    private.SimpleFrame = FdfEdit.SimpleFrame
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param name string
---@return string
function private.createFdf(name)
    local frame = private.SimpleFrame.new(name)
    local fields = private.SimpleFrame.Field
    frame:setField(fields.Width, private.default_width)
    frame:setField(fields.Height, private.default_height)

    local texture = private.SimpleTexture.new(private.getTextureName(name))
    texture:setField(private.SimpleTexture.Field.File, private.default_texture)
    frame:setField(fields.Texture, {texture})

    return frame
end

return static