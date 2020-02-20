--=========
-- Include
--=========

local Class = require('Utils.Class.Class')
local Log = require('Utils.Log')

---@type AbilityCastInstanceClass
local CastInstance = require('Ability.CastInstance')
---@type AbilityTargetClass
local AbilityTarget = require('Ability.Target')
---@type AbilityTypeClass
local AbilityType = require('Ability.Type')
---@type AbilityClass
local Ability = require('Ability.Ability')
---@type SmartTimerClass
local SmartTimer = require('Timer.SmartTimer')
---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type UnitAPI
local UnitAPI = require('Unit.API')
local Unit = UnitAPI.Unit

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
    if not private.active_cast[caster] then
        private.active_cast[caster] = {}
    end
    return private.active_cast[caster]
end

--=========
-- Private
--=========

private.active_cast = {}

private.spell_order_id = AbilityType.getOrder()

function private.onSpellEffect()
    local caster = Unit.getInstance(GetSpellAbilityUnit())
    local ability = Ability.getOrdered(caster)
    local target = ability:getEventTarget()

    local cur_cast = private.active_cast[caster]
    if cur_cast then
        cur_cast:cancel()
    end

    private.active_cast[caster] = CastInstance.new(caster, target, ability)
end


local period = 0.1
function private.timerLoop()
    for caster, cast_instance in pairs(private.active_cast) do
        local status = cast_instance:casting(period)
        if status ~= AbilityType.Status.OK then
            private.active_cast[caster] = nil
        end
    end

    private.action = private.timer:addAction(period, private.timerLoop)
end

if not IsCompiletime() then
    private.spell_effect_trigger = Trigger.new()

    private.timer = SmartTimer.getGlobalTimer()
    private.timer_period = private.timer:getPeriod()
    private.action = private.timer:addAction(0, private.timerLoop)

    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local pl = Player(i)
        private.spell_effect_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, pl)
    end

    private.spell_effect_trigger:addAction(private.onSpellEffect)
end

return static