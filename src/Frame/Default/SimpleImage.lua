--=========
-- Include
--=========


local Class = require(Lib.Class)
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

local SimpleImage1 = Class.new('SimpleImage1', SimpleFrame)
---@class SimpleImage1 : SimpleFrame
local public = SimpleImage1.public
---@class SimpleImage1Class : SimpleFrameClass
local static = SimpleImage1.static
---@type SimpleImage1Class
local override = SimpleImage1.override
local private = {}

--=========
-- Static
--=========

---@param child_instance SimpleImage1 | nil
---@return SimpleImage1
function override.new(child_instance)
    if child_instance and not Class.type(child_instance, SimpleImage1) then
        Log.error(SimpleImage1, '\"child_instance\" must be SimpleImage1 or nil', 2)
    end

    local instance = child_instance or Class.allocate(SimpleImage1)
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

private.frame_type = SimpleFrameType.new('SimpleImage1', true)
private.frame_type:setWidth(0.05)
private.frame_type:setHeight(0.05)
    local image_texture = SimpleTextureType.new('SimpleImage1Texture', false)
    image_texture:setAllPoints()
private.frame_type:setChildrens({image_texture})


---@param self SimpleImage1
function private.newData(self)
    local priv = {
        texture_handle = BlzGetFrameByName('SimpleImage1Texture', 0),
    }
    private.data[self] = priv
end

return static