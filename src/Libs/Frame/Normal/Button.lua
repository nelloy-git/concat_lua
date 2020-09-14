--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame
local FramePublic = Class.getPublic(Frame)
---@type TypesLib
local TypesLib = lib_dep.Types or error('')
local FrameEventType = TypesLib.FrameEventTypeEnum or error('')
local frameToString = TypesLib.frameEventtoString or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log

---@type FrameUtils
local FrameUtils = require(lib_path..'Utils') or error('')
local newFrame = FrameUtils.newFrameFromFdf or error('')

---@type FdfBackdropClass
local FdfBackdrop = require(lib_path..'.Fdf.Normal.Backdrop') or error('')
---@type FdfGlueTextButtonClass
local FdfGlueTextButton = require(lib_path..'.Fdf.Normal.GlueTextButton') or error('')
---@type FdfHighlightClass
local FdfHighlight = require(lib_path..'.Fdf.Normal.Highlight') or error('')
---@type FdfTextClass
local FdfText = require(lib_path..'.Fdf.Normal.Text') or error('')

--=======
-- Class
--=======

local FrameNormalButton = Class.new('FrameNormalButton', Frame)
---@class FrameNormalButton : Frame
local public = FrameNormalButton.public
---@class FrameNormalButtonClass : FrameClass
local static = FrameNormalButton.static
---@type FrameNormalButtonClass
local override = FrameNormalButton.override
local private = {}

--=========
-- Static
--=========

---@alias FrameNormalButtonCallback fun(frame:FrameNormalButton, player:player, event:frameeventtype)

---@param child FrameNormalButton | nil
---@return FrameNormalButton
function override.new(child)
    if child then isTypeErr(child, FrameNormalButton, 'child') end

    local instance = child or Class.allocate(FrameNormalButton)
    instance = newFrame(private.fdf, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param event frameeventtype
---@param callback FrameNormalButtonCallback
---@return Action
function public:addAction(event, callback)
    private.isEventAvailable(event)
    return FramePublic.addAction(self, event, callback)
end

--=========
-- Private
--=========

private.fdf_name = 'FrameNormalButtonDefault'
private.control_name = 'FrameNormalButtonDefaultControlNormal'
private.control_pushed_name = 'FrameNormalButtonDefaultControlPushed'
private.control_disabled_name = 'FrameNormalButtonDefaultControlDisabled'
private.control_mouseover_name = 'FrameNormalButtonDefaultControlMouseOver'
private.control_focus_name = 'FrameNormalButtonDefaultControlFocus'
private.text_name = 'FrameNormalButtonDefaultText'

private.icon = "ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp"
private.icon_pushed = "ReplaceableTextures\\CommandButtons\\BTNAltarOfElders.blp"
private.disbtn_icon = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNAcidBomb.blp"
private.highlight_icon = "UI\\Glues\\ScoreScreen\\scorescreen-tab-hilight.blp"
private.font = "fonts\\nim_____.ttf"
private.font_size = 0.009

function private.createControl(name, icon)
    local control = FdfNormalBackdrop.new(name)
    control:setBackground(icon)
    control:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
    control:setCornerSize(0.0125)
    control:setInsets(0.005, 0.005, 0.005, 0.005)
    control:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")
    return control
end

function private.createHighlight(name, path)
    local highlight = FdfNormalHighlight.new(name)
    highlight:setHighlightType('FILETEXTURE')
    highlight:setAlphaFile("UI\\Glues\\ScoreScreen\\scorescreen-tab-hilight.blp")
    highlight:setAlphaMode('ADD')
    return highlight
end

function private.createText(name, font, size)
    local text = FdfNormalText.new(name)
    text:setText('Text')
    text:setJustification('JUSTIFYCENTER', 'JUSTIFYMIDDLE')
    text:setFont(font, size)
    text:setColor(0, 0, 0, 1)
    return text
end

private.fdf = FdfGlueTextButton.new('FrameNormalButton')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setControlStyle(true, true, true)
    local fdf_control = FdfBackdrop.new('FrameNormalButtonControl')
    fdf_control:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
    fdf_control:setCornerSize(0.0125)
    fdf_control:setInsets(0.005, 0.005, 0.005, 0.005)
    fdf_control:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")
private.fdf:setControl(private.createControl(private.control_name, private.icon))
private.fdf:setControlPushed(private.createControl(private.control_pushed_name, private.icon_pushed))
private.fdf:setControlDisabled(private.createControl(private.control_disabled_name, private.disbtn_icon))
private.fdf:setControlMouseOver(private.createHighlight(private.control_mouseover_name, private.highlight_icon))
private.fdf:setControlFocus(private.createHighlight(private.control_focus_name, private.highlight_icon))
private.fdf:setText(private.createText(private.text_name, private.font, private.font_size))

private.available_events = {
    [FrameEventType.CONTROL_CLICK] = true,
    [FrameEventType.MOUSE_ENTER] = true,
    [FrameEventType.MOUSE_LEAVE] = true,
    [FrameEventType.MOUSE_UP] = true,
    [FrameEventType.MOUSE_DOWN] = true,
    [FrameEventType.MOUSE_WHEEL] = true,
}

---@param event frameeventtype
function private.isEventAvailable(event)
    if not private.available_events[event] then
        Log:err('Event \''..frameToString(event)..'\' is not available for '..tostring(FrameNormalButton))
    end
end

return static