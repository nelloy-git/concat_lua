--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
---@type BaseSimpleFrameClass
local BaseSimpleFrame = require(lib_modname..'.Frame.Base')

--=======
-- Class
--=======

local SimpleFrame = Class.new('SimpleFrame', BaseSimpleFrame)
---@class SimpleFrame : BaseSimpleFrame
local public = SimpleFrame.public
---@class SimpleFrameClass : BaseSimpleFrameClass
local static = SimpleFrame.static
---@type SimpleFrameClass
local override = SimpleFrame.override
local private = {}

--=========
-- Static
--=========

---@param type_name string
---@param child_instance SimpleFrame | nil
---@return SimpleFrame
function override.new(type_name, child_instance)
    checkType(type_name, 'string', 'type_name')
    if child_instance then
        checkType(child_instance, BaseSimpleFrame, 'child_instance')
    end

    local instance = child_instance or Class.allocate(SimpleFrame)
    instance = BaseSimpleFrame.new(type_name, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param texture string | nil
function public:setTexture(texture)
    texture = texture or ''
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

return static