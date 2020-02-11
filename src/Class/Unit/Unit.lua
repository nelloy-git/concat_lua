--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type UnitObjClass
local UnitObj = require('Object.Unit')
---@type ParameterAPI
local ParamAPI = require('Parameter.API')
local Param = ParamAPI.ParamType
local Value = ParamAPI.ValueType
---@type UnitAnimationClass
local UnitAnimation = require('Class.Unit.Animation')
---@type InventoryAPI
local InventoryAPI = require('Class.Unit.Inventory.Api')

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

---@param player player
---@param id string | number
---@param x number
---@param y number
---@param face number
---@return Unit
function override.new(player, id, x, y, face)
    local instance = Class.allocate(Unit)
    instance = UnitObj.new(player, id, x, y, face, instance)

    private.newData(instance, player, id)

    instance.Param = ParamAPI.newUnitContainer(instance:getObj())
    instance.Animation = UnitAnimation.new(instance:getObj())
    instance.Bag = InventoryAPI.newBag(instance:getObj(), 20)

    return instance
end

--========
-- Public
--========

public.Param = nil
public.Animation = nil
public.Bag = nil

---@param x number
function public:setX(x)
    SetUnitX(self:getObj(), x)
end

---@param y number
function public:setY(y)
    SetUnitY(self:getObj(), y)
end

---@param angle number
---@param time number | nil
function public:setFacing(angle, time)
    SetUnitFacingTimed(self:getObj(), angle, time or 0)
end

---@return number
function public:getId()
    return private.data[self].id
end

---@return player
function public:getOwner()
    return private.data[self].owner
end

function public:getMoveSpeed()
    return self.Param:getResult(Param.MS)
end

---@return number
function public:getX()
    return GetUnitX(self:getObj())
end

---@return number
function public:getY()
    return GetUnitY(self:getObj())
end

---@return number
function public:getFacing()
    return GetUnitFacing(self:getObj())
end

---@return number
function public:getTurnSpeed()
    return GetUnitTurnSpeed(self:getObj())
end

function public:enableMove(flag)
    local priv = private.data[self]
    if flag then
        if priv.disable_move_refs == 0 then
            Log.error(self, 'move is already enabled.', 2)
        end

        priv.disable_move_refs = priv.disable_move_refs - 1

        if priv.disable_move_refs == 0 then
            UnitAddAbility(self:getObj(), ID('Amov'))
            SetUnitPathing(self:getObj(), true)
        end

        return
    end

    priv.disable_move_refs = priv.disable_move_refs + 1

    if priv.disable_move_refs == 1 then
        UnitRemoveAbility(self:getObj(), ID('Amov'))
        --SetUnitPathing(self:getObj(), false)
    end
end

function public:enableAttack(flag)
    local priv = private.data[self]
    if flag then
        if priv.disable_attack_refs == 0 then
            Log.error(self, 'attack is already enabled.', 2)
        end

        priv.disable_attack_refs = priv.disable_attack_refs - 1

        if priv.disable_attack_refs == 0 then
            UnitRemoveAbility(self:getObj(), ID('Abun'))
        end

        return
    end

    priv.disable_attack_refs = priv.disable_attack_refs + 1

    if priv.disable_attack_refs == 1 then
        UnitAddAbility(self:getObj(), ID('Abun'))
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Unit
---@param player player
---@param id string | number
function private.newData(self, player, id)
    local num_id = ID(id)
    local priv = {
        id = num_id,
        owner = player,

        disable_move_refs = 0,
        disable_attack_refs = 0
    }

    private.data[self] = priv
end

return static