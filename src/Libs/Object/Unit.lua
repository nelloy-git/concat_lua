--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type UtilsLib
local UtilsLib = require(Lib.Utils)
local Obj = UtilsLib.Obj
local checkType = UtilsLib.Functions.checkType

--=======
-- Class
--=======

local Unit = Class.new('Unit', Obj)
---@class Unit : Obj
local public = Unit.public
---@class UnitClass : ObjClass
local static = Unit.static
---@type UnitClass
local override = Unit.override
local private = {}

--=========
-- Static
--=========

---@param id number
---@param owner player
---@param x number
---@param y number
---@param child_instance Unit | nil
---@return Unit
function override.new(id, owner, x, y, child_instance)
    checkType(id, 'number', 'id')
    checkType(owner, 'player', 'owner')
    checkType(x, 'number', 'x')
    checkType(y, 'number', 'y')
    if child_instance then
        checkType(child_instance, Unit, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Unit)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetUnitX(self:getObj())
end

---@return number
function public:getY()
    return GetUnitY(self:getObj())
end

---@return number
function public:getZ()
    return GetUnitFlyHeight(self:getObj())
end

---@param x number
function public:setX(x)
    SetUnitX(self:getObj(), x)
end

---@param y number
function public:setY(y)
    SetUnitY(self:getObj(), y)
end

---@param z number
function public:setZ(z)
    SetUnitFlyHeight(self:getObj(), z, 1000000)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Unit
function private.newData(self)
    local priv = {
    }
    private.data[self] = priv
end

return static