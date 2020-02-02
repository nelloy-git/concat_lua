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
---@param child_instance TimerAction | nil
---@return TimerAction
function override.new(timeout, callback, owner, child_instance)
    local instance = child_instance or Class.allocate(TimerAction)
    instance = Action.new(callback, owner, instance)
    private.newData(instance, timeout)

    return instance
end

--========
-- Public
--========

---@return number
function public:getTime()
    return private.data[self].timeout
end

---@param cur_time number
---@return boolean
function public:tryRun(cur_time)
    local priv = private.data[self]
    if priv.timeout <= cur_time then
        self:run()
        return true
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self TimerAction
---@param timeout number
function private.newData(self, timeout)
    local priv = {
        timeout = timeout
    }
    private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(self) end
}

return static