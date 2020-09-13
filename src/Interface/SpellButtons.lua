--=========
-- Include
--=========

local Class = require(LibList.ClassLib)
---@type FrameLib
local FrameLib = require(LibList.FrameLib)
local FrameNormalBase = FrameLib.Frame.Normal.Base
local FrameNormalBasePublic = Class.getPublic(FrameNormalBase)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local Log = UtilsLib.Log

--=======
-- Class
--=======

local InterfaceSpellButtons = Class.new('InterfaceSpellButtons', FrameNormalBase)
---@class InterfaceSpellButtons : FrameNormalBase
local public = InterfaceSpellButtons.public
---@class InterfaceSpellButtonsClass : FrameNormalBaseClass
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
    instance = FrameNormalBase.new(private.fdf, instance)

    private.newData(instance)

    static_instance = instance
    return instance
end

--========
-- Public
--========

----@param x number
----@param y number
--function public:setPos(x, y)
--    local priv = private.data[self]
--    FrameNormalBasePublic.setPos(self, x, y)
--end

---@param width number
---@param height number
function public:setSize(width, height)
    local priv = private.data[self]
    FrameNormalBasePublic.setSize(self, width, height)

    local w = width / 8
    for i = 1, #priv.button_borders do
        local border = priv.button_borders[i]
        border:setPos((i - 0.5) * w, 0.05 * self:getHeight())
        border:setSize(w, w)

        local btn = priv.buttons[i]
        btn:setPos(0.15 * w, 0.15 * w)
        btn:setSize(0.7 * w, 0.7 * w)
    end
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]
    FrameNormalBasePublic.setVisible(self, flag)

    --priv.minimap:setVisible(flag)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceSpellButtons
function private.newData(self)
    local priv = {
        buttons = {},
        button_borders = {}
    }
    private.data[self] = priv

    local w = self:getWidth() / 7.5
    for i = 6, 12 do
        local border = FrameLib.Frame.Normal.Base.new(private.fdf)
        border:setParent(self)
        border:setPos((i - 5.5) * w, 0.1 * self:getHeight())
        border:setSize(w, w)
        table.insert(priv.button_borders, #priv.button_borders + 1, border)

        local btn = FrameLib.Origin.SkillButton[i]
        btn:setParent(border)
        btn:setPos(0.15 * w, 0.15 * w)
        btn:setSize(0.7 * w, 0.7 * w)
        table.insert(priv.buttons, #priv.buttons + 1, btn)
    end
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