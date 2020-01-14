--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type AbilityClass
local Ability = require('Class.Ability')
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

private.attack_order = 851983
if not IsCompiletime() then
    private.wc3_spell_effect_trigger = Trigger.new()
    private.wc3_unit_issued_any_order_trigger = Trigger.new()

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

local getAbilityId = GetSpellAbilityId
local getAbility = Ability.get
local getSpellAbilityUnit = GetSpellAbilityUnit
function private.onSpellEffect()
    local id = getAbilityId()
    local ability = getAbility(id)
    if not ability then
        Log(Log.Warn, AbilityEvent, 'unknown ability with id '..ID2str(id))
        return
    end

    local caster = getSpellAbilityUnit()
    local target = private.getAnyTarget()

    local cur_cast = AbilityCastInstance.get(caster)
    if cur_cast then
        cur_cast:cancel()
        cur_cast:free()
    end

    local cast_instance = AbilityCastInstance.new(caster, target, ability)
    local success = cast_instance:start()
    if not success then
        cast_instance:free()
    end
end

local getOrderId = GetIssuedOrderId
local getOrderedUnit = GetOrderedUnit
function private.onAnyOrder()
    if getOrderId() == private.attack_order then
        return nil
    end
    -- Cancel current casting
    local ordered_unit = getOrderedUnit()
    local cast_instance = AbilityCastInstance.get(ordered_unit)
    if cast_instance then 
        cast_instance:cancel()
        cast_instance:free()
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

return AbilityEvent