--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Timer = HandleLib.Timer or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')

---@type AbilityExtSettings
local Settings = require(lib_path..'Settings')

--=======
-- Class
--=======

local AbilityExtTimer = Class.new('AbilityExtTimer')
---@class AbilityExtTimer
local public = AbilityExtTimer.public
---@class AbilityExtTimerClass
local static = AbilityExtTimer.static
---@type AbilityExtTimerClass
local override = AbilityExtTimer.override
local private = {}

--=========
-- Static
--=========

---@alias AbilityExtTimerCallback fun(timer:AbilityExtTimer)

---@return AbilityExtTimer
function override.new()
    local instance = Class.allocate(AbilityExtTimer)
    private.newData(instance)

    return instance
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
end

---@param flag boolean
function public:pause(flag)
    private.data[self].pause = flag
end

function public:stop()
    local priv = private.data[self]

    priv.start_time = -1
    priv.finish_time = -1
    private.active_list[self] = nil
end

function public:finish()
    local priv = private.data[self]

    priv.start_time = -1
    priv.finish_time = -1
    private.active_list[self] = nil

    priv.action_finish:run()
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

---@param callback AbilityExtTimerCallback
function public:setLoopAction(callback)
    local priv = private.data[self]
    priv.action_loop = callback and Action.new(callback) or nil
end

---@param callback AbilityExtTimerCallback
function public:setFinishAction(callback)
    local priv = private.data[self]
    priv.action_finish = callback and Action.new(callback) or nil
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.active_list = setmetatable({}, {__mode = 'k'})

---@param self AbilityExtTimer
function private.newData(self)
    local priv = {
        start_time = -1,
        finish_time = -1,

        action_loop = nil,
        action_finish = nil,
    }
    private.data[self] = priv
end

private.cur_time = 0
private.period = Settings.TimerPeriod
function private.loop()
    private.cur_time = private.cur_time + private.period

    local cur_time = private.cur_time
    for timer, priv in pairs(private.active_list) do
        if priv.pause then
            priv.finish_time = priv.finish_time + private.period
        end

        if priv.finish_time <= cur_time then
            -- Finished
            priv.start_time = -1
            priv.finish_time = -1
            if priv.action_finish then
                priv.action_finish:run(timer)
            end
            private.active_list[timer] = nil
        else
            -- Continue
            if priv.action_loop then
                priv.action_loop:run(timer)
            end
        end
    end
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.period, true, private.loop)
end

return static