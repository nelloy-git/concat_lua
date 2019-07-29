local BuffInstance = {}
local BuffType = require('buff.buffType')

-- Initialize timer with callbacks
local Timer = require('utils.timer')
local timer_precision = 0.25
local timer = Timer.new(timer_precision)

function BuffInstance.new(target, buff_type, period, duration, user_data)
    -- Start buff and check is it applied to target.
    local is_applied = buff_type.start(target, user_data)
    if not is_applied then
        return false
    end

    -- Add callback to timer
    buff_instanse = {
        owner = target,
        buff_type = buff_type,
        period = period,
        duration = duration,
        user_data = user_data
    }
    timer.addAction(period, buff_type.periodic_cb, buff_instanse)
end

function BuffInstance.timerCallback(buff_instanse)
    buff_instanse.duration = buff_instanse.duration - timer_precision
    if buff_instanse.duration <= 0 then
        buff_instanse.buff_type.
end


return BuffInstance