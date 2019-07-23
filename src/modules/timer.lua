local Timer = {}

-- Function initialize timer with callbacks.
function Timer.init(accuracy)
    local t = {
        timer = CreateTimer(),
        cur_time = 0,
        accuracy = accuracy or 0.1,
        actions = {}
    }
    setmetatable(Timer, {__index = Timer})
    TimerStart(Timer.timer, Timer.accuracy, true, Timer.period)
    return t
end

-- Function runs callback and returns true if action should continue iterating.
local function runAction(action)
    local continue = action.callback(action.user_data)
    if continue == true and action.period ~= 0 then
        action.time = action.time + action.period
        return true
    else
        return false
    end
end

function Timer:period()
    self.cur_time = self.cur_time + self.accuracy
    local cur_time = self.cur_time
    local new_list = {}
    for i = 1, #self.actions do
        local action = self.actions[i]
        if cur_time > action.time then
            local continue = runAction(action)
            if continue then
                table.insert(new_list, 1, action)
            end
        else
            table.insert(new_list, 1, action)
        end
    end
    self.actions = new_list
end

-- Periodic callbacks have to return false if you want remove then from timer.
function Timer:addAction(first_call_delay, callback, user_data, period)
    if period == nil then
        period = 0
    end

    local action = {
        time = self.time + first_call_delay,
        callback = callback,
        user_data = user_data,
        period = period
    }
    table.insert(self.actions, 1, action)
end

return Timer