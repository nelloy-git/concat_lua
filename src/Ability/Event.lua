--=========
-- Include
--=========

local Class = require('Utils.Class.Class')
local Log = require('Utils.Log')

---@type AbilityCastInstanceClass
local CastInstance = require('Ability.CastInstance')
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

---@param unit Unit
function static.cancelCurrentCasting(unit)
    local cast = private.active_cast[unit]
    if cast then
        cast:cancel()
    end
end

---@param unit Unit
function static.interruptCurrentCasting(unit)
    local cast = private.active_cast[unit]
    if cast then
        cast:interrupt()
    end
end

---@param unit Unit
function static.finishCurrentCasting(unit)
    local cast = private.active_cast[unit]
    if cast then
        cast:finish()
    end
end

---@param unit Unit
---@return boolean
function static.hasActiveCast(unit)
    return not (private.active_cast[unit] == nil)
end

---@param unit Unit
---@return number | nil
function static.getCastingTimeLeft(unit)
    local cast = private.active_cast[unit]
    if cast then
        return cast:getTimeLeft()
    end
end

---@param unit Unit
---@return number | nil
function static.getCastingTimeFull(unit)
    local cast = private.active_cast[unit]
    if cast then
        return cast:getFullTime()
    end
end

function static.getCurrentAbilityType(unit)
    local cast = private.active_cast[unit]
    if cast then
        return cast:getType()
    end
end

--=========
-- Private
--=========

private.active_cast = {}

private.spell_order_id = AbilityType.getOrderId()

function private.onSpellEffect()
    local caster = Unit.getInstance(GetSpellAbilityUnit())
    local ability = Ability.getLastOrdered(caster)
    local ability_type = AbilityType.getInstance(GetSpellAbilityId())
    local target = ability_type:getEventTarget()

    if ability:getType() ~= ability_type then
        Log.error(AbilityEvent, 'error in casting system. Current ability != last ordered ability.', 1)
    end

    local cur_cast = private.active_cast[caster]
    if cur_cast then
        print('Can not start new ablity casting. Cancel current casting first.')
        return
    end

    private.active_cast[caster] = CastInstance.new(caster, target, ability_type, ability:getLevel())
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