local Timer = {
    cur_time = 0,
    accuracy = 0.1,
    actions = {}
}

function Timer.init(accuracy)
    Timer.timer = CreateTimer()
    Timer.accuracy = accuracy
    TimerStart(Timer.timer, Timer.accuracy, true, Timer.period)
end

-- Function returns true if action should continue iterating.
local function runAction(cur_time, action)
    if action.time >= cur_time then
        local continue = action.callback(action.user_data)
        if continue == true and action.period ~= 0 then
            action.time = cur_time + action.period
            return true
        else
            return false
        end
    end
end

function Timer.period()
    Timer.cur_time = Timer.cur_time + Timer.accuracy
    for i = 1, #Timer.time do
        local continue = runAction(Timer.cur_time, Timer.actions[i])
        if not continue then
            table.remove(Timer.actions, i)
        end
    end
end

-- Periodic callbacks have to return false if you want remove it from timer.
function Timer.addAction(time, callback, user_data, period)
    if period == nil then
        period = 0
    end

    local action = {
        time = Timer.cur_time + time,
        callback = callback,
        user_data = user_data,
        period = period
    }
    table.insert(Timer.actions, 1, action)
end

return Timer