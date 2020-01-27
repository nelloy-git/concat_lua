--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Class.Frame.FrameType')

--=======
-- Class
--=======

local SimpleFrameType = Class.new('SimpleFrameType')
---@class SimpleFrameType
local public = SimpleFrameType.public
---@class SimpleFrameTypeClass
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
function static.new(uniq_name, child_instance)
    local instance = child_instance or Class.allocate(SimpleFrameType)
    instance = FrameType.new(uniq_name, private.createFdf)
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
function public:getSubElementName()
    return self:getName()..'Texture'
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.File = FdfEdit.File
    private.SimpleFrame = FdfEdit.SimpleFrame
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param name string
---@return table
function private.createFdf(name)
    frame = private.SimpleFrame.new(name)
    fields = private.SimpleFrame.Field
    frame:setField(fields.Width, 0.05)
    frame:setField(fields.Height, 0.05)

    local texture = private.SimpleTexture.new(name..'Texture')
    texture:setField(private.SimpleTexture.Field.File, private.default_texture)
    frame:setField(fields.Texture, {texture})

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime()
end

---@param instance SimpleFrameType
function private.newData(instance)
    local priv = {
    }
    private[instance] = priv
end

---@param instance SimpleFrameType
function private.freeData(instance)
    private[instance] = nil
end

return static