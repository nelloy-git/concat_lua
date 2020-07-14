--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkTypeErr = Functions.checkTypeErr
---@type ActionClass
local Action = require(lib_modname..'.Action')

local TimerStart = TimerStart
local PauseTimer = PauseTimer
local ResumeTimer = ResumeTimer
local DestroyTimer = DestroyTimer

--=======
-- Class
--=======

local Timer = Class.new('Timer', Handle)
---@class Timer : Handle
local public = Timer.public
---@class TimerClass : HandleClass
local static = Timer.static
---@type TimerClass
local override = Timer.override
local private = {}

--=========
-- Static
--=========

---@param child_instance Timer | nil
---@return Timer
function override.new(child_instance)
    if child_instance then
        checkTypeErr(child_instance, Timer, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Timer)
    instance = Handle.new(CreateTimer(), private.destroyTimerHandle, instance)

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
    TimerStart(self:getHandleData(), timeout, periodic, function() action:run() end)
end

function public:pause()
    PauseTimer(self:getHandleData())
end

function public:resume()
    ResumeTimer(self:getHandleData())
end

--=========
-- Private
--=========

function private.destroyTimerHandle(handle)
    PauseTimer(handle)
    DestroyTimer(handle)
end

return static