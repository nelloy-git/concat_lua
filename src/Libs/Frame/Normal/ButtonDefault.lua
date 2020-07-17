--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Handle.Action
local checkType = UtilsLib.Functions.checkType
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
local Trigger = UtilsLib.Handle.Trigger

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_modname..'.Normal.Base')
local FrameNormalBasePublic = Class.getPublic(FrameNormalBase)
---@type FrameNormalButtonClass
local FrameNormalButton = require(lib_modname..'.Normal.Button')
---@type FrameNormalImageClass
local FrameNormalImage = require(lib_modname..'.Normal.Image')

---@type FdfNormalBackdropClass
local FdfNormalBackdrop = require(lib_modname..'.Fdf.Frame.NormalBackdrop')
---@type FdfNormalHighlightClass
local FdfNormalHighlight = require(lib_modname..'.Fdf.Frame.NormalHighlight')
---@type FdfNormalGlueTextButtonClass
local FdfNormalGlueTextButton = require(lib_modname..'.Fdf.Frame.NormalGlueTextButton')
---@type FdfNormalTextClass
local FdfNormalText = require(lib_modname..'.Fdf.Frame.NormalText')

--=======
-- Class
--=======

local FrameNormalButtonDefault = Class.new('FrameNormalButtonDefault', FrameNormalButton)
---@class FrameNormalButtonDefault : FrameNormalButton
local public = FrameNormalButtonDefault.public
---@class FrameNormalButtonDefaultClass : FrameNormalButtonClass
local static = FrameNormalButtonDefault.static
---@type FrameNormalButtonDefaultClass
local override = FrameNormalButtonDefault.override
local private = {}

--=========
-- Static
--=========

---@return FrameNormalButtonDefault
function override.new()
    local instance = Class.allocate(FrameNormalButtonDefault)
    instance = FrameNormalButton.new(private.fdf, instance)

    instance:setSubframeClass(private.control_name, FrameNormalImage)

    local b = instance:getSubframe(private.control_name)
    local h = b:getHandleData()
    print(BlzFrameGetName(h), GetHandleId(h))
    --instance:setSubframeClass(private.control_pushed_name, FrameNormalImage)
    --instance:setSubframeClass(private.control_disabled_name, FrameNormalImage)

    return instance
end

--========
-- Public
--========

---@param path string
---@param flag number
---@param blend boolean
function public:setTexture(path, flag, blend)
    self:getSubframe(private.control_name):setFile(path, flag, blend)
end

---@param path string
---@param flag number
---@param blend boolean
function public:setTextureDisabled(path, flag, blend)
    self:getSubframe(private.control_pushed_name):setFile(path, flag, blend)
end

---@param path string
---@param flag number
---@param blend boolean
function public:setTexturePushed(path, flag, blend)
    self:getSubframe(private.control_disabled_name):setFile(path, flag, blend)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf_name = 'FrameNormalButtonDefault'
private.control_name = 'FrameNormalButtonDefaultControl'
private.control_pushed_name = 'FrameNormalButtonDefaultControlPushed'
private.control_disabled_name = 'FrameNormalButtonDefaultControlDisabled'
private.control_mouseover_name = 'FrameNormalButtonDefaultControlMouseOver'
private.control_focus_name = 'FrameNormalButtonDefaultControlFocus'
private.text_name = 'FrameNormalButtonDefaultText'

private.icon = "ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp"
private.disbtn_icon = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNAcidBomb.blp"

private.fdf = FdfNormalGlueTextButton.new(private.fdf_name)
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setControlStyle(true, true, true)
    private.control = FdfNormalBackdrop.new(private.control_name)
    private.control:setBackground(private.icon)
    private.control:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
    private.control:setCornerSize(0.0125)
    private.control:setInsets(0.005, 0.005, 0.005, 0.005)
    private.control:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")
private.fdf:setControl(private.control)

    private.control_pushed = FdfNormalBackdrop.new(private.control_pushed_name)
    private.control_pushed:setBackground(private.icon)
    private.control_pushed:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
    private.control_pushed:setCornerSize(0.0125)
    private.control_pushed:setInsets(0.01, 0.01, 0.01, 0.01)
    private.control_pushed:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")
private.fdf:setControlPushed(private.control_pushed)

    private.control_disabled = FdfNormalBackdrop.new(private.control_disabled_name)
    private.control_disabled:setBackground(private.disbtn_icon)
    private.control_disabled:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
    private.control_disabled:setCornerSize(0.0125)
    private.control_disabled:setInsets(0.005, 0.005, 0.005, 0.005)
    private.control_disabled:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")
private.fdf:setControlDisabled(private.control_disabled)
--
--    private.control_mouse_over = FdfNormalHighlight.new(private.control_mouseover_name)
--    -- TODO
--private.fdf:setControlMouseOver(private.control_mouse_over)
--
--    private.control_focus = FdfNormalHighlight.new(private.control_focus_name)
--    -- TODO
--private.fdf:setControlFocus(private.control_focus)
--
--    private.text = FdfNormalText.new(private.text_name)
--private.fdf:setText(private.text)

return static