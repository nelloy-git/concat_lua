--=========
-- Include
--=========

---@type Timer
local Timer = require('Class.Timer.Timer')

---@type TimerAction
local TimerAction = require('Class.Timer.TimerAction')

--=======
-- Class
--=======

---@type BetterTimerClass
local BetterTimer = newClass('BetterTimer', Timer)

---@class BetterTimerClass
local static = BetterTimer.static
---@type table
local override = BetterTimer.override
---@class BetterTimer : Timer
local public = BetterTimer.public
---@type table(BetterTimer, table)
local private = {}

local minimum_period = 0.03125

--=========
-- Methods
--=========

---@param self BetterTimer
local function runActions(self)
    local priv = private[self]
    priv.cur_time = priv.cur_time + priv.period
    local cur_time = priv.cur_time

    while #priv.actions > 0 do
        ---@type TimerAction
        local action = table.remove(priv.actions, 1)

        local success = action:tryRun(cur_time)
        if not success then
            table.insert(priv.actions, 1, action)
            break
        end
    end
end

---@param period number
---@param instance_data table | nil
---@return BetterTimer
function override.new(period, instance_data)
    local instance = instance_data or newInstanceData(BetterTimer)
    instance = Timer.new(instance)
    if period < minimum_period then
        period = minimum_period
    end
    local priv = {
        cur_time = 0,
        period = period,
        actions = {}
    }
    private[instance] = priv

    Timer.public.start(instance, period, true, function() runActions(instance) end)

    return instance
end

--- Removed function
function public:start()
    Debug(string.format("This function can not be used from %s.", getClassName(BetterTimer)))
end

---@return number
function public:getTime()
    local priv = private[self]
    return priv.cur_time
end

---@param actions TimerAction[]
---@param time number
---@param first integer
---@param len integer
---@return number
findPos = function(actions, time, first, len)
    if len == 0 then return first end

    local half_len, d = math.modf(len / 2)
    local pos = first + half_len
    if actions[pos]:getTime() > time then
        return findPos(actions, time, first, half_len)
    else
        return findPos(actions, time, first + half_len + 2 * d, half_len)
    end
end

---@param delay number
---@param callback callback
---@return TimerAction
function public:addAction(delay, callback)
    local priv = private[self]
    if delay <= 0 then
        delay = 0.01
    end
    local timeout = priv.cur_time + delay
    local action = TimerAction.new(timeout, callback)
    local pos = findPos(priv.actions, timeout, 1, #priv.actions)
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
            return true
        end
    end
    return false
end

return BetterTimer