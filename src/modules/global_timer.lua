local Timer = {
    cur_time = 0,
    accuracy = 0.1,
    time = {},
    callback = {},
    user_data = {}
}

function Timer.init(accuracy)
    Timer.timer = CreateTimer()
    Timer.accuracy = accuracy
    TimerStart(Timer.timer, Timer.accuracy, false, Timer.period)
end

function Timer.period()
    Timer.cur_time = Timer.cur_time + Timer.accuracy
    for i = 1, #Timer.time do
        if Timer.time[i] <= Timer.cur_time then
            table.remove(Timer.time, i)
            local cb = table.remove(Timer.callback, i)
            local ud = table.remove(Timer.user_data, i)
            cb(ud)
        end
    end
    TimerStart(Timer.timer, Timer.accuracy, false, Timer.period)
end

function Timer.addAction(time, callback, user_data)
    table.insert(Timer.time, 1, Timer.cur_time + time)
    table.insert(Timer.callback, 1, callback)
    table.insert(Timer.user_data, 1, user_data)
end

return Timer