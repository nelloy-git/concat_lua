--=========
-- Include
--=========

local Class = require('Utils.Class.Class')
local Log = require('Utils.Log')

---@type AbilityCastInstanceClass
local AbilityCastInstance = require('Ability.CastInstance')
---@type AbilityTargetClass
local AbilityTarget = require('Ability.Target')
---@type AbilityTypeClass
local AbilityType = require('Ability.Type')
---@type SmartTimerClass
local SmartTimer = require('Timer.SmartTimer')
---@type TriggerClass
local Trigger = require('Utils.Trigger')

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

--========
-- Static
--========

---@param caster unit
---@return AbilityCastInstance[]
function static.getCasterInstances(caster)
    if not private.active_casters[caster] then
        private.active_casters[caster] = {}
    end
    return private.active_casters[caster]
end

--=========
-- Private
--=========

private.active_casts = {}

private.spell_order = AbilityType.getOrder()

function private.onSpellEffect()
end

function private.onImmediateOrder()
    local target = AbilityTarget.new()
end

function private.onPointOrder()
end

function private.onUnitOrder()
end

function private.onTargetOrder()
end

---@return table
function private.getAnyTarget()
    local target = {}
    target.unit = GetSpellTargetUnit()
    target.item = GetSpellTargetItem()
    target.destructable = GetSpellTargetDestructable()
    target.x = GetSpellTargetX()
    target.y = GetSpellTargetY()
    return target
end

local period = private.timer_period
function private.timerLoop()
    for caster, list in pairs(private.active_casters) do
        local new_list = {}
        for i = 1, #list do
            if list[i]:casting(period) then
                table.insert(new_list, list[i])
            end
        end

        if #new_list == 0 then
            new_list = nil
        end

        private.active_casters[caster] = new_list
    end

    private.action = private.timer:addAction(period, function() private.timerLoop() end)
end

if not IsCompiletime() then
    private.spell_effect_trigger = Trigger.new()
    private.immediatly_order_trigger = Trigger.new()
    private.point_order_trigger = Trigger.new()
    private.target_order_trigger = Trigger.new()
    private.unit_order_trigger = Trigger.new()

    private.timer = SmartTimer.getGlobalTimer()
    private.timer_period = private.timer:getPeriod()
    private.action = private.timer:addAction(0, function() private.timerLoop() end)

    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local pl = Player(i)
        private.spell_effect_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, pl)
        private.immediatly_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_ORDER, pl)
        private.point_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, pl)
        private.target_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, pl)
        private.unit_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER, pl)
    end

    private.spell_effect_trigger:addAction(private.onSpellEffect)
    private.immediatly_order_trigger:addAction(private.onImmediateOrder)
    private.point_order_trigger:addAction(private.onPointOrder)
    private.target_order_trigger:addAction(private.onTargetOrder)
    private.unit_order_trigger:addAction(private.onUnitOrder)
end

return static