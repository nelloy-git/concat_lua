--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.FrameType')

--=======
-- Class
--=======

local GlueButtonType = Class.new('GlueButtonType', FrameType)
---@class GlueButtonType
local public = GlueButtonType.public
---@class GlueButtonTypeClass
local static = GlueButtonType.static
---@type GlueButtonTypeClass
local override = GlueButtonType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance GlueButtonType | nil
---@return GlueButtonType
function override.new(uniq_name, separate_file, child_instance)
    local instance = child_instance or Class.allocate(GlueButtonType)
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

---@param backdrop_type BackdropType
function public:setEnabledBackdrop(backdrop_type)
    private.data[self].enabled = backdrop_type

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.ControlBackdrop, backdrop_type:getName())
        private.applyChildrens(self)
    end
end

---@param backdrop_type BackdropType
function public:setPressedBackdrop(backdrop_type)
    private.data[self].pressed = backdrop_type

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.ControlPushedBackdrop, backdrop_type:getName())
        private.applyChildrens(self)
    end
end

---@param backdrop_type BackdropType
function public:setDisabledBackdrop(backdrop_type)
    private.data[self].disabled = backdrop_type

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.ControlDisabledBackdrop, backdrop_type:getName())
        private.applyChildrens(self)
    end
end

---@param highlight_type HighlightType
function public:setHoveredHighlight(highlight_type)
    private.data[self].hovered = highlight_type

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.ControlMouseOverHighlight, highlight_type:getName())
        private.applyChildrens(self)
    end
end

---@param highlight_type HighlightType
function public:setFocusedHighlight(highlight_type)
    private.data[self].focused = highlight_type

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.ControlFocusHighlight, highlight_type:getName())
        private.applyChildrens(self)
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

---@return BackdropType
function public:getEnabledBackdrop()
    return private.data[self].enabled
end

---@return BackdropType
function public:getPressedBackdrop()
    return private.data[self].pressed
end

---@return BackdropType
function public:getDisabledBackdrop()
    return private.data[self].disabled
end

---@return HighlightType
function public:getHoverHighlight()
    return private.data[self].hovered
end

---@return HighlightType
function public:getFocusedHighlight()
    return private.data[self].focused
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self GlueButtonType
function private.applyChildrens(self)
    local priv = private.data[self]

    local list = {}
    local control_style = 'AUTOTRACK'
    if priv.enabled then
        table.insert(list, priv.enabled:getFdf())
    end
    if priv.pressed then
        table.insert(list, priv.pressed:getFdf())
    end
    if priv.disabled then
        table.insert(list, priv.disabled:getFdf())
    end
    if priv.hovered then
        table.insert(list, priv.hovered:getFdf())
        control_style = control_style..'|HIGHLIGHTONMOUSEOVER'
    end
    if priv.focused then
        table.insert(list, priv.focused:getFdf())
        control_style = control_style..'|HIGHLIGHTONFOCUS'
    end

    self:getFdf():setField(private.Field.ChildFrames, list)
    self:getFdf():setField(private.Field.ControlStyle, control_style)
end

---@param self GlueButtonType
function private.newData(self)
    local priv = {
        width = private.default_width,
        height = private.default_height,

        enabled = nil,
        pressed = nil,
        disabled = nil,
        hovered = nil,
        focused = nil,
    }
    private.data[self] = priv
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
    private.GlueButton = FdfEdit.GlueButton
    private.Field = FdfEdit.GlueButton.Field
end)

---@param name string
---@return table
function private.createFdf(name)
    local frame = private.GlueButton.new(name)
    local fields = private.GlueButton.Field

    frame:setField(fields.Width, private.default_width)
    frame:setField(fields.Height, private.default_height)
    frame:setField(fields.ControlStyle, 'AUTOTRACK')

    return frame
end

return static