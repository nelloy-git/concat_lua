---@type Ability
local Ability = require('ability.ability')
---@type Timer
local Timer = require('utils.timer')
---@type Trigger
local Trigger = require('trigger.trigger')

--local Init = require('utils.init')

---@class AbilityEvent
local AbilityEvent = {}
-- Automate init function.
--Init.add(AbilityEvent)

---@type table<Unit, table>
local CasterDB = {}

local timer_precision = 0.05
local CastingTimer = nil

function AbilityEvent.init()
    print('Abilities events initialized')
    -- Init casting timer
    CastingTimer = Timer.new(timer_precision)

    -- Init casting start
    ---@type Trigger
    local casting_trigger = Trigger.new()
    casting_trigger:addEvent_AnyUnitSpellChannel()
    casting_trigger:addAction(AbilityEvent.startCast)

    -- Init break casting with orders
    local trigger = Trigger.new()
    trigger:addEvent_AnyUnitIssuedOrder()
    trigger:addEvent_AnyUnitIssuedOrderTarget()
    trigger:addEvent_AnyUnitIssuedOrderPointTarget()
    trigger:addEvent_AnyUnitIssuedOrderUnitTarget()
    trigger:addAction(function()
            CasterDB[GetOrderedUnit()] = nil
        end)
    print('Abilities events initialized')
end

---Calls this function when eny unit starts casting ability.
function AbilityEvent.startCast()
    ---@type Ability
    local ability = Ability.getAbility(GetSpellAbilityId())
    if ability == nil then return nil end
    ---@type Unit
    local caster = GetSpellAbilityUnit()
    ---@type Unit|userdata|nil
    local target = GetSpellTargetUnit() or GetSpellTargetItem() or GetSpellTargetDestructable()
    ---@type number
    local x = GetSpellTargetX()
    ---@type number
    local y = GetSpellTargetY()

    local continue = ability.start(caster, target, x, y)
    if not continue then return nil end

    -- Data for current cast.
    local data = {
        ability = ability,
        caster = caster,
        target = target,
        x = x,
        y = y,
        time = 0,
        full_time = ability.getCastTime(caster)
    }

    -- Saves data to unit.
    CasterDB[caster] = {ability = ability, time = 0, full_time = data.full_time}
    -- Start timer
    CastingTimer:addAction(timer_precision, AbilityEvent.timerCallback, data)
end

--- CastTimer calls this function every loop for every casting ability.
function AbilityEvent.timerCallback(data)
    -- Is interupted (unit cast is not found)
    local caster_data = CasterDB[data.caster]
    if caster_data == nil then
        data.ability.interrupt(data.caster, data.target, data.x, data.y, data.time, data.full_time)
        CasterDB[data.caster] = nil
        return nil
    end

    -- Is interupted (changed ability or casting time)
    local cur_ability = caster_data.ability
    local cur_time = caster_data.time
    if cur_ability ~= data.ability or cur_time ~= data.time then
        data.ability.interrupt(data.caster, data.target, data.x, data.y, data.time, data.full_time)
        CasterDB[data.caster] = nil
        return nil
    end

    -- Is finished (timeout)
    data.time = data.time + timer_precision
    if data.time >= data.full_time then
        data.ability.finish(data.caster, data.target, data.x, data.y, data.full_time)
        CasterDB[data.caster] = nil
        return nil
    end
    CasterDB[data.caster].time = data.time

    -- Should unit continue casting or its broken.
    local continue = data.ability.casting(data.caster, data.target, data.x, data.y, data.time, data.full_time)
    if continue then
        CastingTimer:addAction(timer_precision, AbilityEvent.timerCallback, data)
    else
        data.ability.interrupt(data.caster, data.target, data.x, data.y, data.time, data.full_time)
        CasterDB[data.caster] = nil
    end
end

---@param caster Unit
---@return Ability, number, number
function AbilityEvent.getUnitCastingData(caster)
    local data = CasterDB[caster]
    if data == nil then return nil, -1, -1 end
    return data.ability, data.time, data.full_time
end

return AbilityEvent