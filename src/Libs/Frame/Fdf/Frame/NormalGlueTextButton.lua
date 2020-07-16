--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

---@type FdfFileClass
local FdfFile = require(lib_modname..'.Fdf.File')
---@type FdfNormalBaseClass
local FdfNormalBase = require(lib_modname..'.Fdf.Frame.NormalBase')
---@type FdfNormalBackdropClass
local FdfNormalBackdrop = require(lib_modname..'.Fdf.Frame.NormalBackdrop')
---@type FdfNormalTextClass
local FdfNormalText = require(lib_modname..'.Fdf.Frame.NormalText')
---@type FdfNormalHighlightClass
local FdfNormalHighlight = require(lib_modname..'.Fdf.Frame.NormalHighFdfNormalHighlight')

--=======
-- Class
--=======

local FdfNormalGlueTextButton = Class.new('FdfNormalGlueTextButton', FdfNormalBase)
---@class FdfNormalGlueTextButton : FdfNormalBase
local public = FdfNormalGlueTextButton.public
---@class FdfNormalGlueTextButtonClass : FdfNormalBaseClass
local static = FdfNormalGlueTextButton.static
---@type FdfNormalGlueTextButtonClass
local override = FdfNormalGlueTextButton.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param fdf_file FdfFile | nil
---@param child_instance FdfNormalGlueTextButton | nil
---@return FdfNormalGlueTextButton
function override.new(name, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfNormalGlueTextButton, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfNormalGlueTextButton)
    instance = FdfNormalBase.new(name, 'GLUETEXTBUTTON', fdf_file, instance)

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
---@param fdf_backdrop FdfNormalBackdrop
function public:setControl(fdf_backdrop)
    checkTypeErr(fdf_backdrop, FdfNormalBackdrop, 'fdf_backdrop')
    private.setControlSubframe(self, 'ControlBackdrop', fdf_backdrop)
end

--- Shown as long as pressed
---@param fdf_backdrop FdfNormalBackdrop
function public:setControlPushed(fdf_backdrop)
    checkTypeErr(fdf_backdrop, FdfNormalBackdrop, 'fdf_backdrop')
    private.setControlSubframe(self, 'ControlPushedBackdrop', fdf_backdrop)
end

--- Shown when disabled
---@param fdf_backdrop FdfNormalBackdrop
function public:setControlDisabled(fdf_backdrop)
    checkTypeErr(fdf_backdrop, FdfNormalBackdrop, 'fdf_backdrop')
    private.setControlSubframe(self, 'ControlDisabledBackdrop', fdf_backdrop)
end

--- Glowing when mouse hovers.
---@param fdf_highlight FdfNormalHighlight
function public:setControlMouseOver(fdf_highlight)
    checkTypeErr(fdf_highlight, FdfNormalHighlight, 'fdf_highlight')
    private.setControlSubframe(self, 'ControlMouseOverHighlight', fdf_highlight)
end

--- Glowing when mouse hovers.
---@param fdf_highlight FdfNormalHighlight
function public:setControlFocus(fdf_highlight)
    checkTypeErr(fdf_highlight, FdfNormalHighlight, 'fdf_highlight')
    private.setControlSubframe(self, 'ControlFocusHighlight', fdf_highlight)
end

--- Is used to markup the text on the buttom.
---@param fdf_text FdfNormalText
function public:setText(fdf_text)
    checkTypeErr(fdf_text, FdfNormalText, 'fdf_text')
    private.setControlSubframe(self, 'ButtonText', fdf_text)
end

-- TODO ControlMouseOverHightlight, ControlFocusHighlight, ButtonText

--=========
-- Private
--=========

---@param self FdfNormalGlueTextButton
---@param parameter string
---@param subframe FdfNormalBase
function private.setControlSubframe(self, parameter, subframe)
    -- Remove previous
    local name = self:getParameter(parameter)
    if name then
        self:removeSubframe(name)
    end

    self:setParameter(parameter, subframe:getName())
    self:addSubframe(subframe)
end

return static