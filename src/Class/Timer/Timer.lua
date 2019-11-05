--=========
-- Include
--=========

---@type DataBase
local DataBase = require('class.DataBase')

--=======
-- Class
--=======

---@class Timer
local Timer = Class('Timer')
---@type fun():Timer
Timer.new = Timer.new

--========
-- Static
--========

---@type DataBase
local db = DataBase:new('userdata', 'instance of '..tostring(Timer))

--=========
-- Methods
--=========

--- Hiden constructor. Do not use this function manually.
function Timer:initialize()
    self._obj = CreateTimer()
    db:set(self._obj, self)
end

---@return timer
function Timer:getObj()
    return self._obj
end

---@param timeout number
---@param periodic boolean
---@param func function
function Timer:start(timeout, periodic, func)
    TimerStart(self:getObj(), timeout, periodic, func)
end

function Timer:pause()
    PauseTimer(self:getObj())
end

function Timer:resume()
    ResumeTimer(self:getObj())
end

return Timer