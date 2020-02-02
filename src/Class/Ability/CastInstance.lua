--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

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

---@alias CastInstanceStatus number
---@type table<string, CastInstanceStatus>
static.STATUS = {
    OK = 1,
    CANCEL = 2,
    INTERRUPT = 3,
    FINISH = 4,
    NOTHING = 5
}

---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability AbilityType
---@return boolean
function static.new(caster, target, ability)
    local instance = Class.allocate(AbilityCastInstance)
    private.newData(instance, caster, target, ability)

    local status = ability.callbacks:runStart(instance)
    if status == static.STATUS.OK then
        ability.flags:applyFlagsToCaster(caster)
        return instance
    elseif status == static.STATUS.CANCEL then
        ability.callbacks:runCancel(instance)
    elseif status == static.STATUS.FINISH then
        ability.callbacks:runFinish(instance)
    elseif status == static.STATUS.INTERRUPT then
        ability.callbacks:runInterrupt(instance)
    end
end

--========
-- Public
--========

---@param dt number
---@return boolean
function public:casting(dt)
    local priv = private.data[self]

    if priv.status ~= static.STATUS.OK then
        return false
    end

    priv.status = priv.ability.callbacks:runCasting(self)
    if priv.status == static.STATUS.OK then
        priv.time_left = priv.time_left - dt
        if priv.time_left <= 0 then 
            priv.ability.callbacks:runFinish(self)
            priv.ability.flags:removeFlagsFromCaster(priv.caster)
            return false
        end
        return true
    end
    return false
end

function public:cancel()
    local priv = private.data[self]

    if priv.status == static.STATUS.OK then
        priv.ability.callbacks:runCancel(self)
        priv.ability.flags:removeFlagsFromCaster(priv.caster)
    end
    priv.status = static.STATUS.CANCEL
end

function public:interrupt()
    local priv = private.data[self]

    if priv.status == static.STATUS.OK then
        priv.ability.callbacks:runInterrupt(self)
        priv.ability.flags:removeFlagsFromCaster(priv.caster)
    end
    priv.status = static.STATUS.INTERRUPT
end

function public:finish()
    local priv = private.data[self]

    if priv.status == static.STATUS.OK then
        priv.ability.callbacks:runFinish(self)
        priv.ability.flags:removeFlagsFromCaster(priv.caster)
    end
    priv.status = static.STATUS.FINISH
end

---@return number
function public:getCastingTimeLeft()
    return private.data[self].time_left
end

---@return number
function public:getFullCastingTime()
    return private.data[self].full_time
end

---@return unit
function public:getCaster()
    return private.data[self].caster
end

---@return any
function public:getTarget()
    return private.data[self].caster
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityCastInstance
---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability AbilityType
---@return AbilityCastInstance
function private.newData(self, caster, target, ability)
    local priv = {
        status = static.STATUS.OK,
        caster = caster,
        target = target,
        ability = ability,
        full_time = 0,
        time_left = 0,
    }
    private.data[self] = setmetatable(priv, private.metatable)

    local time_left = ability.callbacks:getCastingTime(self)
    priv.full_time = time_left
    priv.time_left = time_left
end

private.metatable = {
    __gc = function(self) end
}

return static