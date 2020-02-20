--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityTypeClass
local AbilityType = require('Ability.Type')
local Status = AbilityType.Status

---@type UnitClass
local UnitAPI = require('Unit.API')
local Unit = UnitAPI.Unit
---@type ParameterAPI
local ParamAPI = require('Parameter.API')
local Param = ParamAPI.ParamType
local Value = ParamAPI.ValueType

--=======
-- Class
--=======

---@type any
local AbilityCastInstance = Class.new('AbilityCastInstance')
---@class AbilityCastInstance
local public = AbilityCastInstance.public
---@class AbilityCastInstanceClass
local static = AbilityCastInstance.static
---@type AbilityCastInstanceClass
local override = AbilityCastInstance.override
local private = {}

--========
-- Static
--========

---@param caster unit
---@param target AbilityTarget
---@param ability Ability
---@return boolean
function static.new(caster, target, ability)
    local instance = Class.allocate(AbilityCastInstance)
    private.newData(instance, caster, target, ability)

    local priv = private.data[instance]
    priv.status = priv.ability_type:start(caster, target, priv.lvl)

    if priv.status == Status.OK then
        private.applyBlocks(priv)
        return instance
    elseif priv.status == Status.CANCEL then
        priv.ability_type:cancel(caster, target, priv.lvl)
    elseif priv.status == Status.FINISH then
        priv.ability_type:finish(caster, target, priv.lvl)
    elseif priv.status == Status.INTERRUPT then
        priv.ability_type:interrupt(caster, target, priv.lvl)
    end
end

--========
-- Public
--========

---@param dt number
---@return boolean
function public:casting(dt)
    local priv = private.data[self]

    if priv.status ~= Status.OK then
        return priv.status
    end

    priv.status = priv.ability_type:cast(priv.caster, priv.target, priv.lvl)
    priv.time_left = priv.time_left - dt

    if priv.time_left <= 0 then
        priv.status = Status.FINISH
    end

    if priv.status == Status.OK then
        return priv.status
    end

    private.removeBlocks(priv)
    if priv.status == Status.CANCEL then
        priv.ability_type:cancel(priv.caster, priv.target, priv.lvl)
    elseif priv.status == Status.FINISH then
        priv.ability_type:finish(priv.caster, priv.target, priv.lvl)
    elseif priv.status == Status.INTERRUPT then
        priv.ability_type:interrupt(priv.caster, priv.target, priv.lvl)
    end

    return priv.status
end

function public:cancel()
    local priv = private.data[self]
    local ability = priv.ability

    if priv.status == Status.OK then
        private.removeBlocks(priv)
        priv.ability_type:cancel(priv.caster, priv.target, priv.lvl)
        priv.status = Status.CANCEL
    end
end

function public:interrupt()
    local priv = private.data[self]
    local ability = priv.ability

    if priv.status == Status.OK then
        private.removeBlocks(priv)
        priv.ability_type:interrupt(priv.caster, priv.target, priv.lvl)
        priv.status = Status.INTERRUPT
    end
end

function public:finish()
    local priv = private.data[self]
    local ability = priv.ability

    if priv.status == Status.OK then
        private.removeBlocks(priv)
        priv.ability_type:finish(priv.caster, priv.target, priv.lvl)
        priv.status = Status.FINISH
    end
end

---@return number
function public:getTimeLeft()
    return private.data[self].time_left
end

---@return number
function public:getFullTime()
    return private.data[self].full_time
end

---@return unit
function public:getCaster()
    return private.data[self].caster
end

---@return table
function public:getTarget()
    return private.data[self].target
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.multiplier = 10^5

function private.applyBlocks(priv)
    priv.caster:enableAttack(false)
    priv.caster:getParameters():add(Param.MS, Value.MULT, -private.multiplier)
end

function private.removeBlocks(priv)
    priv.caster:enableAttack(true)
    priv.caster:getParameters():add(Param.MS, Value.MULT, private.multiplier)
end

---@param self AbilityCastInstance
---@param caster unit
---@param target table
---@param ability Ability
---@return AbilityCastInstance
function private.newData(self, caster, target, ability)
    local ability_type = ability:getType()
    local lvl = ability:getLevel()
    local time = ability_type:getCastingTime(caster, lvl)

    local priv = {
        status = Status.OK,
        caster = caster,
        target = target,
        lvl = lvl,
        ability_type = ability_type,

        full_time = time,
        time_left = time,
    }
    private.data[self] = priv
end


--=============
-- Compiletime
--=============
--[[
private.disable_move_buff_id = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local Icons = require('Resources.Icon')
    local WeBuff = ObjEdit.Buff
    local id = ObjEdit:getBuffId()
    local buff_type = WeBuff.new(id, 'Bfae', 'DisableMovement')
    buff_type:setField(WeBuff.Field.TooltipNormal, 'Ability casting')
    buff_type:setField(WeBuff.Field.TooltipNormalExtended, 'Unit can not move while casting an ability.')
    buff_type:setField(WeBuff.Field.IconNormal, Icons.BTNBrilliance)
    return ID(id)
end)
private.disable_move_id = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local WeAbility = ObjEdit.Ability
    local id = ObjEdit:getAbilityId()
    local abil_type = WeAbility.new(id, 'Aasl', 'DisableMovement')
    abil_type:setField(WeAbility.Field.Aasl_MovementSpeedFactor, 1, -100)
    abil_type:setField(WeAbility.Field.TargetsAllowed, 1, "self")
    abil_type:setField(WeAbility.Field.Buffs, 1, ID2str(private.disable_move_buff_id))
    return ID(id)
end)
private.disable_attack_id = ID('Abun')
]]
return static