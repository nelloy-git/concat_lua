--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityTypeClass
local AbilityType = require('Ability.Type')

---@type UnitClass
local UnitAPI = require('Unit.API')
local Unit = UnitAPI.Unit
---@type ParameterAPI
local ParamAPI = require('Parameter.API')
local Param = ParamAPI.ParamType
local Value = ParamAPI.ValueType

--=======
-- Class
--=======

---@type any
local AbilityCastInstance = Class.new('AbilityCastInstance')
---@class AbilityCastInstance
local public = AbilityCastInstance.public
---@class AbilityCastInstanceClass
local static = AbilityCastInstance.static
---@type AbilityCastInstanceClass
local override = AbilityCastInstance.override
local private = {}

--========
-- Static
--========

---@alias AbilityStatusEnum number

---@type table<string, AbilityStatusEnum>
static.Status = {}
---@type AbilityStatusEnum
static.Status.OK = 1
---@type AbilityStatusEnum
static.Status.CANCEL = 2
---@type AbilityStatusEnum
static.Status.INTERRUPT = 3
---@type AbilityStatusEnum
static.Status.FINISH = 4
---@type AbilityStatusEnum
static.Status.REMOVE = 5

---@param caster unit
---@param target AbilityTarget
---@param ability_type AbilityType
---@param lvl number
---@return boolean
function static.new(caster, target, ability_type, lvl)
    local instance = Class.allocate(AbilityCastInstance)
    private.newData(instance, caster, target, ability_type, lvl)

    local priv = private.data[instance]
    priv.status = ability_type:start(caster, target, priv.lvl)

    if priv.status == static.Status.OK then
        private.applyBlocks(priv)
        return instance
    elseif priv.status == static.Status.CANCEL then
        ability_type:cancel(caster, target, priv.lvl)
    elseif priv.status == static.Status.FINISH then
        ability_type:finish(caster, target, priv.lvl)
    elseif priv.status == static.Status.INTERRUPT then
        ability_type:interrupt(caster, target, priv.lvl)
    end
end

--========
-- Public
--========

---@param dt number
---@return boolean
function public:casting(dt)
    local priv = private.data[self]

    if priv.status ~= static.Status.OK then
        return priv.status
    end

    priv.status = priv.ability_type:cast(priv.caster, priv.target, priv.lvl)
    priv.time_left = priv.time_left - dt

    if priv.time_left <= 0 then
        priv.status = static.Status.FINISH
    end

    if priv.status == static.Status.OK then
        return priv.status
    end

    private.removeBlocks(priv)
    if priv.status == static.Status.CANCEL then
        priv.ability_type:cancel(priv.caster, priv.target, priv.lvl)
    elseif priv.status == static.Status.FINISH then
        priv.ability_type:finish(priv.caster, priv.target, priv.lvl)
    elseif priv.status == static.Status.INTERRUPT then
        priv.ability_type:interrupt(priv.caster, priv.target, priv.lvl)
    end

    return priv.status
end

function public:cancel()
    local priv = private.data[self]

    if priv.status == static.Status.OK then
        private.removeBlocks(priv)
        priv.ability_type:cancel(priv.caster, priv.target, priv.lvl)
        priv.status = static.Status.CANCEL
    end
end

function public:interrupt()
    local priv = private.data[self]

    if priv.status == static.Status.OK then
        private.removeBlocks(priv)
        priv.ability_type:interrupt(priv.caster, priv.target, priv.lvl)
        priv.status = static.Status.INTERRUPT
    end
end

function public:finish()
    local priv = private.data[self]

    if priv.status == static.Status.OK then
        private.removeBlocks(priv)
        priv.ability_type:finish(priv.caster, priv.target, priv.lvl)
        priv.status = static.Status.FINISH
    end
end

---@return number
function public:getTimeLeft()
    return private.data[self].time_left
end

---@return number
function public:getFullTime()
    return private.data[self].full_time
end

---@return unit
function public:getCaster()
    return private.data[self].caster
end

---@return table
function public:getTarget()
    return private.data[self].target
end

---@return AbilityType
function public:getAbilityType()
    return private.data[self].ability_type
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.multiplier = 10^5

function private.applyBlocks(priv)
    priv.caster:enableAttack(false)
    priv.caster:getParameters():add(Param.MS, Value.MULT, -private.multiplier)
end

function private.removeBlocks(priv)
    priv.caster:enableAttack(true)
    priv.caster:getParameters():add(Param.MS, Value.MULT, private.multiplier)
end

---@param self AbilityCastInstance
---@param caster unit
---@param target table
---@param ability_type Ability
---@return AbilityCastInstance
function private.newData(self, caster, target, ability_type, lvl)
    local time = ability_type:getCastingTime(caster, lvl)
    local priv = {
        status = static.Status.OK,
        caster = caster,
        target = target,
        lvl = lvl,
        ability_type = ability_type,

        full_time = time,
        time_left = time,
    }
    private.data[self] = priv
end


--=============
-- Compiletime
--=============

return static