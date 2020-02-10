--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

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
---@param child_instance GlueButtonType | nil
---@return GlueButtonType
function override.new(uniq_name, child_instance)
    local instance = child_instance or Class.allocate(GlueButtonType)
    instance = FrameType.new(uniq_name, private.createFdf, instance)
    private.newData(instance, uniq_name)

    return instance
end

--========
-- Public
--========

---@return boolean
function public:isSimple()
    return false
end

---@return string
function public:getControlName()
    return private[self].name..private.suffixes.Control
end

---@return string
function public:getControlPushedName()
    return private[self].name..private.suffixes.ControlPushed
end

---@return string
function public:getControlDisabledName()
    return private[self].name..private.suffixes.ControlDisabled
end

---@return string
function public:getControlDisabledPushedName()
    return private[self].name..private.suffixes.ControlDisabledPushed
end

---@return string
function public:getControlMouseOverName()
    return private[self].name..private.suffixes.ControlMouseOver
end

---@return string
function public:getControlFocusName()
    return private[self].name..private.suffixes.ControlFocus
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
    private.GlueButton = FdfEdit.GlueButton
    private.Backdrop = FdfEdit.Backdrop
    private.Highlight = FdfEdit.Highlight
end)

private.suffixes = {
    Control = 'Control',
    ControlPushed = 'ControlPushed',
    ControlDisabled = 'ControlDisabled',
    ControlDisabledPushed = 'ControlDisabledPushed',
    ControlMouseOver = 'ControlMouseOver',
    ControlFocus = 'ControlFocus',
}

---@param name string
---@return table
function private.createFdf(name)
    local frame = private.GlueButton.new(name)
    local fields = private.GlueButton.Field

    frame:setField(fields.Width, 0.05)
    frame:setField(fields.Height, 0.05)

    frame:setField(fields.ControlStyle, 'AUTOTRACK|HIGHLIGHTONFOCUS|HIGHLIGHTONMOUSEOVER')
    local ControlName = name..private.suffixes.Control
    frame:setField(fields.ControlBackdrop, ControlName)
    local ControlPushedName = name..private.suffixes.ControlPushed
    frame:setField(fields.ControlPushedBackdrop, ControlPushedName)
    local ControlDisabledName = name..private.suffixes.ControlDisabled
    frame:setField(fields.ControlDisabledBackdrop, ControlDisabledName)
    local ControlDisabledPushedName = name..private.suffixes.ControlDisabledPushed
    frame:setField(fields.ControlDisabledPushedBackdrop, ControlDisabledPushedName)
    local ControlMouseOverName = name..private.suffixes.ControlMouseOver
    frame:setField(fields.ControlMouseOverHighlight, ControlMouseOverName)
    local ControlFocusName = name..private.suffixes.ControlFocus
    frame:setField(fields.ControlFocusHighlight, ControlFocusName)

    local childs = {
        [1] = private.Backdrop.new(name..private.suffixes.Control),
        [2] = private.Backdrop.new(name..private.suffixes.ControlPushed),
        [3] = private.Backdrop.new(name..private.suffixes.ControlDisabled),
        [4] = private.Backdrop.new(name..private.suffixes.ControlDisabledPushed),
        [5] = private.Highlight.new(name..private.suffixes.ControlMouseOver),
        [6] = private.Highlight.new(name..private.suffixes.ControlFocus),
    }
    frame:setField(fields.ChildFrames, childs)

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime().toc
end

---@param instance GlueButtonType
---@param uniq_name string
function private.newData(instance, uniq_name)
    local priv = {
        name = uniq_name
    }
    private[instance] = priv
end

---@param instance GlueButtonType
function private.freeData(instance)
    private[instance] = nil
end

return static