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

--=========
-- Private
--=========

---@param name string
---@return string
function private.getTextureName(name)
    return name..'Texture'
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
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param name string
---@return string
function private.createFdf(name)
    local frame = private.SimpleFrame.new(name)
    local fields = private.SimpleFrame.Field
    frame:setField(fields.Width, private.default_width)
    frame:setField(fields.Height, private.default_height)

    local texture = private.SimpleTexture.new(private.getTextureName(name))
    texture:setField(private.SimpleTexture.Field.File, private.default_texture)
    frame:setField(fields.Texture, {texture})

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime().toc
end

return static