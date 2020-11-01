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

---@param fdf FdfGlueTextButton | nil
---@param child FrameNormalButton | nil
---@return FrameNormalButton
function override.new(fdf, child)
    if fdf then isTypeErr(fdf, FdfGlueTextButton, 'fdf') end
    if child then isTypeErr(child, FrameNormalButton, 'child') end

    ---@type FdfGlueTextButton
    fdf = fdf or private.fdf
    local instance = child or Class.allocate(FrameNormalButton)
    instance = Frame.new(fdf:getName(), fdf:isSimple(), instance)

    private.newData(instance, fdf)

    return instance
end

function override.link()
    Log:err(tostring(FrameNormalButton)..': can not be linked.')
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
---@param fdf FdfGlueTextButton
function private.newData(self, fdf)
    local getH = BlzGetFrameByName
    local priv = {
        normal = fdf:hasControlNormal() and Image.link(getH(fdf:getControlNormal():getName(), 0)) or nil,
        pushed = fdf:hasControlPushed() and Image.link(getH(fdf:getControlPushed():getName(), 0)) or nil,
        disabled = fdf:hasControlDisabled() and Image.link(getH(fdf:getControlDisabled():getName(), 0)) or nil,
        mouse = fdf:hasControlMouse() and Image.link(getH(fdf:getControlMouse():getName(), 0)) or nil,
        focus = fdf:hasControlFocus() and Image.link(getH(fdf:getControlFocus():getName(), 0)) or nil,
    }
    private.data[self] = priv
end

private.fdf = FdfGlueTextButton.new('FrameNormalButton')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setControlStyle(true, true, true)

private.fdf_normal = private.fdf:getControlNormal()
private.fdf_normal:setBackground("")

private.fdf_pushed = private.fdf:getControlPushed()
private.fdf_normal:setBackground("")

private.fdf_disabled = private.fdf:getControlDisabled()
private.fdf_normal:setBackground("")

private.fdf_mouse = private.fdf:getControlMouse()
private.fdf_mouse:setHighlightType('FILETEXTURE')
private.fdf_mouse:setAlphaFile("UI\\Glues\\ScoreScreen\\scorescreen-tab-hilight.blp")
private.fdf_mouse:setAlphaMode('ADD')

private.fdf_focus = private.fdf:getControlFocus()
private.fdf_focus:setHighlightType('FILETEXTURE')
private.fdf_focus:setAlphaFile("UI\\Glues\\ScoreScreen\\scorescreen-tab-hilight.blp")
private.fdf_focus:setAlphaMode('ADD')

private.available_events = {
    [FrameEventType.MOUSE_CLICK] = true,
    [FrameEventType.MOUSE_ENTER] = true,
    [FrameEventType.MOUSE_LEAVE] = true,
    [FrameEventType.MOUSE_UP] = true,
    [FrameEventType.MOUSE_DOWN] = true,
    [FrameEventType.MOUSE_WHEEL] = true,
}

return static