--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type AbilityInstanceClass
local AbilityInstance = require('Class.Ability.AbilityInstance')
---@type AbilityTypeClass
local AbilityType = require('Class.Ability.AbilityType')
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
-- Static
--=========

---@param child_data AbilityEvent | nil
---@return AbilityEvent
function static.new(child_data)
    local instance = child_data or Class.allocate(AbilityEvent, child_data)
    local priv = private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:free()
    private.freeData(self)
    Class.freeInstanceData(self)
end

--=========
-- Private
--=========

private.attack_order = 851983
if not IsCompiletime() then
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

local getSpellAbilityUnit = GetSpellAbilityUnit
function private.onSpellEffect()
    local ability_type = AbilityType.get(GetSpellAbilityId())
    if not ability_type then
        return nil
    end

    local caster = getSpellAbilityUnit()
    local target = private.getAnyTarget()

    local ability_instance = static.new(caster, target, ability_type)
    local success = ability_instance:start()
    if not success then
        ability_instance:free()
    end
end

local getOrderedUnit = GetOrderedUnit
function private.onAnyOrder()
    if GetIssuedOrderId() == private.attack_order then
        return nil
    end
    local ordered_unit = getOrderedUnit()
    local ability_insatance = AbilityInstance.get(ordered_unit)
    --ability_insatance

    static.cancelCurrent(u)
end

---@param self AbilityEvent
---@return table
function private.new(self)
    local priv = {
    }
    private[self] = priv
    return priv
end

---@param self AbilityEvent
function private.freeData(self)
    private[self] = nil
end

return AbilityEvent