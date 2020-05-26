--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
local UtilsLib = depencies.UtilsLib
local Obj = UtilsLib.Obj
local Action = UtilsLib.Action
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger

--=======
-- Class
--=======

local SmartTimer = Class.new('SmartTimer', Obj)
---@class SmartTimer : Obj
local public = SmartTimer.public
---@class SmartTimerClass : ObjClass
local static = SmartTimer.static
---@type SmartTimerClass
local override = SmartTimer.override
local private = {}

--========
-- Static
--========

---@param precision number
---@param child_instance SmartTimer | nil
---@return SmartTimer
function override.new(precision, child_instance)
    checkType(precision, 'number', 'precision')
    if child_instance then
        checkType(child_instance, SmartTimer, 'child_instance')
    end

    if precision < private.minimum_period then
        Log:wrn(SmartTimer..string.format(' got too high precision. Changed %.4f -> %.4f', precision, private.minimum_period))
        precision = private.minimum_period
    end

    local instance = child_instance or Class.allocate(SmartTimer)
    instance = Obj.new(CreateTimer(), private.destroyRawTimer, instance)
    private.newData(instance, precision)

    return instance
end

--========
-- Public
--========

---@return number
function public:getCurrentTime()
    return private.data[self].cur_time
end

---@return number
function public:getPeriod()
    return private.data[self].precision
end

---@param delay number
---@param callback Callback
---@return Action
function public:addAction(delay, callback)
    local priv = private.data[self]
    delay = math.max(delay, priv.precision)

    local data = {
        time = priv.cur_time + delay,
        action = Action.new(callback, self)
    }
    local pos = private.findPos(priv.actions_list, data.time, 1, #priv.actions_list)
    table.insert(priv.actions_list, pos, data)

    return data.action
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for i = 1, #priv.actions_list do
        if priv.actions_list[i].action == action then
            table.remove(priv.actions_list, i)
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.minimum_period = 0.03125 -- 1/32 sec

---@param self SmartTimer
---@param precision number
function private.newData(self, precision)
    local priv = {
        cur_time = 0,
        precision = precision,

        actions_list = {}
    }
    private.data[self] = priv

    TimerStart(self:getObj(), precision, true, function() private.runActions(priv) end)
end

function private.runActions(priv)
    priv.cur_time = priv.cur_time + priv.precision

    local cur_time = priv.cur_time
    while #priv.actions_list > 0 do
        local cur_data = priv.actions_list[1]

        if cur_data.time <= cur_time then
            cur_data.action:run()
            table.remove(priv.actions_list, 1)
        else
            break
        end
    end
end

---@param actions_list TimerAction[]
---@param time number
---@param first integer
---@param len integer
---@return number
function private.findPos(actions_list, time, first, len)
    if len == 0 then return first end

    local half_len, d = math.modf(len / 2)
    local pos = first + half_len
    if actions_list[pos].time > time then
        return private.findPos(actions_list, time, first, half_len)
    else
        return private.findPos(actions_list, time, first + half_len + 2 * d, half_len)
    end
end

return static