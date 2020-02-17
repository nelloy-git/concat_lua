--=========
-- Include
--=========

local Class = require('Utils.Class.Class')
local Log = require('Utils.Log')

---@type UnitObjClass
local UnitObj = require('Object.Unit')
---@type ParameterAPI
local ParamAPI = require('Parameter.API')
local Param = ParamAPI.ParamType
local Value = ParamAPI.ValueType
---@type UnitAnimationClass
local UnitAnimation = require('Unit.Animation')
---@type InventoryAPI
local InventoryAPI = require('Unit.Inventory.API')

--=======
-- Class
--=======

local Unit = Class.new('Unit', UnitObj)
---@class Unit : UnitObj
local public = Unit.public
---@class UnitClass : UnitObjClass
local static = Unit.static
---@type UnitClass
local override = Unit.override
local private = {}

--========
-- Static
--========

---@param unit_type UnitType
---@param owner player
---@param x number
---@param y number
---@return Unit
function override.new(unit_type, owner, x, y)
    local instance = Class.allocate(Unit)
    instance = UnitObj.new(owner, unit_type:getId(), x, y, 0, instance)

    private.newData(instance, owner)

    instance.Param = ParamAPI.newUnitContainer(instance:getObj())
    instance.Animation = UnitAnimation.new(instance:getObj())
    instance.Bag = InventoryAPI.Bag.new(instance, 20)

    return instance
end

---@param obj_or_id unit | number
function override.getInstance(obj_or_id)
    if type(obj_or_id) == 'number' then
        return private.id2unit[obj_or_id]
    end
    return UnitObj.getInstance(obj_or_id)
end

--========
-- Public
--========

public.Param = nil
public.Animation = nil
public.Bag = nil

---@return number
function public:getId()
    return private.data[self].id
end

---@return player
function public:getOwner()
    return private.data[self].owner
end

---@return number
function public:getMoveSpeed()
    return self.Param:getResult(Param.MS)
end

---@return number
function public:getTurnSpeed()
    return GetUnitTurnSpeed(self:getObj())
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.cur_id = 1
private.id2unit = setmetatable({},  {__mode = 'v'})

---@param unit Unit
---@return number
function private.newId(unit)
    local id = private.cur_id
    private.cur_id = id + 1

    private.id2unit[id] = unit
    return id
end

---@param self Unit
---@param owner player
function private.newData(self, owner)
    local priv = {
        id = private.newId(self),
        owner = owner,
    }
    private.data[self] = priv
end

return static