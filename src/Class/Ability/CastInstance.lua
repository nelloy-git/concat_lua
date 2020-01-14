--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type AbilityClass
local AbilityType = require('Class.Ability')
---@type ActionClass
local Action = require('Class.Action')
---@type AbilityEventClass
local AbilityEvent = require('Class.Ability.Event')
---@type BetterTimerClass
local BetterTimer = require('Class.Timer.BetterTimer')
---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

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
        Error(AbilityCastInstance, 'unit is already casting an ability. Cancel it first.', 2)
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
        priv.ability.flags.applyFlagsToCaster(priv.caster)
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
    priv.ability.flags.removeFlagsFromCaster(priv.caster)
end

function public:interrupt()
    local priv = private[self]
    priv.ability.callbacks:runInterrupt(self)
    priv.ability.flags.removeFlagsFromCaster(priv.caster)
end

function public:finish()
    local priv = private[self]
    priv.ability.callbacks:runFinish(self)
    priv.ability.flags.removeFlagsFromCaster(priv.caster)
end

---@return number
function public:getCastingTimeLeft()
    return private[self].time_left
end

---@return number
function public:getFullCastingTime()
    return private[self].full_time
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

    self.time_left = self.time_left - private.timer_period
    if self.time_left > 0 then
        -- Casting
        if not self:casting() then
            -- Interrupt
            self:interrupt()
            self:free()
        end
        -- Add action to next timer period
        priv.timer_action = private.timer:addAction(0, function() private.timerLoop(self) end)
    else
        -- Finished
        self:finish()
        self:free()
    end
end

---@param self AbilityCastInstance
---@param caster unit
---@param target unit|item|destructable|table|nil
---@param ability Ability
---@return AbilityCastInstance
function private.newData(self, caster, target, ability)
    local time_left = ability:getCastingTime(caster)
    local priv = {
        caster = caster,
        target = target,
        ability = ability,
        full_time = time_left,
        time_left = time_left,
        timer_action = private.timer:addAction(0, function() private.timerLoop(self) end)
    }
    private[self] = priv

    ability.flags:applyFlagsToCaster(caster)
    private.DB:set(caster, self)
end

function private.freeData(self)
    local priv = private[self]

    private.timer:removeAction(priv.timer_action)
    priv.ability.flags:removeFlagsFromCaster(priv.caster)
    private.DB:remove(priv.caster)

    private[self] = nil
end

return static