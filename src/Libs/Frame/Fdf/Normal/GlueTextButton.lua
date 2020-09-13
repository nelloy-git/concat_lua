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
---@param fdf_backdrop FdfBackdrop
function public:setControl(fdf_backdrop)
    isTypeErr(fdf_backdrop, FdfBackdrop, 'fdf_backdrop')
    private.setControlSubframe(self, 'ControlBackdrop', fdf_backdrop)
end

--- Shown as long as pressed
---@param fdf_backdrop FdfBackdrop
function public:setControlPushed(fdf_backdrop)
    isTypeErr(fdf_backdrop, FdfBackdrop, 'fdf_backdrop')
    private.setControlSubframe(self, 'ControlPushedBackdrop', fdf_backdrop)
end

--- Shown when disabled
---@param fdf_backdrop FdfBackdrop
function public:setControlDisabled(fdf_backdrop)
    isTypeErr(fdf_backdrop, FdfBackdrop, 'fdf_backdrop')
    private.setControlSubframe(self, 'ControlDisabledBackdrop', fdf_backdrop)
end

--- Glowing when mouse hovers.
---@param fdf_highlight FdfHighlight
function public:setControlMouseOver(fdf_highlight)
    isTypeErr(fdf_highlight, FdfHighlight, 'fdf_highlight')
    private.setControlSubframe(self, 'ControlMouseOverHighlight', fdf_highlight)

    if self:getBaseType() ~= 'GLUETEXTBUTTON' then
        self:setBaseType('GLUEBUTTON')
    end
end

--- Glowing when mouse hovers.
---@param fdf_highlight FdfHighlight
function public:setControlFocus(fdf_highlight)
    isTypeErr(fdf_highlight, FdfHighlight, 'fdf_highlight')
    private.setControlSubframe(self, 'ControlFocusHighlight', fdf_highlight)

    if self:getBaseType() ~= 'GLUETEXTBUTTON' then
        self:setBaseType('GLUEBUTTON')
    end
end

--- Is used to markup the text on the buttom.
---@param fdf_text FdfText
function public:setText(fdf_text)
    isTypeErr(fdf_text, FdfText, 'fdf_text')
    private.setControlSubframe(self, 'ButtonText', fdf_text)

    self:setBaseType('GLUETEXTBUTTON')
end

--=========
-- Private
--=========

---@param self FdfGlueTextButton
---@param parameter string
---@param subframe FdfBase
function private.setControlSubframe(self, parameter, subframe)
    -- Remove previous
    local name = self:getParameter(parameter)
    if name then
        self:removeSubframe(name)
    end

    self:setParameter(parameter, '\"'..subframe:getName()..'\"')
    self:addSubframe(subframe)
end

return static