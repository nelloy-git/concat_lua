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

---@type AbilityCooldownCatcherClass
local AbilityCooldownCatcher = require(lib_modname..'.Cooldown.Catcher')
--endregion

--=======
-- Class
--=======

local AbilityCooldownInstance = Class.new('AbilityCooldownInstance')
--region Class
---@class AbilityCooldownInstance
local public = AbilityCooldownInstance.public
---@class AbilityCooldownInstanceClass
local static = AbilityCooldownInstance.static
---@type AbilityCooldownInstanceClass
local override = AbilityCooldownInstance.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param catcher AbilityCooldownCatcher
---@param child_instance AbilityCooldownInstance | nil
---@return AbilityCooldownInstance
function override.new(catcher, child_instance)
    checkTypeErr(catcher, AbilityCooldownCatcher, 'owner')
    if child_instance then checkTypeErr(child_instance, AbilityCooldownInstance, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityCooldownInstance)
    private.newData(instance, catcher)

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

---@param cooldown_time number
function public:start(cooldown_time)
    local priv = private.data[self]
    priv.start_time = private.cooldown_current_time
    priv.finish_time = private.cooldown_current_time + cooldown_time

    priv.catcher:onCooldownStart()
    private.cooldown_list[self] = private.data[self]
end

function public:finish()
    local priv = private.data[self]
    priv.start_time = -1
    priv.finish_time = -1

    self:getCatcher():onCastingFinish(self)
    private.cooldown_list[self] = nil
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.cooldown_list = setmetatable({}, {__mode = 'kv'})

---@param catcher AbilityCooldownCatcher
---@param target AbilityTarget
function private.newData(self, catcher, target)
    local priv = {
        catcher = catcher,
        target = target,

        start_time = -1,
        finish_time = -1,
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
        else
            cooldown_data:casting()
        end
    end
end

if not IsCompiletime() then
    private.cooldown_timer = Timer.new()
    private.cooldown_timer:start(private.cooldown_period, true, private.cooldownLoop)
end

return static