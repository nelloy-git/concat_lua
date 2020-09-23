--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib)
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame) or error('')
local Tooltip = FrameLib.Normal.Tooltip
---@type TypesLib
local TypesLib = require(LibList.TypesLib) or error('')
local FrameEventType = TypesLib.FrameEventTypeEnum or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local InterfaceSpellButtons = Class.new('InterfaceSpellButtons', Frame)
---@class InterfaceSpellButtons : Frame
local public = InterfaceSpellButtons.public
---@class InterfaceSpellButtonsClass : FrameClass
local static = InterfaceSpellButtons.static
---@type InterfaceSpellButtonsClass
local override = InterfaceSpellButtons.override
local private = {}

--=========
-- Static
--=========

local static_instance = nil

---@return InterfaceSpellButtons
function override.new()
    if static_instance then
        Log:wrn('It is static class.')
        return static_instance
    end

    local instance = Class.allocate(InterfaceSpellButtons)
    instance = Frame.new(private.fdf:getName(), private.fdf:isSimple(), instance)

    private.newData(instance)

    static_instance = instance
    return instance
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    Log:wrn(tostring(InterfaceSpellButtons)..': it is autosized frame.')
end

---@return number
function public:getWidth()
    return 7 * private.data[self].button_borders[1]:getWidth()
end

---@return number
function public:getHeight()
    return private.data[self].button_borders[1]:getHeight()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceSpellButtons
function private.newData(self)
    local priv = {
        buttons = {},
        button_borders = {},
        tooltip = FrameLib.Origin.Tooltip
    }
    private.data[self] = priv
    self:setAlpha(0)

    local w = 1.2 * FrameLib.Origin.SkillButton[1]:getWidth()
    local h = 1.2 * FrameLib.Origin.SkillButton[1]:getHeight()
    for i = 1, 7 do
        local border = Frame.new(private.fdf:getName(), private.fdf:isSimple())
        border:setParent(self)
        border:setPos((i - 1) * w, 0)
        border:setSize(w, h)
        border:setAlpha(1)
        table.insert(priv.button_borders, #priv.button_borders + 1, border)

        local btn = FrameLib.Origin.SkillButton[i + 5]
        btn:setParent(border)
        btn:setPos((w - btn:getWidth()) / 2, (h - btn:getHeight()) / 2)
        table.insert(priv.buttons, #priv.buttons + 1, btn)
    end

    priv.tooltip:setParent(self)
    -- Native bind with leftbottom point
    BlzFrameSetPoint(priv.tooltip:getData(), FRAMEPOINT_BOTTOMLEFT,
                     self:getData(), FRAMEPOINT_TOPLEFT, 0, 0)
    priv.tooltip:setAlpha(1)
end

private.fdf = FrameLib.Fdf.Normal.Backdrop.new('InterfaceSpellButtonBorder')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setBackgroundTileMode(true)
private.fdf:setBackgroundTileSize(0.2)
private.fdf:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf:setBlendAll(true)
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf:setCornerSize(0.0125)
private.fdf:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

return static