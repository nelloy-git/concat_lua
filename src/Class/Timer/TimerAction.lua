--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ActionClass
local Action = require('Class.Action')

--=======
-- Class
--=======

local TimerAction = Class.new('TimerAction', Action)
---@class TimerAction
local public = TimerAction.public
---@class TimerActionClass
local static = TimerAction.static
---@type TimerActionClass
local override = TimerAction.override
local private = {}

--========
-- Static
--========

---@param timeout number
---@param callback Callback
---@param child_data table | nil
---@return TimerAction
function override.new(timeout, callback, child_data)
    local instance = child_data or Class.allocate(TimerAction)
    instance = Action.run(callback, instance)
    private.newData(instance, timeout)

    return instance
end

--========
-- Public
--========

---@return number
function public:getTime()
    return private[self].timeout
end

---@param cur_time number
---@return boolean
function public:tryRun(cur_time)
    local priv = private[self]
    if priv.timeout <= cur_time then
        self:run()
        return true
    end
    return false
end

function public:free()
    private.freeData(self)
    private.ActionPublic.free(self)
end

--=========
-- Private
--=========

private.ActionPublic = Class.getPublic(Action)

---@param instance TimerAction
---@param timeout number
function private.newData(instance, timeout)
    local priv = {
        timeout = timeout
    }
    private[instance] = priv
end

---@param instance TimerAction
function private.freeData(instance)
    private[instance] = nil
end

return static