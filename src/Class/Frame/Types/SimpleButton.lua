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

local SimpleButtonType = Class.new('SimpleButtonType', FrameType)
---@class SimpleButtonType
local public = SimpleButtonType.public
---@class SimpleButtonTypeClass
local static = SimpleButtonType.static
---@type SimpleButtonTypeClass
local override = SimpleButtonType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param child_instance SimpleButtonType | nil
---@return SimpleButtonType
function override.new(uniq_name, child_instance)
    local instance = child_instance or Class.allocate(SimpleButtonType)
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
    private.SimpleButton = FdfEdit.SimpleButton
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param name string
---@return table
function private.createFdf(name)
    local frame = private.SimpleButton.new(name)
    local fields = private.SimpleButton.Field
    frame:setField(fields.Width, 0.05)
    frame:setField(fields.Height, 0.05)

    local texture = private.SimpleTexture.new(name..'Texture')
    texture:setField(private.SimpleTexture.Field.File, '')
    frame:setField(fields.Texture, {texture})

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime()
end

---@param instance SimpleButtonType
function private.newData(instance)
    local priv = {
    }
    private[instance] = priv
end

---@param instance SimpleButtonType
function private.freeData(instance)
    private[instance] = nil
end

return static