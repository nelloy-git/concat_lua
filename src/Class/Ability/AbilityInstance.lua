--=========
-- Include
--=========

local Class = require('utils.Class.Class')

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

local AbilityInstance = Class.new('AbilityInstance')
---@class AbilityInstance
local public = AbilityInstance.public
---@class AbilityInstanceClass
local static = AbilityInstance.static
local override = AbilityInstance.override
local private = {}

public.time_left = 0

--========
-- Static
--========

---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability_type AbilityType
---@return boolean
function static.new(caster, target, ability_type)
    local instance = child_data or Class.allocate(AbilityInstance)
    private.newData(instance, caster, target, ability_type)

    return instance
end

---@return AbilityInstance
function static.get(caster)
    return private.DB:get(caster)
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
function static.getFullCastingTime(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        local priv = private[abil_instance]
        return priv.full_time
    end
    return -1
end

---@param caster unit
function static.cancelCurrent(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        local priv = private[abil_instance]
        priv.ability_type.callbacks:runCancel()
        private.freeData(abil_instance)
    end
end

---@param caster unit
function static.interruptCurrent(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        local priv = private[abil_instance]
        priv.ability_type.callbacks:runInterrupt()
        private.freeData(abil_instance)
    end
end

---@param caster unit
function static.finishCurrent(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        local priv = private[abil_instance]
        priv.ability_type.callbacks:runFinish()
        private.freeData(abil_instance)
    end
end

---@return unit | nil
function static.getCaster()
    return nil
end

--- If target is point then returns table - {x = a, y = b}
---@return unit|item|destructable|table|nil
function static.getTarget()
    return nil
end

function static.getTimerPeriod()
    return private.timer_period
end

--========
-- Public
--========

---@return boolean
function public:start()
    local priv = private[self]

    -- Save current getters
    local prev_getCaster = static.getCaster
    local prev_getTarget = static.getTarget
    -- Set new getters
    static.getCaster = function() return priv.caster end
    static.getTarget = function() return priv.target end

    -- Cancel current casting ability
    static.cancelCurrent(priv.caster)
    -- Check if ability started
    local success = priv.ability_type.callbacks:runStart()

    -- Return old getters
    static.getCaster = prev_getCaster
    static.getTarget = prev_getTarget

    return success
end

function public:cancel()
    private[self].ability_type.callbacks:runCancel()
end

function public:free()
    private.freeData(self)
    Class.freeInstanceData(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('userdata', AbilityInstance)
private.ms_const = 10^10
private.disable_attack_id = ID('Abun')
private.attack_order = 851983
if not IsCompiletime() then
    private.timer = BetterTimer.getGlobalTimer()
    private.timer_period = private.timer:getPeriod()

    private.wc3_spell_effect_trigger = Trigger.new()
    private.wc3_unit_issued_order_trigger = Trigger.new()
    private.wc3_unit_issued_point_order_trigger = Trigger.new()
    private.wc3_unit_issued_target_order_trigger = Trigger.new()
    private.wc3_unit_issued_unit_order_trigger = Trigger.new()

    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local pl = Player(i)
        private.wc3_spell_effect_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, pl)
        private.wc3_unit_issued_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_ORDER, pl)
        private.wc3_unit_issued_point_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, pl)
        private.wc3_unit_issued_target_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, pl)
        private.wc3_unit_issued_unit_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER, pl)
    end
    private.wc3_spell_effect_trigger:addAction(function() savetyRun(private.onSpellEffect) end)
    private.wc3_unit_issued_order_trigger:addAction(function() savetyRun(private.onAnyOrder) end)
    private.wc3_unit_issued_point_order_trigger:addAction(function() savetyRun(private.onAnyOrder) end)
    private.wc3_unit_issued_target_order_trigger:addAction(function() savetyRun(private.onAnyOrder) end)
    private.wc3_unit_issued_unit_order_trigger:addAction(function() savetyRun(private.onAnyOrder) end)
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
        local success = priv.ability_type.callbacks:runCasting()
        priv.timer_action = private.timer:addAction(0, function() private.timerLoop(abil_instance) end)
        -- Interrupt
        if not success then
            priv.ability_type.callbacks:runInterrupt()
            private.freeData(abil_instance)
        end
    else
        -- Finished
        priv.ability_type.callbacks:runFinish()
        private.freeData(abil_instance)
    end

    -- Return old getters
    static.getCaster = prev_getCaster
    static.getTarget = prev_getTarget
end

function private.onSpellEffect()
    local ability_type = AbilityType.get(GetSpellAbilityId())
    if not ability_type then
        return nil
    end

    local caster = GetSpellAbilityUnit()
    local target = private.getAnyTarget()

    local ability_instance = static.new(caster, target, ability_type)
    local success = ability_instance:start()
    if not success then
        ability_instance:free()
    end
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

---@param self AbilityInstance
---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability_type AbilityType
---@return AbilityInstance
function private.newData(self, caster, target, ability_type)
    self.time_left = ability_type:getCastingTime(caster)
    local priv = {
        caster = caster,
        target = target,
        ability_type = ability_type,
        full_time = self.time_left,
        timer_action = private.timer:addAction(0, function() private.timerLoop(self) end)
    }
    private[self] = priv

    ability_type.flags:applyFlagsToCaster(caster)
    private.DB:set(caster, self)
end

function private.freeData(self)
    local priv = private[self]

    private.timer:removeAction(priv.timer_action)
    priv.ability_type.flags:removeFlagsFromCaster(priv.caster)
    private.DB:remove(priv.caster)

    private[self] = nil
end

return AbilityInstance