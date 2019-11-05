--=========
-- Include
--=========

---@type Timer
local Timer = require('class.Timer.Timer')

---@type TimerAction
local TimerAction = require('class.Timer.TimerAction')

--=======
-- Class
--=======

---@class BetterTimer : Timer
---@field pause fun():nil
---@field resume fun():nil
---@field start nil
local BetterTimer = Class('BetterTimer', Timer)
---@type fun(period:number|nil):Timer
BetterTimer.new = BetterTimer.new

--========
-- Static
--========

local default_period = 0.03125
---@type fun(self:BetterTimer):nil
local timerLoop
---@type fun(self:BetterTimer, time:number, first:number, len:number):number
local findPos

--=========
-- Methods
--=========

--- Hiden constructor. Do not use this function manually.
function BetterTimer:initialize(period)
    Timer.initialize(self)
    self._cur_time = 0
    self._period = period or default_period
    self._actions = {}

    self:start(self._period, true, function() timerLoop(self) end)
    self.start = nil
end

---@return number
function BetterTimer:getTime()
    return self._cur_time
end

---@param delay number
---@param callback callback
---@param data any
---@return TimerAction
function BetterTimer:addAction(delay, callback, data)
    if delay <= 0 then delay = 0.01 end

    local time = self:getTime() + delay
    local action = TimerAction.new(time, callback, data)

    local pos = findPos(self, time, 1, #self._actions)
    table.insert(self._actions, pos, action)

    return action
end

---@param action TimerAction
---@return boolean
function BetterTimer:removeAction(action)
    local count = #self._actions
    for i = 1, count do
        if self._actions[i] == action then
            table.remove(self._actions, i)
            return true
        end
    end
    return false
end

---@param self BetterTimer
timerLoop = function(self)
    self._cur_time = self._cur_time + self._period
    local cur_time = self._cur_time

    while #self._actions > 0 do
        ---@type TimerAction
        local action = table.remove(self.__actions, 1)

        if action:getTime() <= cur_time then
            action:run()
        else
            table.insert(self.__actions, 1, action)
            break
        end
    end
end

---@param self BetterTimer
---@param time number
---@param first integer
---@param len integer
---@return number
findPos = function(self, time, first, len)
    if len == 0 then return first end

    local half_len, d = math.modf(len / 2)
    local pos = first + half_len
    if self.__actions[pos]:getTime() > time then
        return self:findPos(time, first, half_len)
    else
        return self:findPos(time, first + half_len + 2 * d, half_len)
    end
end

--==============
-- Self testing
--==============

local count = 10
local test_result = {}
local test_timer
local function testData(num)
    table.insert(test_result, #test_result + 1, num)
end

local function check_test()
    local success, result = pcall( function()
        DestroyTimer(GetExpiredTimer())
        for i = 1, count do
            if test_result[i] ~= i // 2 then
                error('Timer test failed')
                return nil
            end
        end
        test_timer:destroy()
        Debug("Timer test passed.")
    end)
    if not success then Debug(result) end
end

function BetterTimer.classTest()
    test_timer = BetterTimer.new(default_period)
    local t = 0.05
    for i = 1, count do
        test_timer:addAction(i * t, testData, i)
        test_timer:addAction((count - i) * t, testData, count - i)
    end
    local timer = CreateTimer()
    TimerStart(timer, 1.1 * t * count, false, check_test)
end

return BetterTimer