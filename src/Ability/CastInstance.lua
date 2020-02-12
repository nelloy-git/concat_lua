--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityTypeClass
local AbilityType = require('Ability.Type')
local CbType = AbilityType.CallbackType
local Status = AbilityType.Status

---@type UnitClass
local Unit = require('Unit.Unit')
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

local GetCasterInstances
---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability AbilityType
---@return boolean
function static.new(caster, target, ability)
    local instance = Class.allocate(AbilityCastInstance)
    private.newData(instance, caster, target, ability)

    local priv = private.data[instance]
    local status = priv.status
    if status == Status.OK then
        private.applyBlocks(instance)
        return instance
    elseif status == Status.CANCEL then
        ability:runCallback(CbType.CANCEL, instance)
    elseif status == Status.FINISH then
        ability:runCallback(CbType.FINISH, instance)
    elseif status == Status.INTERRUPT then
        ability:runCallback(CbType.INTERRUPT, instance)
    end
    return
end

--========
-- Public
--========

---@param dt number
---@return boolean
function public:casting(dt)
    local priv = private.data[self]

    if priv.status ~= Status.OK then
        return false
    end

    local ability = priv.ability
    local status = ability:runCallback(CbType.CASTING, self)
    priv.time_left = priv.time_left - dt
    if priv.time_left <= 0 then
        status = Status.FINISH
    end

    if status == Status.OK then
        return true
    end

    private.removeBlocks(self)
    if status == Status.CANCEL then
        ability:runCallback(CbType.CANCEL, self)
    elseif status == Status.FINISH then
        ability:runCallback(CbType.FINISH, self)
    elseif status == Status.INTERRUPT then
        ability:runCallback(CbType.INTERRUPT, self)
    end

    return false
end

function public:cancel()
    local priv = private.data[self]
    local ability = priv.ability

    if priv.status == Status.OK then
        private.removeBlocks(self)
        ability:runCallback(CbType.CANCEL, self)
        priv.status = Status.CANCEL
    end
end

function public:interrupt()
    local priv = private.data[self]
    local ability = priv.ability

    if priv.status == Status.OK then
        private.removeBlocks(self)
        ability:runCallback(CbType.INTERRUPT, self)
        priv.status = Status.INTERRUPT
    end
end

function public:finish()
    local priv = private.data[self]
    local ability = priv.ability

    if priv.status == Status.OK then
        private.removeBlocks(self)
        ability:runCallback(CbType.FINISH, self)
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

---@param self AbilityCastInstance
function private.applyBlocks(self)
    local priv = private.data[self]

    if not priv.caster_can_attack then
        ---@type Unit
        local u = Unit.getInstance(priv.caster)
        u:enableAttack(false)
        --UnitParam.get(priv.caster):addMult(Param.ASpd, -private.multiplier)
        --UnitAddAbility(priv.caster, private.disable_attack_id)
    end

    if not priv.caster_can_move then
        ---@type Unit
        local u = Unit.getInstance(priv.caster)
        u.Param:add(Param.MS, Value.MULT, -private.multiplier)
        --UnitParam.get(priv.caster):addMult(Param.MS, -private.multiplier)
        --UnitAddAbility(priv.caster, private.disable_move_id)
    end

    if priv.cancel_other then
        GetCasterInstances = GetCasterInstances or require('Ability.Event').getCasterInstances
        local list = GetCasterInstances(priv.caster)
        for i = 1, #list do
            if not private.data[list[i]].ignore_cancel_by_others then
                list[i]:cancel()
            end
        end
    end
end

---@param self AbilityCastInstance
function private.removeBlocks(self)
    local priv = private.data[self]

    if not priv.caster_can_attack then
        ---@type Unit
        local u = Unit.getInstance(priv.caster)
        u:enableAttack(true)
        --UnitParam.get(priv.caster):addMult(Param.ASpd, private.multiplier)
        --UnitRemoveAbility(priv.caster, private.disable_attack_id)
    end

    if not priv.caster_can_move then
        ---@type Unit
        local u = Unit.getInstance(priv.caster)
        u.Param:add(Param.MS, Value.MULT, private.multiplier)
        --UnitParam.get(priv.caster):addMult(Param.MS, private.multiplier)
        --UnitRemoveAbility(priv.caster, private.disable_move_id)
        --UnitRemoveAbility(priv.caster, private.disable_move_buff_id)
    end
end

---@param self AbilityCastInstance
---@param caster unit
---@param target table
---@param ability AbilityType
---@return AbilityCastInstance
function private.newData(self, caster, target, ability)
    local priv = {
        status = Status.OK,
        caster = caster,
        target = target,
        ability = ability,

        full_time = -1,
        time_left = -1,
        caster_can_move = true,
        caster_can_attack = true,
        cancel_other = true,
        ignore_cancel_by_others = false
    }
    private.data[self] = setmetatable(priv, private.metatable)

    local time_left = ability:runCallback(CbType.GET_TIME, self)
    priv.full_time = time_left
    priv.time_left = time_left

    priv.status = ability:runCallback(CbType.START, self)
    priv.caster_can_move = ability:runCallback(CbType.CASTER_CAN_MOVE, self)
    priv.caster_can_attack = ability:runCallback(CbType.CASTER_CAN_ATTACK, self)
    priv.cancel_other = ability:runCallback(CbType.CASTER_CANCEL_OTHER_CASTS, self)
    priv.ignore_cancel_by_others = ability:runCallback(CbType.IGNORE_CANCEL_BY_OTHER_CASTS, self)
end

private.metatable = {
    __gc = function(self) end
}

--=============
-- Compiletime
--=============

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

return static