--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.API')
local fmt = string.format

---@type Import
local Import = require('Resources.Import')
---@type SimpleFrameClass
local SimpleFrame = require('Frame.Default.SimpleFrame')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleTextureTypeClass
local SimpleTextureType = require('Frame.Type.SimpleTexture')

--=======
-- Class
--=======

local SimpleImage = Class.new('SimpleImage', SimpleFrame)
---@class SimpleImage : SimpleFrame
local public = SimpleImage.public
---@class SimpleImageClass : SimpleFrameClass
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
        Log.error(SimpleImage, '\"child_instance\" must be SimpleImage or nil', 2)
    end

    local instance = child_instance or Class.allocate(SimpleImage)
    instance = SimpleFrame.new(private.frame_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param texture string | nil
function public:setTexture(texture)
    texture = texture or Import.TransparentTexture
    BlzFrameSetTexture(private.data[self].texture_handle, texture, 0, true)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.frame_type = SimpleFrameType.new('SimpleImage', true)
private.frame_type:setWidth(0.05)
private.frame_type:setHeight(0.05)
    local image_texture = SimpleTextureType.new('SimpleImageTexture', false)
    image_texture:setAllPoints()
private.frame_type:setChildrens({image_texture})


---@param self SimpleImage
function private.newData(self)
    local priv = {
        texture_handle = BlzGetFrameByName('SimpleImageTexture', 0),
    }
    private.data[self] = priv
end

return static