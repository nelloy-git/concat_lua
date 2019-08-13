---@class TimerAction
local TimerAction = {}
local TimerAction_meta = {__index = TimerAction}

---@param time number
---@param callback function
---@param data any
---@return TimerAction
function TimerAction.new(time, callback, data)
    local action = {
        time = time,
        callback = callback,
        data = data
    }
    setmetatable(action, TimerAction_meta)
    return action
end

function TimerAction:getTime()
    return self.time
end

function TimerAction:run()
    self.callback(self.data)
end

return TimerAction