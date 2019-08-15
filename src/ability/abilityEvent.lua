---@type Ability
local Ability = require('ability.ability')
---@type Trigger
local Trigger = require('trigger.trigger')
---@type SpellInstance
local SpellInstance = require('ability.spellInstance')

---@class AbilityEvent
local AbilityEvent = {}

---Contains currently casting units.
---@type table<Unit, UnitCastingData>
local CasterDB = {}

local timer_precision = 0.05
AbilityEvent.CastingTimer = nil

function AbilityEvent.init()
    -- Init casting start
    ---@type Trigger
    local casting_trigger = Trigger.new()
    casting_trigger:addEvent_AnyUnitSpellChannel()
    casting_trigger:addAction(AbilityEvent.startCast)

    -- Init break casting with orders
    ---@type Trigger
    local trigger = Trigger.new()
    trigger:addEvent_AnyUnitIssuedOrder()
    trigger:addEvent_AnyUnitIssuedOrderTarget()
    trigger:addEvent_AnyUnitIssuedOrderPointTarget()
    trigger:addEvent_AnyUnitIssuedOrderUnitTarget()
    trigger:addAction(function() CasterDB[GetOrderedUnit()] = nil end)
    Debug('Abilities events initialized')
end

---@alias SpellTarget Unit|Item|userdata|nil

---@return SpellTarget
function AbilityEvent.getSpellTarget()
    local target = GetSpellTargetUnit()
    if target == nil then target = GetSpellTargetItem() end
    if target == nil then target = GetSpellTargetDestructable() end
    return target
end

---Calls this function when eny unit starts casting ability.
---@return nil
function AbilityEvent.startCast()
    ---@type Ability
    local ability = Ability.getAbility(GetSpellAbilityId())
    if ability == nil then return nil end

    local target = AbilityEvent.getSpellTarget()
    local caster = GetSpellAbilityUnit()
    local x = GetSpellTargetX()
    local y = GetSpellTargetY()

    local continue = ability:runCallback('start', caster, target, x, y)
    if not continue then caster:orderStop() return nil end

    local data = SpellInstance.new()
    -- Start timer
    glTimer.addAction(0, AbilityEvent.timerPeriod, casting_data)
    CasterDB[caster] = unit_data
end

---CastTimer calls this function every loop for every casting ability.
---@param data AbilityCastingData
function AbilityEvent.timerPeriod(data)
    local ability = data.ability
    -- Is interupted (unit cast is not found)
    local caster_data = CasterDB[data.caster]
    if caster_data == nil then
        Debug('data == nil')
        ability:runCallback('interrupt', data.caster, data.target, data.x, data.y, data.time, data.full_time)
        CasterDB[data.caster] = nil
        return nil
    end

    -- Is interupted (changed ability or casting time)
    local cur_ability = caster_data.ability
    local cur_time = caster_data.time
    if cur_ability ~= data.ability or cur_time ~= data.time then
        Debug('\n',cur_ability, data.ability, cur_time, data.time)
        ability:runCallback('interrupt', data.caster, data.target, data.x, data.y, data.time, data.full_time)
        CasterDB[data.caster] = nil
        return nil
    end

    -- Is finished (timeout)
    data.time = data.time + timer_precision
    CasterDB[data.caster].time = data.time
    if data.time >= data.full_time then
        ability:runCallback('finish', data.caster, data.target, data.x, data.y, data.full_time)
        CasterDB[data.caster] = nil
        return nil
    end

    -- Should unit continue casting or its broken.
    local continue = ability:runCallback('casting', data.caster, data.target, data.x, data.y, data.time, data.full_time)
    if continue then
        glTimer.addAction(0, AbilityEvent.timerPeriod, data)
    else
        ability:runCallback('interrupt', data.caster, data.target, data.x, data.y, data.time, data.full_time)
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