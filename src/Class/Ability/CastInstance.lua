--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type AbilityTypeClass
local AbilityType = require('Class.Ability.Type')

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
---@param target unit|item|destructable|table|nil
---@param ability AbilityType
---@return boolean
function static.new(caster, target, ability)
    local instance = Class.allocate(AbilityCastInstance)
    private.newData(instance, caster, target, ability)

    local status = ability:runCallback(AbilityType.CallbackType.START, instance)
    if status == AbilityType.Status.OK then
        return instance
    elseif status == AbilityType.Status.CANCEL then
        ability:runCallback(AbilityType.CallbackType.CANCEL ,instance)
    elseif status == AbilityType.Status.FINISH then
        ability:runCallback(AbilityType.CallbackType.FINISH ,instance)
    elseif status == AbilityType.Status.INTERRUPT then
        ability:runCallback(AbilityType.CallbackType.INTERRUPT ,instance)
    end
end

--========
-- Public
--========

---@param dt number
---@return boolean
function public:casting(dt)
    local priv = private.data[self]

    if priv.status ~= static.Status.OK then
        return false
    end

    local status = priv.ability:runCallback(AbilityType.CallbackType.CASTING, self)
    if status == AbilityType.Status.OK then
        priv.time_left = priv.time_left - dt
        if priv.time_left <= 0 then 
            priv.ability:runCallback(AbilityType.CallbackType.FINISH, self)
            return false
        end
        return true
    elseif status == AbilityType.Status.CANCEL then
        priv.ability:runCallback(AbilityType.CallbackType.CANCEL, self)
    elseif status == AbilityType.Status.FINISH then
        priv.ability:runCallback(AbilityType.CallbackType.FINISH, self)
    elseif status == AbilityType.Status.INTERRUPT then
        priv.ability:runCallback(AbilityType.CallbackType.INTERRUPT, self)
    end
    return false
end

function public:cancel()
    local priv = private.data[self]

    if priv.status == static.Status.OK then
        priv.callbacks:runCancel(self)
        private.unlockUnit(priv.caster)
    end
    priv.status = static.Status.CANCEL
end

function public:interrupt()
    local priv = private.data[self]

    if priv.status == static.Status.OK then
        priv.callbacks:runInterrupt(self)
        private.unlockUnit(priv.caster)
    end
    priv.status = static.Status.INTERRUPT
end

function public:finish()
    local priv = private.data[self]

    if priv.status == static.Status.OK then
        priv.callbacks:runFinish(self)
        private.unlockUnit(priv.caster)
    end
    priv.status = static.Status.FINISH
end

---@return number
function public:getCastingTimeLeft()
    return private.data[self].time_left
end

---@return number
function public:getFullCastingTime()
    return private.data[self].full_time
end

---@return unit
function public:getCaster()
    return private.data[self].caster
end

---@return any
function public:getTarget()
    return private.data[self].caster
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

function private.lockUnit(unit)
    UnitAddAbility(unit, private.disable_move_id)
    UnitAddAbility(unit, private.disable_attack_id)
end

function private.unlockUnit(unit)
    UnitRemoveAbility(unitX, private.disable_attack_id)
    UnitRemoveAbility(unitX, private.disable_move_id)
    UnitRemoveAbility(unitX, private.disable_move_buff_id)
end

---@param self AbilityCastInstance
---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability AbilityType
---@return AbilityCastInstance
function private.newData(self, caster, target, ability)
    local priv = {
        status = static.Status.OK,
        caster = caster,
        target = target,
        ability = ability,
        full_time = -1,
        time_left = -1,
    }
    private.data[self] = setmetatable(priv, private.metatable)

    local time_left = ability.callbacks:getCastingTime(self)
    priv.full_time = time_left
    priv.time_left = time_left
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
    local Icons = require('compiletime.Icon')
    local WeBuff = ObjEdit.Buff
    local id = ObjEdit:getBuffId()
    local buff_type = WeBuff.new(id, 'Bfae', 'DisableMovement')
    buff_type:setField(WeBuff.Field.TooltipNormal, 'Ability casting')
    buff_type:setField(WeBuff.Field.TooltipNormalExtended, 'Unit can not move while casting an ability.')
    buff_type:setField(WeBuff.Field.IconNormal, Icons.BTNBrilliance)
    return id
end)
private.disable_move_id = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local WeAbility = ObjEdit.Ability
    local id = ObjEdit:getAbilityId()
    local abil_type = WeAbility.new(id, 'Aasl', 'DisableMovement')
    abil_type:setField(WeAbility.Field.Aasl_MovementSpeedFactor, 1, -100)
    abil_type:setField(WeAbility.Field.TargetsAllowed, 1, "self")
    abil_type:setField(WeAbility.Field.Buffs, 1, private.disable_move_buff_id)
    return id
end)
private.disable_attack_id = ID('Abun')

return static