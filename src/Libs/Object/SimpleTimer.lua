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

--=======
-- Class
--=======

local SimpleTimer = Class.new('SimpleTimer', Obj)
---@class SimpleTimer : Obj
local public = SimpleTimer.public
---@class SimpleTimerClass : ObjClass
local static = SimpleTimer.static
---@type SimpleTimerClass
local override = SimpleTimer.override
local private = {}

--=========
-- Static
--=========

---@param child_instance SimpleTimer | nil
---@return SimpleTimer
function override.new(child_instance)
    if child_instance then
        checkType(child_instance, SimpleTimer, 'child_instance')
    end

    local instance = child_instance or Class.allocate(SimpleTimer)
    instance = Obj.new(CreateTimer(), private.destroyRawTimer, instance)

    return instance
end

--========
-- Public
--========

---@param timeout number
---@param periodic boolean
---@param callback Callback
function public:start(timeout, periodic, callback)
    local action = Action.new(callback, self)
    TimerStart(self:getObj(), timeout, periodic, function() action:run() end)
end

function public:pause()
    PauseTimer(self:getObj())
end

function public:resume()
    ResumeTimer(self:getObj())
end

--=========
-- Private
--=========

function private.destroyRawTimer(obj)
    PauseTimer(obj)
    DestroyTimer(obj)
end

return static