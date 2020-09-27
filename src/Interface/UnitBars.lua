--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local SimpleBar = FrameLib.Simple.StatusBar or error('')
local SimpleBarPublic = Class.getPublic(SimpleBar)
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local InterfaceUnitBars = Class.new('InterfaceUnitBars', SimpleBar)
---@class InterfaceUnitBars : FrameSimpleStatusBar
local public = InterfaceUnitBars.public
---@class InterfaceUnitBarsClass : FrameSimpleStatusBarClass
local static = InterfaceUnitBars.static
---@type InterfaceUnitBarsClass
local override = InterfaceUnitBars.override
local private = {}

--=========
-- Static
--=========

---@return InterfaceUnitBars
function override.new()
    local instance = Class.allocate(InterfaceUnitBars)
    instance = SimpleBar.new(instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    SimpleBarPublic.setPos(self, x, y)
    private.updatePos(self)
end

---@param width number
---@param height number
function public:setSize(width, height)
    SimpleBarPublic.setSize(self, width, height)
    private.updatePos(self)
end

function public:setVisible(flag)
    SimpleBarPublic.setVisible(self, flag)

    local priv = private.data[self]
    priv.hp_bar:setVisible(flag)
    priv.mp_bar:setVisible(flag)
end

function public:setHealth(val, max)
    private.setValue(private.data[self].hp_bar, val, max)
end

function public:setMana(val, max)
    private.setValue(private.data[self].mp_bar, val, max)
end

function public:setShield(val, max)
    private.setValue(self, val, max)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.hp_texture = 'Replaceabletextures\\Teamcolor\\Teamcolor00.blp'
private.mp_texture = 'Replaceabletextures\\Teamcolor\\Teamcolor01.blp'
private.sh_texture = 'Replaceabletextures\\Teamcolor\\Teamcolor02.blp'
private.font = 'fonts\\nim_____.ttf'
private.font_size = 0.007

---@param self InterfaceUnitBars
function private.newData(self)
    local priv = {
        hp_bar = SimpleBar.new(),
        mp_bar = SimpleBar.new(),
    }
    private.data[self] = priv

    self:setBackground('Replaceabletextures\\Teamcolor\\Teamcolor27.blp', 0, true)
    self:setBar(private.sh_texture, 0, true)
    self:setBorder('UI\\Feedback\\XPBar\\human-xpbar-border.blp', 0, true)
    self:setFont(private.font, private.font_size)
    self:setProgress(0)
    self:setText('')

    priv.hp_bar:setBackground('Replaceabletextures\\Teamcolor\\Teamcolor27.blp', 0, true)
    priv.hp_bar:setBar(private.hp_texture, 0, true)
    priv.hp_bar:setBorder('UI\\Feedback\\XPBar\\human-xpbar-border.blp', 0, true)
    priv.hp_bar:setFont(private.font, private.font_size)
    priv.hp_bar:setProgress(0)
    priv.hp_bar:setText('')

    priv.mp_bar:setBackground('Replaceabletextures\\Teamcolor\\Teamcolor27.blp', 0, true)
    priv.mp_bar:setBar(private.mp_texture, 0, true)
    priv.mp_bar:setBorder('UI\\Feedback\\XPBar\\human-xpbar-border.blp', 0, true)
    priv.mp_bar:setFont(private.font, private.font_size)
    priv.mp_bar:setProgress(0)
    priv.mp_bar:setText('')

    private.updatePos(self)
end

---@param self InterfaceUnitBars
function private.updatePos(self)
    local priv = private.data[self]

    local x = self:getX()
    local y = self:getY()
    local w = self:getWidth()
    local h = self:getHeight()
    
    self:setFont(private.font, 0.8 * h)

    priv.hp_bar:setPos(x, y + h)
    priv.hp_bar:setSize(w, h)
    priv.hp_bar:setFont(private.font, 0.8 * h)

    priv.mp_bar:setPos(x, y + 2 * h)
    priv.mp_bar:setSize(w, h)
    priv.mp_bar:setFont(private.font, 0.8 * h)
end

---@param elem FrameSimpleStatusBar
---@param val number
---@param max number
function private.setValue(elem, val, max)
    if not (val or max) then
        elem:setProgress()
        elem:setText('')
        return
    end

    if max <= 0 then
        elem:setProgress(0)
        elem:setText('')
        return
    end

    val, _ = math.modf(val)
    max, _ = math.modf(max)
    local perc, _ = math.modf(100 * val / max)

    elem:setProgress(val / max)
    elem:setText(tostring(val)..' / '..tostring(max)..' ('..tostring(perc)..'%)')
end

return static