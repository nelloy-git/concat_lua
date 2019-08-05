---@type Timer
local Timer = require('utils.timer')
---@type Trigger
local Trigger = require('trigger.trigger')

---@class Ability
local Ability = {}
local Ability_meta = {__index = Ability}

local AbilityDB = {}

---Create new Ability instance.
---Functions need be redefined:
---start, casting, interrupt, finish,
---getCastTime, getName.
---@param id string:integer
---@return Ability
function Ability.new(id)
    ---@type Ability
    local ability = {id = ID(id)}
    setmetatable(ability, Ability_meta)
    AbilityDB[ID(id)] = ability
    return ability
end

function Ability:getId()
    return self.id
end

function Ability.getAbility(id)
    return AbilityDB[ID(id)]
end

---Callback for cast start.
---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
---@return boolean
function Ability.start(caster, target, x, y)
    return true
end

---Callback for every casting period.
---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
---@param cur_time number
---@param full_time number
function Ability.casting(caster, target, x, y, cur_time, full_time)
    return true
end

---Callback for every casting period.
---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
---@param cur_time number
---@param full_time number
function Ability.interrupt(caster, target, x, y, cur_time, full_time)
end

---Callback for every casting period.
---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
---@param full_time number
function Ability.finish(caster, target, x, y, full_time)
end

---Function returns ability casting duration.
---@return number
function Ability.getCastTime()
    return 0
end

---Function returns ability name.
---@return string
function Ability.getName()
    return ''
end

return Ability