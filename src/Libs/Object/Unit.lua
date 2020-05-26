--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
local UtilsLib = depencies.UtilsLib
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

---@param unit_id number
---@param x number
---@param y number
---@param owner player
---@param child_instance Unit | nil
---@return Unit
function override.new(unit_id, x, y, owner, child_instance)
    checkType(unit_id, 'number', 'unit_id')
    checkType(x, 'number', 'x')
    checkType(y, 'number', 'y')
    checkType(owner, 'player', 'owner')
    if child_instance then
        checkType(child_instance, Unit, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Unit)
    instance = Obj.new(CreateUnit(owner, unit_id, x, y, 0), RemoveUnit, instance)
    private.newData(instance, owner)

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
---@param rate number | nil
function public:setZ(z, rate)
    SetUnitFlyHeight(self:getObj(), z, rate or 0)
end

---@return player
function public:getOwner()
    return private.data[self].owner
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Unit
function private.newData(self, owner)
    local priv = {
        owner = owner
    }
    private.data[self] = priv
end

return static