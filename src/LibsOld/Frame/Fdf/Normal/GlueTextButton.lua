--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type FdfBaseClass
local FdfBase = require(lib_path..'Fdf.Base') or error('')
---@type FdfBackdropClass
local FdfBackdrop = require(lib_path..'Fdf.Normal.Backdrop') or error('')
---@type FdfTextClass
local FdfText = require(lib_path..'Fdf.Normal.Text') or error('')
---@type FdfHighlightClass
local FdfHighlight = require(lib_path..'Fdf.Normal.Highlight') or error('')

--=======
-- Class
--=======

local FdfGlueTextButton = Class.new('FdfGlueTextButton', FdfBase)
---@class FdfGlueTextButton : FdfBase
local public = FdfGlueTextButton.public
---@class FdfGlueTextButtonClass : FdfBaseClass
local static = FdfGlueTextButton.static
---@type FdfGlueTextButtonClass
local override = FdfGlueTextButton.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfGlueTextButton | nil
---@return FdfGlueTextButton
function override.new(name, child)
    isTypeErr(name, 'string', 'name')
    if child then isTypeErr(child, FdfGlueTextButton, 'child') end

    local instance = child or Class.allocate(FdfGlueTextButton)
    instance = FdfBase.new(name, 'GLUETEXTBUTTON', false, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    local str_width = tostring(width)
    self:setParameter('Width', str_width)
end

---@param height number
function public:setHeight(height)
    local str_height = tostring(height)
    self:setParameter('Height', str_height)
end

--- Look-Up FileNames in some String table (for example gameinterface)
---@param flag boolean
function public:setDecorateFileNames(flag)
    if flag then
        self:setParameter('DecorateFileNames')
    else
        self:removeParameter('DecorateFileNames')
    end
end

---@param autotrack boolean
---@param highlight_on_focus boolean
---@param highlight_on_mouse_over boolean
function public:setControlStyle(autotrack, highlight_on_focus, highlight_on_mouse_over)
    local flags
    if autotrack then flags = 'AUTOTRACK' end
    if highlight_on_focus then flags = flags..'|HIGHLIGHTONFOCUS' end
    if highlight_on_mouse_over then flags = flags..'|HIGHLIGHTONMOUSEOVER' end

    self:setParameter('ControlStyle', '\"'..flags..'\"')
end

---@param x number
---@param y number
function public:setPushedTextOffset(x, y)
    self:setParameter('ButtonPushedTextOffset', tostring(x)..' '..tostring(y))
end

--- Shown when enabled
---@return FdfBackdrop
function public:getControlNormal()
    local priv = private.data[self]

    if priv.normal then
        return priv.normal
    end

    priv.normal = FdfBackdrop.new(self:getName()..'Normal')
    private.setControlSubframe(self, 'ControlBackdrop', priv.normal)

    return priv.normal
end

---@return boolean
function public:hasControlNormal()
    if private.data[self].normal then
        return true
    end
    return false
end

--- Shown as long as pressed
---@return FdfBackdrop
function public:getControlPushed()
    local priv = private.data[self]

    if priv.pushed then
        return priv.pushed
    end

    priv.pushed = FdfBackdrop.new(self:getName()..'Pushed')
    private.setControlSubframe(self, 'ControlPushedBackdrop', priv.pushed)

    return priv.pushed
end

---@return boolean
function public:hasControlPushed()
    if private.data[self].pushed then
        return true
    end
    return false
end

--- Shown when disabled
---@return FdfBackdrop
function public:getControlDisabled()
    local priv = private.data[self]

    if priv.disabled then
        return priv.disabled
    end

    priv.disabled = FdfBackdrop.new(self:getName()..'Disabled')
    private.setControlSubframe(self, 'ControlDisabledBackdrop', priv.disabled)

    return priv.disabled
end

---@return boolean
function public:hasControlDisabled()
    if private.data[self].disabled then
        return true
    end
    return false
end

--- Glowing when mouse hovers.
---@return FdfHighlight
function public:getControlMouse()
    local priv = private.data[self]

    if priv.mouse then
        return priv.mouse
    end

    priv.mouse = FdfHighlight.new(self:getName()..'Mouse')
    private.setControlSubframe(self, 'ControlMouseOverHighlight', priv.mouse)

    if self:getBaseType() ~= 'GLUETEXTBUTTON' then
        self:setBaseType('GLUEBUTTON')
    end

    return priv.mouse
end

---@return boolean
function public:hasControlMouse()
    if private.data[self].mouse then
        return true
    end
    return false
end

--- Glowing when mouse hovers.
---@return FdfHighlight
function public:getControlFocus()
    local priv = private.data[self]

    if priv.focus then
        return priv.focus
    end

    priv.focus = FdfHighlight.new(self:getName()..'Focus')
    private.setControlSubframe(self, 'ControlFocusHighlight', priv.focus)

    if self:getBaseType() ~= 'GLUETEXTBUTTON' then
        self:setBaseType('GLUEBUTTON')
    end

    return priv.focus
end

---@return boolean
function public:hasControlFocus()
    if private.data[self].focus then
        return true
    end
    return false
end

--- Is used to markup the text on the buttom.
---@return FdfText
function public:getText()
    local priv = private.data[self]

    if priv.text then
        return priv.text
    end

    priv.text = FdfText.new(self:getName()..'Text')
    private.setControlSubframe(self, 'ButtonText', priv.text)

    self:setBaseType('GLUETEXTBUTTON')

    return priv.text
end

---@return boolean
function public:hasText()
    if private.data[self].text then
        return true
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FdfGlueTextButton
function private.newData(self)
    local priv = {
        normal = nil,
        pushed = nil,
        disabled = nil,
        mouse = nil,
        focus = nil,
        text = nil,
    }
    private.data[self] = priv
end

---@param self FdfGlueTextButton
---@param parameter string
---@param subframe FdfBase
function private.setControlSubframe(self, parameter, subframe)
    self:setParameter(parameter, '\"'..subframe:getName()..'\"')
    self:addSubframe(subframe)
end

return static