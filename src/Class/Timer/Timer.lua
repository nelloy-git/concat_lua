--=========
-- Include
--=========

local Class = require('Utils.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type ActionClass
local Action = require('Class.Action')

--=======
-- Class
--=======

local Timer = Class.newClass('Timer')
---@class Timer
local public = Timer.public
---@class TimerClass
local static = Timer.static
local override = Timer.override
local private = {}

--========
-- Static
--========

---@param child_data table | nil
---@return Timer
function static.new(child_data)
    local instance =  Class.newInstanceData(Timer, child_data)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:free()
    private.freeData(self)
    Class.freeInstanceData(self)
end

---@return Timer
function static.getExpired()
    return private.DB:get(GetExpiredTimer())
end

---@param timeout number
---@param periodic boolean
---@param action Action
function public:start(timeout, periodic, action)
    TimerStart(private[self].wc3_timer, timeout, periodic, function() action:run() end)
end

function public:pause()
    PauseTimer(private[self].wc3_timer)
end

function public:resume()
    ResumeTimer(private[self].wc3_timer)
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
    DestroyTimer(priv.wc3_timer)
    private[self] = nil
end

return Timer