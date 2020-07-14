--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Timer = UtilsLib.Handle.Timer
local Unit = UtilsLib.Handle.Unit

---@type BuffTypeClass
local BuffType = require(lib_modname..'.Type')
--endregion

--=======
-- Class
--=======

local Buff = Class.new('Buff')
--region Class
---@class Buff
local public = Buff.public
---@class BuffClass
local static = Buff.static
---@type BuffClass
local override = Buff.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param source Unit
---@param target Unit
---@param buff_type BuffType
---@param child_instance Buff | nil
---@return Buff
function override.new(source, target, buff_type, child_instance)
    checkTypeErr(source, Unit, 'source')
    checkTypeErr(target, Unit, 'target')
    checkTypeErr(buff_type, BuffType, 'buff_type')
    if child_instance then
        checkTypeErr(child_instance, Buff, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Buff)
    private.newData(instance, source, target, buff_type)

    if buff_type:checkConditions() then
        private.data[instance].end_time = private.duration_current_time + buff_type:getDuration(instance)
        return instance
    else
        return nil
    end
end

---@return number
function static.getDurationPeriod()
    return private.duration_period
end

--========
-- Public
--========

function public:cancel()
    local priv = private.data[self]

    priv.buff_type:onCancel(self)
    private.data[self] = nil
end

---@return Unit
function public:getSource()
    return private.data[self].owner
end

---@return Unit
function public:getTarget()
    return private.data[self].cur_target
end

---@return BuffType
function public:getType()
    return private.data[self].buff_type
end

---@param duration number
function public:setDuration(duration)
    private.data[self].end_time = private.duration_current_time + duration
end

---@return number
function public:getDurationLeft()
    print(private.data[self].end_time, private.duration_current_time)
    local t = private.data[self].end_time - private.duration_current_time
    if t < 0 then t = 0 end
    return t
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Buff
---@param source Unit
---@param target Unit
---@param buff_type BuffType
function private.newData(self, source, target, buff_type)
    local priv = {
        source = source,
        target = target,
        buff_type = buff_type,
    }
    private.data[self] = priv
end

private.duration_current_time = 0
private.duration_period = 0.05
function private.durationLoop()
    local cur_time = private.duration_current_time + private.duration_period
    private.duration_current_time = cur_time

    for buff, priv in pairs(private.data) do
        ---@type BuffType
        local buff_type = priv.buff_type

        if priv.end_time <= private.duration_current_time then
            buff_type:onFinish(buff)
            private.data[buff] = nil
        else
            buff_type:onTick(buff)
        end
    end
end

if not IsCompiletime() then
    private.duration_timer = Timer.new()
    private.duration_timer:start(private.duration_period, true, private.durationLoop)
end

return static