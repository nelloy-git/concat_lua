--=========
-- Include
--=========

---@type ActionClass
local Action = require('Class.Action')

--=======
-- Class
--=======

---@type TimerActionClass
local TimerAction = newClass('TimerAction', Action)

---@class TimerActionClass
local static = TimerAction.static
---@type table
local override = TimerAction.override
---@class TimerAction
local public = TimerAction.public
---@type table(TimerAction, table)
local private = {}

--=========
-- Methods
--=========

---@param timeout number
---@param callback fun(userdata:any):nil
---@param instance_data table | nil
---@return TimerAction
function override.new(timeout, callback, instance_data)
    local instance = instance_data or newInstanceData(TimerAction)
    instance = Action.new(callback, instance)
    local priv = {
        timeout = timeout
    }
    private[instance] = priv

    return instance
end

---@return number
function public:getTime()
    local priv = private[self]
    return priv.timeout
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

--[[
local test = TimerAction.new(1, function() print('Azaza') end)
print(test:tryRun(0))
print(test:tryRun(2))
]]

return TimerAction