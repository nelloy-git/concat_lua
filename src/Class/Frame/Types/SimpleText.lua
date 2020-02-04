--=========
-- Include
--=========

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
function override.new(uniq_name, child_instance)
    local instance = child_instance or Class.allocate(SimpleTextType)
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
function public:getStringName()
    return private.getStringName(self:getName())
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
function public:getDefaultFont()
    return private.default_font
end

---@return number
function public:getDefaultFontSize()
    return private.default_font_size
end

--=========
-- Private
--=========

---@param name string
---@return string
function private.getStringName(name)
    return name..'String'
end

--=============
-- Compiletime
--=============

private.default_width = 0.03
private.default_height = 0.03
private.default_font = 'fonts\\nim_____.ttf'
private.default_font_size = 0.009

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.File = FdfEdit.File
    private.SimpleFrame = FdfEdit.SimpleFrame
    private.SimpleString = FdfEdit.SimpleString
end)

---@param name string
---@return string
function private.createFdf(name)
    local frame = private.SimpleFrame.new(name)
    local fields = private.SimpleFrame.Field
    frame:setField(fields.Width, private.default_width)
    frame:setField(fields.Height, private.default_height)

    local string = private.SimpleString.new(private.getStringName(name))
    string:setField(private.SimpleString.Field.Font, {private.default_font, private.default_font_size})
    string:setField(private.SimpleString.Field.Anchor, {'BOTTONLEFT', 0, 0})
    frame:setField(fields.String, {string})

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime().toc
end

return static