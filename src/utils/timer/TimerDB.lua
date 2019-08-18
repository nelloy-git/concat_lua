---@class TimerDB
local TimerDB = {}

---@param timer_obj userdata
---@param timer Timer
function TimerDB.add(timer_obj, timer)
    TimerDB[timer_obj] = timer
end

---@param timer_obj userdata
function TimerDB.rm(timer_obj)
    TimerDB[timer_obj] = nil
end

---@param timer_obj userdata
---@return Timer
function TimerDB.get(timer_obj)
    return TimerDB[timer_obj]
end

return TimerDB