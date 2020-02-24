--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

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
---@param separate_file boolean
---@param child_instance SimpleFrameType | nil
---@return SimpleFrameType
function override.new(uniq_name, separate_file, child_instance)
    local instance = child_instance or Class.allocate(SimpleFrameType)
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
        local texture_fdf = fdf:getField(private.Field.Texture)[1]
        texture_fdf:setField(private.SimpleTexture.Field.File, texture)
    end
end

---@param list FrameType[]
function public:setChildrens(list)
    for i = 1, #list do
        if not list[i]:isSimple() then
            Log.error(self, 'Normal frame can not be a child of simple frame.', 2)
        end
    end

    private.data[self].childrens = list

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.ChildFrames, list)
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

---@return FrameType[]
function public:getChildrens()
    return private.data[self].childrens
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
        texture = private.default_texture,
        childrens = {},
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
    private.Field = FdfEdit.SimpleFrame.Field
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param name string
---@return string
function private.createFdf(name)
    local frame = private.SimpleFrame.new(name)
    frame:setField(private.Field.Width, private.default_width)
    frame:setField(private.Field.Height, private.default_height)

    local texture = private.SimpleTexture.new(private.getTextureName(name))
    texture:setField(private.SimpleTexture.Field.File, private.default_texture)

    frame:setField(private.Field.Texture, {texture})

    return frame
end

return static