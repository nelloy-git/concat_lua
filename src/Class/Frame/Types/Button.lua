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

local ButtonType = Class.new('ButtonType', FrameType)
---@class ButtonType
local public = ButtonType.public
---@class ButtonTypeClass
local static = ButtonType.static
---@type ButtonTypeClass
local override = ButtonType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param child_instance ButtonType | nil
---@return ButtonType
function override.new(uniq_name, child_instance)
    local instance = child_instance or Class.allocate(ButtonType)
    instance = FrameType.new(uniq_name, private.createFdf, instance)

    return instance
end

--========
-- Public
--========

---@return boolean
function public:isSimple()
    return false
end

function public:free()
    Class.free(self)
end

--=========
-- Private
--=========

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.File = FdfEdit.File
    --private.Button = FdfEdit.
end)

---@param name string
---@return table
function private.createFdf(name)
    frame = private.SimpleButton.new(name)
    fields = private.SimpleButton.Field
    frame:setField(fields.Width, 0.05)
    frame:setField(fields.Height, 0.05)

    local texture = private.SimpleTexture.new(name..'Texture')
    texture:setField(private.SimpleTexture.Field.File, private.default_texture)
    frame:setField(fields.Texture, {texture})

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime()
end


return static