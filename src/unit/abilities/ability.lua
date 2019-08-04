---@type Timer
local Timer = require('utils.timer')
---@type Trigger
local Trigger = require('trigger.trigger')

---@class Ability
local Ability = {}
local Ability_meta = {__index = Ability}

local initialized = false

local AbilityDB = {}
local CasterDB = {}

local timer_precision = 0.05
local CastingTimer = nil

---@alias AbilityStartCallback fun(caster:Unit, target_x:number, target_y:number, target:Unit|userdata|nil):boolean
---@alias AbilityCastingCallback fun(caster:Unit, time_from_start:number, full_casting_time:number, target_x:number, target_y:number, target:Unit|userdata|nil):boolean
---@alias AbilityInterruptCallback fun(caster:Unit, time_from_start:number, full_casting_time:number, target_x:number, target_y:number, target:Unit|userdata|nil)
---@alias AbilityFinishCallback fun(caster:Unit, full_casting_time:number, target_x:number, target_y:number, target:Unit|userdata|nil)

function Ability.init()
    -- Init casting timer
    CastingTimer = Timer.new(timer_precision)

    -- Init casting start
    ---@type Trigger
    local casting_trigger = Trigger.new()
    casting_trigger:addEvent_AnyUnitSpellChannel()
    casting_trigger:addAction(Ability.startCast)

    -- Init break casting with orders
    local trigger = Trigger.new()
    trigger:addEvent_AnyUnitIssuedOrder()
    trigger:addEvent_AnyUnitIssuedOrderTarget()
    trigger:addEvent_AnyUnitIssuedOrderPointTarget()
    trigger:addEvent_AnyUnitIssuedOrderUnitTarget()
    trigger:addAction(function()
            local unit = GetOrderedUnit()
            CasterDB[unit] = nil
        end)
    print('Abilities initialized')
    initialized = true
end

function Ability.startCast()
    ---@type Ability
    local ability = AbilityDB[GetSpellAbilityId()]
    if ability == nil then return nil end

    ---@type Unit
    local caster = GetSpellAbilityUnit()
    ---@type number
    local x = GetSpellTargetX()
    ---@type number
    local y = GetSpellTargetY()
    ---@type Unit|userdata|nil
    local target = GetSpellTargetUnit() or GetSpellTargetItem() or GetSpellTargetDestructable()

    local continue = true
    if ability.start_callback ~= nil then
        continue = ability.start_callback(caster, x, y, target)
    end
    if not continue then return nil end

    local data = {
        ability = ability,
        caster = caster,
        x = x,
        y = y,
        target = target,
        time = 0,
        cast_time = ability.getCastTime(caster)
    }

    CasterDB[caster] = {ability = ability, time = 0, cast_time = data.cast_time}
    CastingTimer:addAction(timer_precision, Ability.timerCallback, data)
end

function Ability.timerCallback(data)
    local caster_data = CasterDB[data.caster]
    -- Is interupted
    if caster_data == nil then
        if data.ability.interrupt_callback ~= nil then
            data.ability.interrupt_callback(data.caster, data.time, data.cast_time, data.x, data.y, data.target)
        end
        return nil
    end

    local cur_ability = CasterDB[data.caster].ability
    local cur_time = CasterDB[data.caster].time
    -- Is interupted
    if cur_ability ~= data.ability or cur_time ~= data.time then
        if data.ability.interrupt_callback ~= nil then
            data.ability.interrupt_callback(data.caster, data.time, data.cast_time, data.x, data.y, data.target)
        end
        CasterDB[data.caster] = nil
        return nil
    end

    data.time = data.time + timer_precision
    -- Is finished
    if data.time >= data.cast_time then
        if data.ability.finish_callback ~= nil then
            data.ability.finish_callback(data.caster, data.cast_time, data.x, data.y, data.target)
        end
        CasterDB[data.caster] = nil
        return nil
    end

    local continue = true
    if data.ability.casting_callback ~= nil then
        continue = data.ability.casting_callback(data.caster, data.time, data.cast_time, data.x, data.y, data.target)
    end
    if continue then
        CastingTimer:addAction(timer_precision, Ability.timerCallback, data)
    end
    CasterDB[data.caster].time = data.time
end

---@param caster Unit
---@return Ability, number
function Ability.getUnitCastingAbility(caster)
    local data = CasterDB[caster]
    if data == nil then return nil, -1, -1 end
    return data.ability, data.time, data.cast_time
end

---Create new Ability instance.
---Functions need be redefined:
---getName(),
---getCastTime()
---@param id string:integer
---@param start_callback AbilityStartCallback
---@param casting_callback AbilityCastingCallback
---@param interrupt_callback AbilityInterruptCallback
---@param finish_callback AbilityFinishCallback
---@return Ability
function Ability.new(id, start_callback, casting_callback, interrupt_callback, finish_callback)
    --if not initialized then Ability.init() end
    local ability = {
        id = ID(id),
        start_callback = start_callback,
        casting_callback = casting_callback,
        interrupt_callback = interrupt_callback,
        finish_callback = finish_callback
    }
    print(ability.id)
    setmetatable(ability, Ability_meta)
    AbilityDB[ID(id)] = ability
    return ability
end

function Ability:getId()
    return self.id
end

function Ability:getName()
    print('Ability:getName() have to be redefined in child class')
    print(getErrorPos())
end

function Ability:getCastTime()
    print('Ability:getCastTime() have to be redefined in child class')
    print(getErrorPos())
end

return Ability