--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type TimerClass
local Timer = require('Class.Timer.Timer')
---@type TimerActionClass
local TimerAction = require('Class.Timer.TimerAction')

--=======
-- Class
--=======

local BetterTimer = Class.new('BetterTimer', Timer)
---@class BetterTimer : Timer
local public = BetterTimer.public
---@class BetterTimerClass : TimerClass
local static = BetterTimer.static
---@type BetterTimerClass
local override = BetterTimer.override
local private = {}

local TimerPublic = Class.getPublic(Timer)

--========
-- Static
--========

---@param period number
---@param child_instance BetterTimer | nil
---@return BetterTimer
function override.new(period, child_instance)
    local instance = child_instance or Class.allocate(BetterTimer)
    instance = Timer.new(instance)
    private.newData(instance, period)

    TimerPublic.start(instance, period, true, function() private.runActions(instance) end)

    return instance
end

---@return BetterTimer
function static.getGlobalTimer()
    return private.glTimer
end

--========
-- Public
--========

--- Removed function
function public:start()
    Log(Log.Warn, BetterTimer, 'function \"start\" is deprecated.' )
end

---@return number
function public:getTime()
    return private[self].cur_time
end

---@return number
function public:getPeriod()
    return private[self].period
end

---@param delay number
---@param callback Callback
---@return TimerAction
function public:addAction(delay, callback)
    local priv = private[self]
    if delay <= 0 then
        delay = 0.01
    end
    local timeout = priv.cur_time + delay
    local action = TimerAction.new(timeout, callback, owner)
    local pos = private.findPos(priv.actions, timeout, 1, #priv.actions)
    table.insert(priv.actions, pos, action)

    return action
end

---@param action TimerAction
---@return boolean
function public:removeAction(action)
    local priv = private[self]
    for i = 1, #priv.actions do
        if priv.actions[i] == action then
            table.remove(priv.actions, i)
            action:free()
            return true
        end
    end
    return false
end

function public:free()
    private.freeData(self)
    TimerPublic.free(self)
end

--=========
-- Private
--=========

---@param instance BetterTimer
function private.newData(instance, period)
    if period < private.minimum_period then
        period = private.minimum_period
    end
    local priv = {
        cur_time = 0,
        period = period,
        actions = {}
    }
    private[instance] = priv
end

---@param instance BetterTimer
function private.freeData(instance)
    local priv = private[instance]
    for i = 1, #priv.actions do
        priv.actions[i]:free()
    end
    private[instance] = nil
end

---@param self BetterTimer
function private.runActions(self)
    local priv = private[self]
    priv.cur_time = priv.cur_time + priv.period
    local cur_time = priv.cur_time

    while #priv.actions > 0 do
        local action = table.remove(priv.actions, 1)

        local success = action:tryRun(cur_time)
        if success then
            action:free()
        else
            table.insert(priv.actions, 1, action)
            break
        end
    end
end

---@param actions TimerAction[]
---@param time number
---@param first integer
---@param len integer
---@return number
function private.findPos(actions, time, first, len)
    if len == 0 then return first end

    local half_len, d = math.modf(len / 2)
    local pos = first + half_len
    if actions[pos]:getTime() > time then
        return private.findPos(actions, time, first, half_len)
    else
        return private.findPos(actions, time, first + half_len + 2 * d, half_len)
    end
end

private.minimum_period = 0.03125
if not IsCompiletime() then
    private.glTimer = BetterTimer.static.new(private.minimum_period)
end

return static