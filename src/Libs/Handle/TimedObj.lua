--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type TimerClass
local Timer = require(lib_path..'Types.Timer') or error('')
---@type HandleSettings
local Settings = require(lib_path..'Settings') or error('')

--=======
-- Class
--=======

local TimedObj = Class.new('TimedObj')
---@class TimedObj
local public = TimedObj.public
---@class TimedObjClass
local static = TimedObj.static
---@type TimedObjClass
local override = TimedObj.override
local private = {}

--=========
-- Static
--=========

---@alias TimedObjCallback fun(timer:TimedObj)

---@param child TimedObj
---@return TimedObj
function override.new(child)
    if child then isTypeErr(child, TimedObj, 'child') end
    local instance = child or Class.allocate(TimedObj)
    private.newData(instance)

    return instance
end

---@return number
function override.getPeriod()
    return private.period
end

--========
-- Public
--========

---@param time number
function public:start(time)
    local priv = private.data[self]

    priv.start_time = private.cur_time
    priv.finish_time = private.cur_time + time
    private.active_list[self] = priv

    priv.actions_start:run(self)
end

---@param flag boolean
function public:pause(flag)
    private.data[self].pause = flag
end

function public:loop()
    private.data[self].actions_loop:run(self)
end

function public:cancel()
    local priv = private.data[self]

    priv.start_time = -1
    priv.finish_time = -1
    private.active_list[self] = nil

    priv.actions_cancel:run(self)
end

function public:finish()
    local priv = private.data[self]

    priv.start_time = -1
    priv.finish_time = -1
    private.active_list[self] = nil

    priv.actions_finish:run(self)
end

---@param time_left number
function public:setTimeLeft(time_left)
    private.data[self].finish_time = private.cur_time + time_left
end

---@return number
function public:getTimeLeft()
    local left = private.data[self].finish_time - private.cur_time
    return left >= 0 and left or 0
end

---@return number
function public:getFullTime()
    local priv = private.data[self]
    return priv.finish_time - priv.start_time
end

---@param callback TimedObjCallback
---@return boolean
function public:addStartAction(callback)
    return private.data[self].actions_start:add(callback)
end

---@param callback TimedObjCallback
---@return boolean
function public:addLoopAction(callback)
    return private.data[self].actions_loop:add(callback)
end

---@param callback TimedObjCallback
---@return boolean
function public:addCancelAction(callback)
    return private.data[self].actions_cancel:add(callback)
end

---@param callback TimedObjCallback
---@return boolean
function public:addFinishAction(callback)
    return private.data[self].actions_finish:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    local found = false
    found = priv.actions_start:remove(action)
    found = priv.actions_loop:remove(action)
    found = priv.actions_cancel:remove(action)
    found = priv.actions_finish:remove(action)
    return found
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.active_list = setmetatable({}, {__mode = 'k'})

---@param self TimedObj
function private.newData(self)
    local priv = {
        start_time = -1,
        finish_time = -1,

        actions_start = ActionList.new(self),
        actions_loop = ActionList.new(self),
        actions_cancel = ActionList.new(self),
        actions_finish = ActionList.new(self),
    }
    private.data[self] = priv
end

private.cur_time = 0
private.period = Settings.TimedObjPeriod or error('')
function private.loop()
    private.cur_time = private.cur_time + private.period

    local cur_time = private.cur_time

    local active = {}
    for k,v in pairs(private.active_list) do
        active[k] = v
    end

    for timer, priv in pairs(active) do
        if priv.pause then
            priv.finish_time = priv.finish_time + private.period
        end

        if priv.finish_time <= cur_time then
            timer:finish()
        else
            timer:loop()
        end
    end
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.period, true, private.loop)
end

return static