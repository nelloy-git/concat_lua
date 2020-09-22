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
local eventToString = TypesLib.frameEventtoString or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type FdfBackdropClass
local FdfBackdrop = require(lib_path..'Fdf.Normal.Backdrop') or error('')
---@type FdfGlueTextButtonClass
local FdfGlueTextButton = require(lib_path..'Fdf.Normal.GlueTextButton') or error('')
---@type FdfHighlightClass
local FdfHighlight = require(lib_path..'Fdf.Normal.Highlight') or error('')
---@type FdfTextClass
local FdfText = require(lib_path..'Fdf.Normal.Text') or error('')

---@type FrameNormalImageClass
local Image = require(lib_path..'Normal.Image') or error('')

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
---@return Action | nil
function public:addAction(event, callback)
    if not private.available_events[event] then
        Log:wrn('Event \''..eventToString(event)..'\' is not available for '..tostring(FrameNormalButton))
        return
    end
    return FramePublic.addAction(self, event, callback)
end

---@param tex_file string
---@param flag number | nil
---@param blend boolean | nil
function public:setNormalTexture(tex_file, flag, blend)
    isTypeErr(tex_file, 'string', 'tex_file')
    private.data[self].normal:setTexture(tex_file, flag or 0, blend or true)
end

---@param tex_file string
---@param flag number | nil
---@param blend boolean | nil
function public:setPushedTexture(tex_file, flag, blend)
    isTypeErr(tex_file, 'string', 'tex_file')
    private.data[self].pushed:setTexture(tex_file, flag or 0, blend or true)
end

---@param tex_file string
---@param flag number | nil
---@param blend boolean | nil
function public:setDisabledTexture(tex_file, flag, blend)
    isTypeErr(tex_file, 'string', 'tex_file')
    private.data[self].disabled:setTexture(tex_file, flag or 0, blend or true)
end

---@param tex_file string
---@param flag number | nil
---@param blend boolean | nil
function public:setMouseOverTexture(tex_file, flag, blend)
    isTypeErr(tex_file, 'string', 'tex_file')
    private.data[self].mouse:setTexture(tex_file, flag or 0, blend or true)
end

---@param tex_file string
---@param flag number | nil
---@param blend boolean | nil
function public:setFocusTexture(tex_file, flag, blend)
    isTypeErr(tex_file, 'string', 'tex_file')
    private.data[self].focus:setTexture(tex_file, flag or 0, blend or true)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FrameSimpleImage
function private.newData(self)
    local getHandle = BlzGetFrameByName
    local priv = {
        normal = Image.link(getHandle(private.fdf_normal:getName(), 0)),
        pushed = Image.link(getHandle(private.fdf_pushed:getName(), 0)),
        disabled = Image.link(getHandle(private.fdf_disabled:getName(), 0)),
        mouse = Image.link(getHandle(private.fdf_mouse:getName(), 0)),
        focus = Image.link(getHandle(private.fdf_focus:getName(), 0)),
        text = Image.link(getHandle(private.fdf_text:getName(), 0)),
    }
    private.data[self] = priv
end

---@param name string
---@return FdfBackdrop
function private.createFdfControl(name)
    local control = FdfBackdrop.new(name)
    control:setBackground("")
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

private.fdf_normal = private.createFdfControl('FrameNormalButtonControlNormal')
private.fdf:setControl(private.fdf_normal)
private.fdf_pushed = private.createFdfControl('FrameNormalButtonControlPushed')
private.fdf:setControlPushed(private.fdf_pushed)
private.fdf_disabled = private.createFdfControl('FrameNormalButtonControlDisabled')
private.fdf:setControlDisabled(private.fdf_disabled)
private.fdf_mouse = private.createFdfHighlight('FrameNormalButtonControlMouseOver')
private.fdf:setControlMouseOver(private.fdf_mouse)
private.fdf_focus = private.createFdfHighlight('FrameNormalButtonControlFocus')
private.fdf:setControlFocus(private.fdf_focus)
private.fdf_text = private.createFdfText('FrameNormalButtonDefaultText',
                                         'fonts\\nim_____.ttf',
                                          0.009)
private.fdf:setText(private.fdf_text)

private.available_events = {
    [FrameEventType.CONTROL_CLICK] = true,
    [FrameEventType.MOUSE_ENTER] = true,
    [FrameEventType.MOUSE_LEAVE] = true,
    [FrameEventType.MOUSE_UP] = true,
    [FrameEventType.MOUSE_DOWN] = true,
    [FrameEventType.MOUSE_WHEEL] = true,
}

return static