--=========
-- Include
--=========

---@type DataBaseClass
local DataBase = require('class.DataBase')
---@type ActionClass
local Action = require('class.Action')

--=======
-- Class
--=======

---@type TimerClass
local Timer = newClass('Timer')

---@class TimerClass
local static = Timer.static
---@type table
local override = Timer.override
---@class Timer
local public = Timer.public
---@type table(Timer, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return Timer
function static.new(instance_data)
    local instance = instance_data or newInstanceData(Timer)
    local priv = {
        wc3_timer = CreateTimer()
    }
    private[instance] = priv

    return instance
end

---@param timeout number
---@param periodic boolean
---@param action Action
function public:start(timeout, periodic, action)
    local priv = private[self]
    TimerStart(priv.wc3_timer, timeout, periodic, function() action:run() end)
end

function public:pause()
    local priv = private[self]
    PauseTimer(priv.wc3_timer)
end

function public:resume()
    local priv = private[self]
    ResumeTimer(priv.wc3_timer)
end

return Timer