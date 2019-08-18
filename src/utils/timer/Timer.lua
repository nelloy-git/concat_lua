---@type TimerAction
local TimerAction = require('utils.timer.TimerAction')
---@type TimerDB
local TimerDB = require('utils.timer.TimerDB')

---@class Timer
local Timer = {
    timer = nil,
    cur_time = 0,
    precision = 0.03125,
    __actions = {}
}
local Timer_meta = {
    __index = Timer,
    __gc = Timer.destroy
}

function Timer.init()
    ---Global timer with 0.03125 period.
    glTimer = Timer.new(0.03125)
end

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
---@param last integer
---@param list TimerAction[]
---@return number
local function findPos(time, first, last, list)
    local len = last - first + 1
    if len <= 1 then return 1 end

    local i, _ = math.modf(len / 2)
    local pos = first + i
    if list[pos]:getTime() < time then
        return findPos(time, first, pos - 1, list)
    else
        return findPos(time, pos, last, list)
    end
end

---@param time number
---@return number
local function findPosSimple(time)
    local count = #Timer.actions
    if count == 0 then return 1 end
    for i = 1, count do
        if Timer.actions[i]:getTime() > time then return i end
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
    local pos = findPos(time, 1, #self.__actions, self.__actions)
    Debug(pos)
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

local count = 100
local test_result = {}
local function test(num)
    Debug(num)
    table.insert(test_result, #test_result + 1, num)
end

local function check_test()
    for i = 1, count do
        --Debug(test_result[i])
        if test_result[i] ~= i then Debug('Timer test failed') return nil end
    end
    Debug("Timer test passed.")
end

function Timer.test()
    local t = 0.05
    for i = 1, count do
        glTimer:addAction(i * t, test, i)
    end
    local timer = CreateTimer()
    TimerStart(timer, 1.2 * t * count, false, check_test)
end

return Timer