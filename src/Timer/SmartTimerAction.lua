--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type ActionClass
local Action = require('Utils.Action')

--=======
-- Class
--=======

local SmartTimerAction = Class.new('SmartTimerAction', Action)
---@class SmartTimerAction
local public = SmartTimerAction.public
---@class SmartTimerActionClass
local static = SmartTimerAction.static
---@type SmartTimerActionClass
local override = SmartTimerAction.override
local private = {}

--========
-- Static
--========

---@param timeout number
---@param callback Callback
---@param child_instance SmartTimerAction | nil
---@return SmartTimerAction
function override.new(timeout, callback, owner, child_instance)
    local instance = child_instance or Class.allocate(SmartTimerAction)
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

---@param self SmartTimerAction
---@param timeout number
function private.newData(self, timeout)
    local priv = {
        timeout = timeout
    }
    private.data[self] = priv
end

return static