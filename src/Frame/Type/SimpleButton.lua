--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.FrameType')

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
function public:getTextureName()
    return private.getTextureName(self:getName())
end

---@return number
function public:getDefaultWidth()
    return private.default_width
end

---@return number
function public:getDefaultHeight()
    return private.default_height
end

---@return string
function public:getDefaultTexture()
    return private.default_texture
end

--=========
-- Private
--=========

---@param name string
---@return string
function private.getTextureName(name)
    return name..'Texture'
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
    private.SimpleButton = FdfEdit.SimpleButton
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param name string
---@return string
function private.createFdf(name)
    local frame = private.SimpleButton.new(name)
    local fields = private.SimpleButton.Field
    frame:setField(fields.Width, private.default_width)
    frame:setField(fields.Height, private.default_height)

    local texture = private.SimpleTexture.new(name..'Texture')
    texture:setField(private.SimpleTexture.Field.File, private.default_texture)
    frame:setField(fields.Texture, {texture})

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime().toc
end

return static