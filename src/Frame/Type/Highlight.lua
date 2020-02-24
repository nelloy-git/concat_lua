--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

local HighlightType = Class.new('HighlightType', FrameType)
---@class HighlightType  : FrameType
local public = HighlightType.public
---@class HighlightTypeClass : FrameTypeClass
local static = HighlightType.static
---@type HighlightTypeClass
local override = HighlightType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance HighlightType | nil
---@return HighlightType
function override.new(uniq_name, separate_file, child_instance)
    local instance = child_instance or Class.allocate(HighlightType)
    instance = FrameType.new(uniq_name, private.createFdf, separate_file, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return boolean
function public:isSimple()
    return false
end

---@param width number
function public:setWidth(width)
    private.data[self].width = width

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Width, width)
    end
end

---@param height number
function public:setHeight(height)
    private.data[self].height = height

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Height, height)
    end
end

---@param texture string
function public:setTexture(texture)
    private.data[self].texture = texture

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Background, texture)
    end
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
end

---@return string
function public:getTexture()
    return private.data[self].background
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleFrame
function private.newData(self)
    priv = {
        width = private.default_width,
        height = private.default_height,
        texture = private.default_texture,
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

private.default_width = 0.03
private.default_height = 0.03
private.default_texture = 'UI\\Glues\\ScoreScreen\\scorescreen-tab-hilight.blp'

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.Highlight = FdfEdit.Highlight
    private.Field = FdfEdit.Highlight.Field
end)

---@param name string
---@return string
function private.createFdf(name)
    local frame = private.Highlight.new(name)
    local field = private.Field

    frame:setField(field.Width, private.default_width)
    frame:setField(field.Height, private.default_height)
    frame:setField(field.AlphaMode, 'ADD')
    frame:setField(field.Type, 'FILETEXTURE')
    frame:setField(field.AlphaFile, private.default_texture)

    return frame
end

return static