--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type AbilityCastInstanceClass
local AbilityCastInstance = require('Class.Ability.CastInstance')
---@type BetterTimerClass
local BetterTimer = require('Class.Timer.BetterTimer')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

local AbilityEvent = Class.new('AbilityEvent')
---@class AbilityEvent
local public = AbilityEvent.public
---@class AbilityEventClass
local static = AbilityEvent.static
---@type AbilityEventClass
local override = AbilityEvent.override
local private = {}

--=========
-- Private
--=========

private.active_casting = {}

private.attack_order = 851983
if not IsCompiletime() then
    private.wc3_spell_effect_trigger = Trigger.new()
    private.wc3_unit_issued_any_order_trigger = Trigger.new()
    private.timer = BetterTimer.getGlobalTimer()
    private.timer_period = private.timer:getPeriod()
    private.action = private.timer:addAction(0, function() private.timerLoop() end)

    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local pl = Player(i)
        private.wc3_spell_effect_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, pl)
        private.wc3_unit_issued_any_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_ORDER, pl)
        private.wc3_unit_issued_any_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, pl)
        private.wc3_unit_issued_any_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, pl)
        private.wc3_unit_issued_any_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER, pl)
    end

    private.wc3_spell_effect_trigger:addAction(function() savetyRun(private.onSpellEffect) end)
    private.wc3_unit_issued_any_order_trigger:addAction(function() savetyRun(private.onAnyOrder) end)
end

local getAbility
local GetSpellAbilityId = GetSpellAbilityId
local GetSpellAbilityUnit = GetSpellAbilityUnit
function private.onSpellEffect()
    getAbility = getAbility or require('Class.Ability.Type').get
    local id = GetSpellAbilityId()
    local ability = getAbility(id)
    if not ability then
        Log(Log.Wrn, AbilityEvent, 'unknown ability with id '..ID2str(id))
        return
    end

    local caster = GetSpellAbilityUnit()
    local target = private.getAnyTarget()

    local cur_cast_instance = private.active_casting[caster]
    if cur_cast_instance then
        cur_cast_instance:cancel()
    end

    private.active_casting[caster] = AbilityCastInstance.new(caster, target, ability)
end

local GetIssuedOrderId = GetIssuedOrderId
local GetOrderedUnit = GetOrderedUnit
function private.onAnyOrder()
    if GetIssuedOrderId() == private.attack_order then
        return nil
    end

    local unit = GetOrderedUnit()
    local cast_instance = private.active_casting[unit]
    if cast_instance then
        cast_instance:cancel()
        private.active_casting[unit] = nil
    end
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

function private.timerLoop()
    for k,v in pairs(private.active_casting) do
        if not v:casting(private.timer_period) then
            private.active_casting[k] = nil
        end
    end

    private.action = private.timer:addAction(0, function() private.timerLoop() end)
end

return AbilityEvent