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
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityExtSettings
local AbilityExtSettings = require(lib_path..'Settings')

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

---@param loop_cb Callback | nil
---@param finish_cb Callback | nil
---@return AbilityExtTimer
function override.new(loop_cb, finish_cb)
    if loop_cb then isTypeErr(loop_cb, 'function', 'loop_cb') end
    if finish_cb then isTypeErr(finish_cb, 'function', 'finish_cb') end

    local instance = Class.allocate(AbilityExtTimer)
    private.newData(instance, loop_cb, finish_cb)

    return instance
end

--========
-- Public
--========

---@param time number
function public:start(time)
    local priv = private.data[self]

    priv.start_time = private.casting_current_time
    priv.finish_time = private.casting_current_time + time
    private.active_list[self] = priv
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

    priv.finish_action:run()
end

---@param time_left number
function public:setTimeLeft(time_left)
    private.data[self].finish_time = private.casting_current_time + time_left
end

---@return number
function public:getTimeLeft()
    return private.data[self].finish_time - private.casting_current_time
end

---@return number
function public:getFullTime()
    local priv = private.data[self]
    return priv.finish_time - priv.start_time
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.active_list = setmetatable({}, {__mode = 'k'})

---@param self AbilityExtTimer
---@param loop_cb Callback
---@param finish_cb Callback
function private.newData(self, loop_cb, finish_cb)
    local priv = {
        start_time = -1,
        finish_time = -1,

        loop_action = loop_cb and Action.new(loop_cb) or nil,
        finish_action = finish_cb and Action.new(finish_cb) or nil,
    }
    private.data[self] = priv
end

private.cur_time = 0
private.period = AbilityExtSettings.CastingLoopPeriod
function private.loop()
    private.cur_time = private.cur_time + private.period

    local cur_time = private.cur_time
    for timer, priv in pairs(private.active_list) do
        if priv.finish_time <= cur_time then
            -- Finished
            priv.start_time = -1
            priv.finish_time = -1
            if priv.finish_action then
                priv.finish_action:run()
            end
            private.active_list[timer] = nil
        else
            -- Continue
            if priv.loop_action then priv.loop_action:run() end
        end
    end
end

if not IsCompiletime() then
    private.casting_timer = Timer.new()
    private.casting_timer:start(private.period, true, private.loop)
end

return static