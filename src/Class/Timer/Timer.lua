--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type ActionClass
local Action = require('Class.Action')

--=======
-- Class
--=======

local Timer = Class.new('Timer')
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
function static.new(child_instance)
    local instance =  Class.new(Timer, child_instance)
    private.newData(instance)

    return instance
end

---@return Timer
function static.getExpired()
    return private.DB:get(GetExpiredTimer())
end

--========
-- Public
--========

---@param timeout number
---@param periodic boolean
---@param callback Callback
function public:start(timeout, periodic, callback)
    local action = Action.new(callback)
    TimerStart(private[self].wc3_timer, timeout, periodic, function() action:run() end)
end

function public:pause()
    PauseTimer(private[self].wc3_timer)
end

function public:resume()
    ResumeTimer(private[self].wc3_timer)
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('userdata', Timer)

---@param self Timer
function private.newData(self)
    local priv = {
        wc3_timer = CreateTimer()
    }
    private[self] = priv
    private.DB:set(priv.wc3_timer, self)
end

---@param self Timer
function private.freeData(self)
    local priv = private[self]
    private.DB:remove(priv.wc3_timer)
    PauseTimer(priv.wc3_timer)
    DestroyTimer(priv.wc3_timer)
    private[self] = nil
end

return static