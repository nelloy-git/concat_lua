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

---@type FdfBackdropClass
local FdfBackdrop = require(lib_path..'Fdf.Normal.Backdrop') or error('')
---@type FdfGlueTextButtonClass
local FdfGlueTextButton = require(lib_path..'Fdf.Normal.GlueTextButton') or error('')
---@type FdfHighlightClass
local FdfHighlight = require(lib_path..'Fdf.Normal.Highlight') or error('')
---@type FdfTextClass
local FdfText = require(lib_path..'Fdf.Normal.Text') or error('')

---@type FrameNormalImageClass
local FrameImage = require(lib_path..'Normal.Image') or error('')

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

    ---@type FdfGlueTextButton
    local fdf = private.fdf
    local instance = child or Class.allocate(FrameNormalButton)
    instance = Frame.new(fdf:getName(), fdf:isSimple(), instance)

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

function public:setTexture()
    local priv = private.data[self]

end

function public:setDisabledTexture()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FrameSimpleImage
function private.newData(self)
    local priv = {
        --normal = newFrame(private.fdf_control_normal)
    }
    private.data[self] = priv
end

---@param name string
---@return FdfBackdrop
function private.createFdfControl(name)
    local control = FdfBackdrop.new(name)
    control:setBackground("")
    control:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
    control:setCornerSize(0.0125)
    control:setInsets(0.005, 0.005, 0.005, 0.005)
    control:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")
    return control
end

---@param name string
---@return FdfBackdrop
function private.createFdfHighlight(name)
    local highlight = FdfHighlight.new(name)
    highlight:setHighlightType('FILETEXTURE')
    highlight:setAlphaFile("UI\\Glues\\ScoreScreen\\scorescreen-tab-hilight.blp")
    highlight:setAlphaMode('ADD')
    return highlight
end

---@param name string
---@param font string
---@param size number
---@return FdfBackdrop
function private.createFdfText(name, font, size)
    local text = FdfText.new(name)
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

private.fdf_control_normal = private.createFdfControl('FrameNormalButtonControlNormal')
private.fdf:setControl(private.fdf_control_normal)

private.fdf:setControlPushed(private.createFdfControl('FrameNormalButtonControlPushed'))
private.fdf:setControlDisabled(private.createFdfControl('FrameNormalButtonControlDisabled'))
private.fdf:setControlMouseOver(private.createFdfHighlight('FrameNormalButtonControlMouseOver'))
private.fdf:setControlFocus(private.createFdfHighlight('FrameNormalButtonControlFocus'))
private.fdf:setText(private.createFdfText('FrameNormalButtonDefaultText',
                                       'fonts\\nim_____.ttf',
                                        0.009))

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