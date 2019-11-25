--=========
-- Include
--=========

---@type AbilityTypeClass
local AbilityType = require('Class.Ability.AbilityType')
---@type ActionClass
local Action = require('Class.Action')
---@type BetterTimerClass
local BetterTimer = require('Class.Timer.BetterTimer')
---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

---@type AbilityCastingClass
local AbilityCasting = newClass('AbilityCasting')

---@class AbilityCasting
local public = AbilityCasting.public
---@class AbilityCastingClass
local static = AbilityCasting.static
---@type table
local override = AbilityCasting.override
---@type table(AbilityCasting, table)
local private = {}

public.time_left = 0

private.DB = DataBase.new('userdata', getClassName(AbilityCasting))
private.ms_const = 10^10
private.disable_attack_id = ID('Abun')

private.attack_order = 851983
if not is_compiletime then
    private.timer = BetterTimer.getGlobalTimer()
    private.timer_period = private.timer:getPeriod()

    private.wc3_spell_effect_trigger = Trigger.new()
    private.wc3_unit_issued_order_trigger = Trigger.new()
    private.wc3_unit_issued_point_order_trigger = Trigger.new()
    private.wc3_unit_issued_target_order_trigger = Trigger.new()
    private.wc3_unit_issued_unit_order_trigger = Trigger.new()
    Debug("Spell trigger:", private.wc3_spell_effect_trigger)
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local pl = Player(i)
        private.wc3_spell_effect_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, pl)
        private.wc3_unit_issued_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_ORDER, pl)
        private.wc3_unit_issued_point_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, pl)
        private.wc3_unit_issued_target_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, pl)
        private.wc3_unit_issued_unit_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER, pl)
    end
end
--=========
-- Methods
--=========

---@param caster unit
---@param target unit|item|destructable|table|nil
---@param abil_type AbilityType
---@return boolean
function static.start(caster, target, abil_type)
    -- Save current getters
    local prev_getCaster = static.getCaster
    local prev_getTarget = static.getTarget
    -- Set new getters
    static.getCaster = function() return caster end
    static.getTarget = function() return target end

    -- Cancel current casting ability
    static.cancelCurrent(caster)

    -- Check if ability started
    local success = abil_type.callbacks:runStart()
    if success then
        abil_instance = private.new(caster, target, abil_type)
    end

    -- Return old getters
    static.getCaster = prev_getCaster
    static.getTarget = prev_getTarget

    return success
end

---@param caster unit
function static.getCastingTimeLeft(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        return abil_instance.time_left
    end
    return -1
end

---@param caster unit
function static.cancelCurrent(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        local priv = private[abil_instance]
        priv.abil_type.callbacks:runCancel()
        abil_instance:free()
    end
end

---@param caster unit
function static.interruptCurrent(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        local priv = private[abil_instance]
        priv.abil_type.callbacks:runInterrupt()
        abil_instance:free()
    end
end

---@param caster unit
function static.finishCurrent(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        local priv = private[abil_instance]
        priv.abil_type.callbacks:runFinish()
        abil_instance:free()
    end
end

function public:free()
    local priv = private[self]

    private.timer:removeAction(priv.timer_action)
    priv.abil_type.flags:removeFlagsFromCaster(priv.caster)
    private.DB:remove(priv.caster)

    private[self] = nil
    freeInstanceData(self)
end

---@param caster unit
---@param target unit|item|destructable|table|nil
---@param abil_type AbilityType
---@param instance_data table | nil
function private.new(caster, target, abil_type, instance_data)
    ---@type AbilityCasting
    local instance = instance_data or newInstanceData(AbilityCasting)

    instance.time_left = abil_type:getCastingTime(caster)
    local priv = {
        caster = caster,
        target = target,
        abil_type = abil_type,
        full_time = instance.time_left,
        timer_action = private.timer:addAction(0, function() private.timerLoop(instance) end)
    }
    private[instance] = priv

    abil_type.flags:applyFlagsToCaster(caster)
    private.DB:set(caster, instance)

    return instance
end

function private.timerLoop(abil_instance)
    local priv = private[abil_instance]

    -- Save current getters
    local prev_getCaster = static.getCaster
    local prev_getTarget = static.getTarget
    -- Set new getters
    static.getCaster = function() return priv.caster end
    static.getTarget = function() return priv.target end

    abil_instance.time_left = abil_instance.time_left - private.timer_period
    if abil_instance.time_left > 0 then
        -- Casting
        local success = priv.abil_type.callbacks:runCasting()
        priv.timer_action = private.timer:addAction(0, function() private.timerLoop(abil_instance) end)
        -- Interrupt
        if not success then
            priv.abil_type.callbacks:runInterrupt()
            abil_instance:free()
        end
    else
        -- Finished
        priv.abil_type.callbacks:runFinish()
        abil_instance:free()
    end

    -- Return old getters
    static.getCaster = prev_getCaster
    static.getTarget = prev_getTarget
end

function static.getCaster()
    return nil
end

function static.getTarget()
    return nil
end

function static.getTimerPeriod()
    return private.timer_period
end

function private.onSpellEffect()
    local abil_type = AbilityType.get(GetSpellAbilityId())
    if not abil_type then
        return nil
    end

    local caster = GetSpellAbilityUnit()
    local target = private.getAnyTarget()

    static.start(caster, target, abil_type)
end

function private.onAnyOrder()
    if GetIssuedOrderId() == private.attack_order then return nil end
    local u = GetOrderedUnit()
    static.cancelCurrent(u)
end

---@return unit|item|destructable|table|nil
function private.getAnyTarget()
    local target = GetSpellTargetUnit()
    if target then return target end
    target = GetSpellTargetItem()
    if target then return target end
    target = GetSpellTargetDestructable()
    if target then return target end
    target = {x = GetSpellTargetX(), y = GetSpellTargetY()}
    return target
end

if not is_compiletime then
    private.wc3_spell_effect_trigger:addAction(function() runFuncInDebug(private.onSpellEffect) end)
    private.wc3_unit_issued_order_trigger:addAction(function() runFuncInDebug(private.onAnyOrder) end)
    private.wc3_unit_issued_point_order_trigger:addAction(function() runFuncInDebug(private.onAnyOrder) end)
    private.wc3_unit_issued_target_order_trigger:addAction(function() runFuncInDebug(private.onAnyOrder) end)
    private.wc3_unit_issued_unit_order_trigger:addAction(function() runFuncInDebug(private.onAnyOrder) end)
end

return AbilityCasting