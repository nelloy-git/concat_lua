--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type BetterTimerClass
local BetterTimer = require('Class.Timer.BetterTimer')
---@type DataBaseClass
local DataBase = require('Class.DataBase')

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

---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability Ability
---@return boolean
function static.new(caster, target, ability)
    if private.DB:get(caster) then
        error(AbilityCastInstance, 'unit is already casting an ability. Cancel it first.', 2)
        return
    end

    local instance = Class.allocate(AbilityCastInstance)
    private.newData(instance, caster, target, ability)

    return instance
end

---@return AbilityCastInstance
function static.get(caster)
    return private.DB:get(caster)
end

--========
-- Public
--========

function public:start()
    local priv = private[self]
    local success = priv.ability.callbacks:runStart(self)
    if success then
        priv.ability.flags:applyFlagsToCaster(priv.caster)
    end

    return success
end

---@return boolean
function public:casting()
    return private[self].ability.callbacks:runCasting(self)
end

function public:cancel()
    local priv = private[self]
    priv.ability.callbacks:runCancel(self)
    priv.ability.flags:removeFlagsFromCaster(priv.caster)
    self:free()
end

function public:interrupt()
    local priv = private[self]
    priv.ability.callbacks:runInterrupt(self)
    priv.ability.flags:removeFlagsFromCaster(priv.caster)
    self:free()
end

function public:finish()
    local priv = private[self]
    priv.ability.callbacks:runFinish(self)
    priv.ability.flags:removeFlagsFromCaster(priv.caster)
    self:free()
end

---@return number
function public:getCastingTimeLeft()
    return private[self].time_left
end

---@return number
function public:getFullCastingTime()
    return private[self].full_time
end

---@return unit
function public:getCaster()
    return private[self].caster
end

---@return any
function public:getTarget()
    return private[self].caster
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('userdata', AbilityCastInstance)
if not IsCompiletime() then
    private.timer = BetterTimer.getGlobalTimer()
    private.timer_period = private.timer:getPeriod()
end

---@param self AbilityCastInstance
function private.timerLoop(self)
    local priv = private[self]

    priv.time_left = priv.time_left - private.timer_period
    if priv.time_left > 0 then
        -- Casting
        if not self:casting() then
            -- Interrupt
            self:interrupt()
        end
        -- Add action to next timer period
        priv.timer_action = private.timer:addAction(0, function() private.timerLoop(self) end)
    else
        -- Finished
        self:finish()
    end
end

---@param self AbilityCastInstance
---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability Ability
---@return AbilityCastInstance
function private.newData(self, caster, target, ability)
    local priv = {
        caster = caster,
        target = target,
        ability = ability,
        full_time = 0,
        time_left = 0,
        timer_action = private.timer:addAction(0, function() private.timerLoop(self) end)
    }
    private[self] = priv

    private.DB:set(caster, self)
    
    local time_left = ability.callbacks:getCastingTime(self)
    priv.full_time = time_left
    priv.time_left = time_left
end

function private.freeData(self)
    local priv = private[self]

    private.timer:removeAction(priv.timer_action)
    private.DB:remove(priv.caster)

    private[self] = nil
end

return static