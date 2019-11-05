--=======
-- Class
--=======

---@class TimerAction
local TimerAction = Class('TimerAction')
---@type fun(timeout:number, callback:callback, data:any):TimerAction
TimerAction.new = TimerAction.new

--=========
-- Methods
--=========

--- Hiden constructor. Do not use this function manually.
function TimerAction:initialize(timeout, callback, data)
    self._timeout = timeout
    self._callback = callback
    self._data = data
end

---@return number
function TimerAction:getTime()
    return self._timeout
end

function TimerAction:run()
    self._callback(self._data)
end

return TimerAction