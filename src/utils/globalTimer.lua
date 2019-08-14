---@type TimerAction
local TimerAction = require('utils.timerAction')

---@class Timer
local GlobalTimer = {
    timer = nil,
    cur_time = 0,
    precision = 0.03125,
    actions = {}
}

---@return nil
function GlobalTimer.init()
    GlobalTimer.timer = CreateTimer()
    TimerStart(GlobalTimer.timer, GlobalTimer.precision, true, GlobalTimer.period)
end

---@return number
function GlobalTimer.getPrecision()
    return GlobalTimer.precision
end

---@return nil
function GlobalTimer.period()
    --debug(GlobalTimer.cur_time)
    local cur_time = GlobalTimer.cur_time + GlobalTimer.precision
    if #GlobalTimer.actions == 0 then
        return nil
    end
    ---@type TimerAction
    local action = GlobalTimer.actions[1]
    while action.time <= cur_time do
        action:run()
        table.remove(GlobalTimer.actions, 1)
        action = GlobalTimer.actions[1]
    end
    GlobalTimer.cur_time = cur_time
end

---@param time number
---@param first integer
---@param last integer
---@param list TimerAction[]
---@return nil
local function findPos(time, first, last, list)
    local len = last - first + 1
    if len <= 1 then return 1 end

    local i, _ = math.modf(len / 2)
    local pos = first + i
    if list[pos]:getTime() > time then
        return findPos(time, first, pos - 1, list)
    else
        return findPos(time, pos, last, list)
    end
end

---@param time number
---@return nil
local function findPosSimple(time)
    local count = #GlobalTimer.actions
    if count == 0 then return 1 end
    for i = 1, count do
        if GlobalTimer.actions[i]:getTime() > time then return i end
    end
    return count + 1
end

---@param delay number
---@param callback function
---@param data any
---@return TimerAction
function GlobalTimer.addAction(delay, callback, data)
    local time = GlobalTimer.cur_time + delay
    local action = TimerAction.new(time, callback, data)
    --TODO change function.
    local pos = findPosSimple(time)
    table.insert(GlobalTimer.actions, pos, action)
    return action
end

---@param action TimerAction
---@return boolean
function GlobalTimer.removeAction(action)
    local count = #GlobalTimer.actions
    for i = 1, count do
        if GlobalTimer.actions[i] == action then
            table.remove(GlobalTimer.actions, i)
            return true
        end
    end
    return false
end


return GlobalTimer