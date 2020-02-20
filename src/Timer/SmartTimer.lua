--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type TimerObjClass
local TimerObj = require('Timer.Timer')
---@type SmartTimerActionClass
local SmartTimerAction = require('Timer.SmartTimerAction')

--=======
-- Class
--=======

local SmartTimer = Class.new('SmartTimer', TimerObj)
---@class SmartTimer : Timer
local public = SmartTimer.public
---@class SmartTimerClass : TimerClass
local static = SmartTimer.static
---@type SmartTimerClass
local override = SmartTimer.override
local private = {}

--========
-- Static
--========

---@param precision number
---@param child_instance SmartTimer | nil
---@return SmartTimer
function override.new(precision, child_instance)
    if precision < private.minimum_period then
        Log(Log.Wrn, SmartTimer, string.format('too high precision. Changed %.4f -> %.4f', precision, private.minimum_period))
        precision = private.minimum_period
    end

    local instance = child_instance or Class.allocate(SmartTimer)
    instance = TimerObj.new(instance)
    private.newData(instance, precision)

    return instance
end

---@return SmartTimer
function static.getGlobalTimer()
    return private.glTimer
end

--========
-- Public
--========

---@return number
function public:getCurrentTime()
    return private.data[self].cur_time
end

---@return number
function public:getPeriod()
    return private.data[self].precision
end

---@param delay number
---@param callback Callback
---@return SmartTimerAction
function public:addAction(delay, callback)
    local priv = private.data[self]
    delay = math.max(delay, priv.precision)

    local timeout = priv.cur_time + delay
    local action = SmartTimerAction.new(timeout, callback, self)
    local pos = private.findPos(priv.actions, timeout, 1, #priv.actions)
    table.insert(priv.actions, pos, action)

    return action
end

---@param action SmartTimerAction
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for i = 1, #priv.actions do
        if priv.actions[i] == action then
            table.remove(priv.actions, i)
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.minimum_period = 0.03125 -- 1/32 sec

---@param self SmartTimer
---@param precision number
function private.newData(self, precision)
    local priv = {
        cur_time = 0,
        precision = precision,

        actions = {}
    }
    private.data[self] = priv

    TimerStart(self:getObj(), precision, true, function() private.runActions(priv) end)
end

function private.runActions(priv)
    priv.cur_time = priv.cur_time + priv.precision

    local cur_time = priv.cur_time
    while #priv.actions > 0 do
        local action = table.remove(priv.actions, 1)

        local success = action:tryRun(cur_time)
        if not success then
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

if not IsCompiletime() then
    private.glTimer = SmartTimer.static.new(private.minimum_period)
end

return static