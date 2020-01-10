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

---@class TimerActionClass
local static = TimerAction.static
local override = TimerAction.override
---@class TimerAction
local public = TimerAction.public
local private = {}

--=========
-- Methods
--=========

---@param timeout number
---@param callback fun(userdata:any):nil
---@param instance_data table | nil
---@return TimerAction
function override.new(timeout, callback, instance_data)
    local instance = instance_data or Class.allocate(TimerAction)
    instance = Action.new(callback, instance)
    local priv = {
        timeout = timeout
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    Action.public.free(self)
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

return TimerAction