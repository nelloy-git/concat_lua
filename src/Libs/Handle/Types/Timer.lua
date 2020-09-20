--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

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

---@param child Timer | nil
---@return Timer
function override.new(child)
    if child then
        isTypeErr(child, Timer, 'child')
    end

    local instance = child or Class.allocate(Timer)
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
    isTypeErr(timeout, 'number', 'timeout')
    isTypeErr(periodic, 'boolean', 'periodic')
    isTypeErr(callback, 'function', 'callback')

    local action = Action.new(callback, self)
    TimerStart(self:getData(), timeout, periodic, function() action:run() end)
end

function public:pause()
    PauseTimer(self:getData())
end

function public:resume()
    ResumeTimer(self:getData())
end

--=========
-- Private
--=========

function private.destroyTimerHandle(handle)
    PauseTimer(handle)
    DestroyTimer(handle)
end

return static