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

local SimpleTextType = Class.new('SimpleTextType')
---@class SimpleTextType
local public = SimpleTextType.public
---@class SimpleTextTypeClass
local static = SimpleTextType.static
---@type SimpleTextTypeClass
local override = SimpleTextType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param child_instance SimpleTextType | nil
---@return SimpleTextType
function static.new(uniq_name, child_instance)
    local instance = child_instance or Class.allocate(SimpleTextType)
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
    return self:getName()..'String'
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
    private.SimpleString = FdfEdit.SimpleString
end)

---@param name string
---@return table
function private.createFdf(name)
    frame = private.SimpleFrame.new(name)
    fields = private.SimpleFrame.Field
    frame:setField(fields.Width, 0.05)
    frame:setField(fields.Height, 0.05)

    local string = private.SimpleString.new(name..'String')
    string:setField(private.SimpleString.Field.Font, {'fonts\\nim_____.ttf', 0.009})
    string:setField(private.SimpleString.Field.Anchor, {'BOTTONRIGHT', 0, 0})
    frame:setField(fields.String, {string})

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime()
end

---@param instance SimpleTextType
function private.newData(instance)
    local priv = {
    }
    private[instance] = priv
end

---@param instance SimpleTextType
function private.freeData(instance)
    private[instance] = nil
end

return static