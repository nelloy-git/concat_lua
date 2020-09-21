--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Timer = HandleLib.Timer or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type BuffTypeClass
local BuffType = require(lib_path..'Type') or error('')

--=======
-- Class
--=======

local Buff = Class.new('Buff')
---@class Buff
local public = Buff.public
---@class BuffClass
local static = Buff.static
---@type BuffClass
local override = Buff.override
local private = {}

--=========
-- Static
--=========

---@param source Unit
---@param target Unit
---@param buff_type BuffType
---@param user_data any
---@param child Buff | nil
---@return Buff
function override.new(source, target, buff_type, user_data, child)
    isTypeErr(source, Unit, 'source')
    isTypeErr(target, Unit, 'target')
    isTypeErr(buff_type, BuffType, 'buff_type')
    if child then isTypeErr(child, Buff, 'child') end

    local instance = child or Class.allocate(Buff)
    private.newData(instance, source, target, buff_type, user_data)

    buff_type:onStart(instance)
    return instance
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
    return private.data[self].source
end

---@return Unit
function public:getTarget()
    return private.data[self].target
end

---@return BuffType
function public:getType()
    return private.data[self].buff_type
end

function public:getUserData()
    return private.data[self].user_data
end

---@param duration number
function public:setDuration(duration)
    private.data[self].end_time = private.duration_current_time + duration
end

---@return number
function public:getDurationLeft()
    local priv = private.data[self]
    local t = priv.end_time - private.duration_current_time
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
---@param user_data any
function private.newData(self, source, target, buff_type, user_data)
    local priv = {
        source = source,
        target = target,
        buff_type = buff_type,
        user_data = user_data,
    }
    private.data[self] = priv
    
    priv.end_time = private.duration_current_time + buff_type:getDuration(self)
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