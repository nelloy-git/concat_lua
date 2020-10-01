--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

--=======
-- Class
--=======

local Effect = Class.new('Effect', Handle)
---@class Effect : Handle
local public = Effect.public
---@class EffectClass : HandleClass
local static = Effect.static
---@type EffectClass
local override = Effect.override
local private = {}

--=========
-- Static
--=========

---@param model string
---@param x number
---@param y number
---@param child Effect | nil
---@return Effect
function override.new(model, x, y, child)
    isTypeErr(model, 'string', 'model')
    isTypeErr(x, 'number', 'x')
    isTypeErr(y, 'number', 'y') 
    if child then isTypeErr(child, Effect, 'child') end

    local instance = child or Class.allocate(Effect)
    instance = Handle.new(AddSpecialEffect(model, x, y), DestroyEffect, instance)

    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
---@param z number
function public:setPos(x, y, z)
    BlzSetSpecialEffectPosition(self:getData(), x, y, z)
end

---@return number
function public:getX()
    return BlzGetLocalSpecialEffectX(self:getData())
end

---@return number
function public:getY()
    return BlzGetLocalSpecialEffectY(self:getData())
end

---@return number
function public:getZ()
    return BlzGetLocalSpecialEffectZ(self:getData())
end

---@param yaw number
---@param pitch number
---@param roll number
function public:setAngles(yaw, pitch, roll)
    BlzSetSpecialEffectOrientation(self:getData(), yaw, pitch, roll)
end

--- [0,1]
---@param r number
---@param g number
---@param b number
---@param a number
function public:setColor(r, g, b, a)
    r = r < 0 and 0 or r > 1 and 1 or r
    g = g < 0 and 0 or g > 1 and 1 or g
    b = b < 0 and 0 or b > 1 and 1 or b
    a = a < 0 and 0 or a > 1 and 1 or a

    BlzSetSpecialEffectColor(self:getData(),
                             math.floor(255 * r),
                             math.floor(255 * g),
                             math.floor(255 * b))
    BlzSetSpecialEffectAlpha(self:getData(), math.floor(a))
end

--=========
-- Private
--=========

return static