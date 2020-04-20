--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type ActionClass
local Action = require('Utils.Action')
---@type TimerObjClass
local TimerObj = require('Object.Timer')

--=======
-- Class
--=======

local Timer = Class.new('Timer', TimerObj)
---@class Timer
local public = Timer.public
---@class TimerClass
local static = Timer.static
---@type TimerClass
local override = Timer.override
local private = {}

--========
-- Static
--========

---@param child_instance Timer | nil
---@return Timer
function override.new(child_instance)
    local instance = child_instance or Class.allocate(Timer)
    instance = TimerObj.new(instance)

    return instance
end

--========
-- Public
--========

---@param timeout number
---@param periodic boolean
---@param callback Callback
function public:start(timeout, periodic, callback)
    local action = Action.new(callback, self)
    TimerStart(self:getObj(), timeout, periodic, function() action:run() end)
end

function public:pause()
    PauseTimer(self:getObj())
end

function public:resume()
    ResumeTimer(self:getObj())
end

--=========
-- Private
--=========

return static