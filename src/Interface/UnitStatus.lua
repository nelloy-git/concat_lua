--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame) or error('')
local Screen = FrameLib.Screen or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local Log = UtilsLib.Log or error('')

---@type InterfaceUnitBars
local InterfaceUnitBars = require('Interface.UnitBars') or error('')
---@type InterfaceUnitBuffs
local InterfaceUnitBuffs = require('Interface.UnitBuffs') or error('')
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

    priv.bars:setPos(self:getAbsX() + priv.border:getWidth(),
                     self:getAbsY())

    priv.buffs:setPos(priv.bars:getAbsX(),
                      priv.bars:getAbsY() + 3 * priv.bars:getHeight())

    priv.params:setPos(self:getAbsX(), self:getAbsY() + self:getHeight())

    priv.portrait:setPos(self:getAbsX() + 0.065 * self:getHeight(),
                         self:getAbsY() + 0.065 * self:getHeight())
end

---@param w number
---@param h number
function public:setSize(w, h)
    local priv = private.data[self]
    FramePublic.setSize(self, w, h)

    priv.bars:setSize(w - h, h / 4)
    priv.border:setSize(h, h)
    priv.params:setSize(h, 2 * h)
    priv.portrait:setSize(0.87 * h, 0.87 * h)

    local i, f = math.modf(priv.buffs:getMaxCount() / priv.buffs:getPerLine())
    if f ~= 0 then i = i + 1 end
    priv.buffs:setSize(w - h, i * (w - h) / priv.buffs:getPerLine())

    self:setPos(self:getX(), self:getY())
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]

    priv.bars:setVisible(flag)
    priv.border:setVisible(flag)
    priv.buffs:setVisible(flag)
    priv.params:setVisible(flag)
    priv.portrait:setVisible(flag)
end

---@param cur number
---@param max number
function public:setShield(cur, max)
    local priv = private.data[self]
    priv.bars:setShield(cur, max)
end

---@param cur number
---@param max number
function public:setHealth(cur, max)
    local priv = private.data[self]
    priv.bars:setHealth(cur, max)
end

---@param cur number
---@param max number
function public:setMana(cur, max)
    local priv = private.data[self]
    priv.bars:setMana(cur, max)
end

---@param params ParameterValueList
function public:setParameters(params)
    private.data[self].params:setAllValues(params)
end

---@param buffs BuffContainer
function public:setBuffContainer(buffs)
    private.data[self].buffs:setBuffContainer(buffs)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceUnitStatus
function private.newData(self)
    local priv = {
        bars = InterfaceUnitBars.new(),
        border = Frame.new(private.fdf_border:getName(), private.fdf_border:isSimple()),
        buffs = InterfaceUnitBuffs.new(),
        params = InterfaceUnitParams.new(),
        portrait = FrameLib.Origin.Portrait,
    }
    private.data[self] = priv
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