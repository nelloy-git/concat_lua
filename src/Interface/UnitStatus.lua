--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib)
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local Log = UtilsLib.Log or error('')

---@type InterfaceUnitParamsClass
local InterfaceUnitParams = require('Interface.UnitParams') or error('')

--=======
-- Class
--=======

local InterfaceUnitStatus = Class.new('InterfaceUnitStatus', Frame)
---@class InterfaceUnitStatus : Frame
local public = InterfaceUnitStatus.public
---@class InterfaceUnitStatusClass : FrameClass
local static = InterfaceUnitStatus.static
---@type InterfaceUnitStatusClass
local override = InterfaceUnitStatus.override
local private = {}

--=========
-- Static
--=========

local static_instance = nil

---@return InterfaceUnitStatus
function override.new()
    if static_instance then
        Log:wrn('It is static class.')
        return static_instance
    end

    local instance = Class.allocate(InterfaceUnitStatus)
    instance = Frame.new(private.fdf:getName(), private.fdf:isSimple(), instance)

    private.newData(instance)

    static_instance = instance
    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    local priv = private.data[self]
    FramePublic.setPos(self, x, y)

    priv.border:setPos(self:getAbsX(), self:getAbsY())

    priv.portrait:setPos(self:getAbsX() + 0.065 * self:getHeight(),
                         self:getAbsY() + 0.065 * self:getHeight())

    priv.hp_bar:setPos(self:getAbsX() + priv.border:getWidth(),
                       self:getAbsY())

    priv.mp_bar:setPos(priv.hp_bar:getAbsX(),
                       priv.hp_bar:getAbsY() + priv.hp_bar:getHeight())

    priv.params:setPos(self:getAbsX(), self:getAbsY() + self:getHeight())
end

---@param w number
---@param h number
function public:setSize(w, h)
    local priv = private.data[self]
    FramePublic.setSize(self, w, h)

    priv.border:setSize(h, h)
    priv.portrait:setSize(0.87 * h, 0.87 * h)
    priv.hp_bar:setSize(w - h, h / 4)
    priv.hp_bar:setFont('fonts\\nim_____.ttf', 0.6 * priv.hp_bar:getHeight())
    priv.mp_bar:setSize(w - h, h / 4)
    priv.mp_bar:setFont('fonts\\nim_____.ttf', 0.6 * priv.mp_bar:getHeight())
    priv.params:setSize(h, 2 * h)

    self:setPos(self:getX(), self:getY())
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]

    priv.border:setVisible(flag)
    priv.portrait:setVisible(flag)
    priv.hp_bar:setVisible(flag)
    priv.mp_bar:setVisible(flag)
    priv.params:setVisible(flag)
end

---@param cur number
---@param max number
function public:setHealth(cur, max)
    local priv = private.data[self]

    if not (cur or max) then
        priv.hp_bar:setProgress()
        priv.hp_bar:setText('')
        return
    end

    cur, _ = math.modf(cur)
    max, _ = math.modf(max)
    local perc, _ = math.modf(100 * cur / max)

    priv.hp_bar:setProgress(cur / max)
    priv.hp_bar:setText(tostring(cur)..' / '..tostring(max)..' ('..tostring(perc)..'%)')
end

---@param cur number
---@param max number
function public:setMana(cur, max)
    local priv = private.data[self]

    if not (cur or max) then
        priv.mp_bar:setProgress()
        priv.mp_bar:setText('')
        return
    end

    cur, _ = math.modf(cur)
    max, _ = math.modf(max)
    local perc, _ = math.modf(100 * cur / max)

    priv.mp_bar:setProgress(cur / max)
    priv.mp_bar:setText(tostring(cur)..' / '..tostring(max)..' ('..tostring(perc)..'%)')
end

---@param params ParameterValueList
function public:setParameters(params)
    private.data[self].params:setAllValues(params)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceUnitStatus
function private.newData(self)
    local priv = {
        portrait = FrameLib.Origin.Portrait,
        border = Frame.new(private.fdf_border:getName(), private.fdf_border:isSimple()),
        hp_bar = FrameLib.Simple.StatusBar.new(),
        mp_bar = FrameLib.Simple.StatusBar.new(),
        params = InterfaceUnitParams.new()
    }
    private.data[self] = priv

    priv.hp_bar:setBackground('Replaceabletextures\\Teamcolor\\Teamcolor27.blp', 0, true)
    priv.hp_bar:setBar('Replaceabletextures\\Teamcolor\\Teamcolor00.blp', 0, true)
    priv.hp_bar:setBorder('UI\\Feedback\\XPBar\\human-xpbar-border.blp', 0, true)
    priv.hp_bar:setFont('fonts\\nim_____.ttf', 0.008)
    priv.hp_bar:setProgress(0)
    priv.hp_bar:setText('')

    priv.mp_bar:setBackground('Replaceabletextures\\Teamcolor\\Teamcolor27.blp', 0, true)
    priv.mp_bar:setBar('Replaceabletextures\\Teamcolor\\Teamcolor01.blp', 0, true)
    priv.mp_bar:setBorder('UI\\Feedback\\XPBar\\human-xpbar-border.blp', 0, true)
    priv.mp_bar:setFont('fonts\\nim_____.ttf', 0.008)
    priv.mp_bar:setProgress(0)
    priv.mp_bar:setText('')
end

private.fdf = FrameLib.Fdf.Normal.Backdrop.new('InterfacePortrait')
private.fdf:setBlendAll(true)
private.fdf:setBackground('war3mapImported\\Icons\\Transparent32x32.tga')
private.fdf:setWidth(0.1)
private.fdf:setHeight(0.1)

private.fdf_border = FrameLib.Fdf.Normal.Backdrop.new('InterfacePortraitBorder')
private.fdf_border:setWidth(0.04)
private.fdf_border:setHeight(0.04)
private.fdf_border:setBackgroundTileMode(true)
private.fdf_border:setBackgroundTileSize(0.2)
private.fdf_border:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf_border:setBlendAll(true)
private.fdf_border:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf_border:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf_border:setCornerSize(0.0125)
private.fdf_border:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

return static