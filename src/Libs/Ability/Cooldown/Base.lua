--=========
-- Include
--=========

--region Include
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
--endregion

--=======
-- Class
--=======

local AbilityCooldown = Class.new('AbilityCooldown')
--region Class
---@class AbilityCooldown
local public = AbilityCooldown.public
---@class AbilityCooldownClass
local static = AbilityCooldown.static
---@type AbilityCooldownClass
local override = AbilityCooldown.override
local private = {}
--endregion

--=========
-- Static
--=========

---@alias AbilityCooldownCallback fun(abil_cd:AbilityCooldown)

---@param child AbilityCooldown | nil
---@return AbilityCooldown
function override.new(child)
    if child then isTypeErr(child, AbilityCooldown, 'child') end

    local instance = child or Class.allocate(AbilityCooldown)
    private.newData(instance)

    return instance
end

---@return number
function static.getCooldownPeriod()
    return private.cooldown_period
end

--========
-- Public
--========

---@param time_left number
function public:setTimeLeft(time_left)
    private.data[self].finish_time = private.cooldown_current_time + time_left
end

---@return number
function public:getTimeLeft()
    return private.data[self].finish_time - private.cooldown_current_time
end

---@return number
function public:getFullTime()
    return private.data[self].finish_time - private.data[self].start_time
end

---@param cooldown_time number
function public:start(cooldown_time)
    local priv = private.data[self]
    priv.start_time = private.cooldown_current_time
    priv.finish_time = private.cooldown_current_time + cooldown_time

    private.cooldown_list[self] = priv
end

function public:cancel()
    local priv = private.data[self]

    priv.start_time = -1
    priv.finish_time = -1
    private.cooldown_list[self] = nil
end

function public:finish()
    local priv = private.data[self]

    priv.start_time = -1
    priv.finish_time = -1
    private.cooldown_list[self] = nil

    if priv.finish_action then priv.finish_action:run(self) end
end

--===========
-- Callbacks
--===========

---@param callback AbilityCooldownCallback | Action
function public:setFinishAction(callback)
    if type(callback) == 'function' then
        private.data[self].finish_action = Action.new(callback, self)
    elseif callback == nil or Class.type(callback, Action) then
        local action = callback
        private.data[self].finish_action = action
    else
        Log:err('variable \'callback\' is not of type AbilityCooldownCallback | Action', 2)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.cooldown_list = setmetatable({}, {__mode = 'kv'})

function private.newData(self)
    local priv = {
        start_time = -1,
        finish_time = -1,

        finish_action = nil
    }
    private.data[self] = priv
end

private.cooldown_current_time = 0
private.cooldown_period = 0.05
function private.cooldownLoop()
    local cur_time = private.cooldown_current_time + private.cooldown_period
    private.cooldown_current_time = cur_time

    for cooldown_data, priv in pairs(private.cooldown_list) do
        if priv.finish_time <= cur_time then
            cooldown_data:finish()
        end
    end
end

if not IsCompiletime() then
    private.cooldown_timer = Timer.new()
    private.cooldown_timer:start(private.cooldown_period, true, private.cooldownLoop)
end

return static