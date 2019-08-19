---@class TimerAction
local TimerAction = {}
local TimerAction_meta = {__index = TimerAction}

---@param time number
---@param callback function
---@param data any
---@return TimerAction
function TimerAction.new(time, callback, data)
    ---@type TimerAction
    local action = {
        __time = time,
        __callback = callback,
        __data = data
    }
    setmetatable(action, TimerAction_meta)
    return action
end

function TimerAction:destroy()
end

---@return number
function TimerAction:getTime()
    return self.__time
end

---@Run this action.
function TimerAction:run()
    self.__callback(self.__data)
end

return TimerAction