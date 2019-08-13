---@class Timer
local Timer = {}

local TimersDB = {}

local function period()
    local wc_timer = GetExpiredTimer()
    local timer_data = TimersDB[wc_timer]

    timer_data.cur_time = timer_data.cur_time + timer_data.precision
    local cur_time = timer_data.cur_time

    -- Clear action list
    local cur_list = timer_data.actions
    local remove_list = timer_data.to_remove
    timer_data.actions = {}
    timer_data.to_remove = {}

    for i = 1, #cur_list do
        local action = cur_list[i]

        local removed = false
        for j = 1, #remove_list do
            if action == remove_list[j] then
                removed = true
                break
            end
        end

        if cur_time >= action.time and not removed then
            action.callback(action.user_data)
        end
    end
end

function Timer.new(precision)
    local wc_timer = CreateTimer()
    local timer_data = {
        cur_time = 0,
        precision = precision or 0.25,
        actions = {},
        to_remove = {}
    }
    setmetatable(timer_data, {__index = Timer})
    TimersDB[wc_timer] = timer_data
    TimerStart(wc_timer, precision, true, period)
    return timer_data
end

function Timer:addAction(delay, callback, user_data)
    local action = {
        time = self.cur_time + delay,
        callback = callback,
        user_data = user_data,
        period = period
    }
    table.insert(self.actions, 1, action)
    return action
end

function Timer:removeAction(action)
    table.insert(self.to_remove, 1, action)
end

return Timer