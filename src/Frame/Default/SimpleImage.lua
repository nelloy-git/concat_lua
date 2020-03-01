--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')
local fmt = string.format

---@type Import
local Import = require('Resouces.Import')
---@type FrameClass
local Frame = require('Frame.Frame')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleTextureTypeClass
local SimpleTextureType = require('Frame.Type.SimpleTexture')

--=======
-- Class
--=======

local SimpleImage = Class.new('SimpleImage', Frame)
---@class SimpleImage : Frame
local public = SimpleImage.public
---@class SimpleImageClass : FrameClass
local static = SimpleImage.static
---@type SimpleImageClass
local override = SimpleImage.override
local private = {}

--=========
-- Static
--=========

---@param child_instance SimpleImage | nil
---@return SimpleImage
function override.new(child_instance)
    if child_instance and not Class.type(child_instance, SimpleImage) then
        Log.error(SimpleImage, fmt('\"child_instance\" must be %s or nil', tostring(SimpleImage)), 2)
    end

    local instance = child_instance or Class.allocate(SimpleImage)
    instance = Frame.new(private.image_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param texture string | nil
function public:setTexture(texture)
    local priv = private.data[self]

    priv.texture = texture
    if not texture then
        texture = Import.TransparentTexture
    end

    BlzFrameSetTexture(private.data[self].texture_handle, texture, 0, true)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.active = setmetatable({}, {__mode = 'k'})

private.image_type = SimpleFrameType.new('SimpleImage', true)
private.image_type:setWidth(0.05)
private.image_type:setHeight(0.05)
    local image_texture = SimpleTextureType.new('SimpleImageTexture', false)
    image_texture:setWidth(0.05)
    image_texture:setHeight(0.05)
    image_texture:setAnchor('CENTER', 0, 0)
private.image_type:setChildrens({image_texture})


---@param self SimpleImage
function private.newData(self)
    local priv = {
        texture_handle = BlzGetFrameByName('SimpleImageTexture', 0),

        texture = nil
    }
end

return static