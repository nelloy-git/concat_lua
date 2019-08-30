---@type TimerAction
local TimerAction = require('utils.timer.TimerAction')
---@type TimerDB
local TimerDB = require('utils.timer.TimerDB')

---@class Timer
local Timer = {}
local Timer_meta = {
    __index = Timer,
    __gc = Timer.destroy
}

---@param period number
---@return Timer
function Timer.new(period)
    ---@type Timer
    local timer = {
        __timer_obj = CreateTimer(),
        __cur_time = 0.,
        __period = period,
        __actions = {}
    }
    setmetatable(timer, Timer_meta)
    TimerDB.add(timer.__timer_obj, timer)
    TimerStart(timer.__timer_obj, timer.__period, true, Timer.timeout)

    return timer
end

function Timer:destroy()
    while #self.__actions > 0 do
        local action = table.remove(self.__actions, 1)
        action:destroy()
    end
    TimerDB.rm(self.__timer_obj)
    DestroyTimer(self.__timer_obj)
end

---@return number
function Timer:getPeriod()
    return self.__period
end

function Timer.timeout()
    local self = TimerDB.get(GetExpiredTimer())
    local cur_time = self.__cur_time + self.__period
    while #self.__actions > 0 do
        ---@type TimerAction
        local action = table.remove(self.__actions, 1)
        if action:getTime() <= cur_time then
            action:run()
        else
            table.insert(self.__actions, 1, action)
            break
        end
    end
    self.__cur_time = cur_time
end

---@param time number
---@param first integer
---@param len integer
---@return number
function Timer:findPos(time, first, len)
    if len == 0 then return first end

    local half_len, d = math.modf(len / 2)
    local pos = first + half_len
    if self.__actions[pos]:getTime() > time then
        return self:findPos(time, first, half_len)
    else
        return self:findPos(time, first + half_len + 2 * d, half_len)
    end
end

---@param time number
---@return number
function Timer:findPosSimple(time)
    local count = #self.__actions
    if count == 0 then return 1 end
    for i = 1, count do
        if self.__actions[i]:getTime() > time then return i end
    end
    return count + 1
end

---@param delay number
---@param callback function
---@param data any
---@return TimerAction
function Timer:addAction(delay, callback, data)
    if delay <= 0 then delay = 0.01 end
    local time = self.__cur_time + delay
    local action = TimerAction.new(time, callback, data)
    local pos = 1
    pos = self:findPos(time, 1, #self.__actions)
    --local pos = self:findPosSimple(time)
    table.insert(self.__actions, pos, action)
    return action
end

---@param action TimerAction
---@return boolean
function Timer:removeAction(action)
    local count = #self.__actions
    for i = 1, count do
        if self.__actions[i] == action then
            table.remove(self.__actions, i)
            return true
        end
    end
    return false
end

local count = 10
local test_result = {}
local test_timer = nil
local function test(num)
    --Debug(num)
    table.insert(test_result, #test_result + 1, num)
end

local function check_test()
    DestroyTimer(GetExpiredTimer())
    for i = 1, count do
        a, b = modf(i/2)
        if test_result[i] ~= a then Debug('Timer test failed') return nil end
    end
    test_timer:destroy()
    Debug("Timer test passed.")
end

function Timer.test()
    test_timer = Timer.new(0.03125)
    local t = 0.05
    for i = 1, count do
        test_timer:addAction(i * t, test, i)
        test_timer:addAction((count - i) * t, test, count - i)
    end
    local timer = CreateTimer()
    TimerStart(timer, 1.1 * t * count, false, check_test)
end

return Timer