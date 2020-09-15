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
local Log = UtilsLib.Log or error('')

---@type AbilityTargetClass
local AbilityTarget = require(lib_path..'.Target.Base')

--=======
-- Class
--=======

local AbilityCasting = Class.new('AbilityCasting')
---@class AbilityCasting
local public = AbilityCasting.public
---@class AbilityCastingClass
local static = AbilityCasting.static
---@type AbilityCastingClass
local override = AbilityCasting.override
local private = {}

--=========
-- Static
--=========

---@alias AbilityCastingCallback fun(abil_cd:AbilityCasting)

---@param child AbilityCasting | nil
---@return AbilityCasting
function override.new(child)
    if child then isTypeErr(child, AbilityCasting, 'child') end

    local instance = child or Class.allocate(AbilityCasting)
    private.newData(instance)

    return instance
end

---@return number
function static.getCastingPeriod()
    return private.casting_period
end

--========
-- Public
--========

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

---@param casting_time number
function public:start(casting_time)
    local priv = private.data[self]

    priv.start_time = private.casting_current_time
    priv.finish_time = private.casting_current_time + casting_time
    private.casting_list[self] = priv
end

function public:cancel()
    local priv = private.data[self]

    priv.start_time = -1
    priv.finish_time = -1
    private.casting_list[self] = nil
end

function public:finish()
    local priv = private.data[self]

    priv.start_time = -1
    priv.finish_time = -1
    private.casting_list[self] = nil

    if priv.finish_action then priv.finish_action:run(self) end
end

--===========
-- Callbacks
--===========

---@param callback AbilityCastingCallback | Action
function public:setCastingAction(callback)
    if type(callback) == 'function' then
        private.data[self].casting_action = Action.new(callback, self)
    elseif callback == nil or Class.type(callback, Action) then
        local action = callback
        private.data[self].casting_action = action
    else
        Log:err('variable \'callback\' is not of type AbilityCastingCallback | Action', 2)
    end
end

---@param callback AbilityCastingCallback | Action
function public:setFinishAction(callback)
    if type(callback) == 'function' then
        private.data[self].finish_action = Action.new(callback, self)
    elseif callback == nil or Class.type(callback, Action) then
        local action = callback
        private.data[self].finish_action = action
    else
        Log:err('variable \'callback\' is not of type AbilityCastingCallback | Action', 2)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.casting_list = setmetatable({}, {__mode = 'k'})

---@param self AbilityCasting
function private.newData(self)
    local priv = {
        start_time = -1,
        finish_time = -1,

        casting_action = nil,
        finish_action = nil,
    }
    private.data[self] = priv
end

private.casting_current_time = 0
private.casting_period = 0.05
function private.castingLoop()
    local cur_time = private.casting_current_time + private.casting_period
    private.casting_current_time = cur_time

    for casting_data, priv in pairs(private.casting_list) do
        if priv.finish_time <= cur_time then
            casting_data:finish()
        else
            if priv.casting_action then priv.casting_action:run(casting_data) end
        end
    end
end

if not IsCompiletime() then
    private.casting_timer = Timer.new()
    private.casting_timer:start(private.casting_period, true, private.castingLoop)
end

return static