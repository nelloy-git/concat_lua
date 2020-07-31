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

---@type AbilityDataCastingCatcherClass
local AbilityDataCastingCatcher = require(lib_modname..'.Data.CastingCatcher')
---@type AbilityTargetClass
local AbilityTarget = require(lib_modname..'.Target.Target')
--endregion

--=======
-- Class
--=======

local AbilityDataCooldownInstance = Class.new('AbilityDataCooldownInstance')
--region Class
---@class AbilityDataCooldownInstance
local public = AbilityDataCooldownInstance.public
---@class AbilityDataCooldownInstanceClass
local static = AbilityDataCooldownInstance.static
---@type AbilityDataCooldownInstanceClass
local override = AbilityDataCooldownInstance.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param catcher AbilityDataCastingCatcher
---@param target AbilityTarget
---@param child_instance AbilityDataCooldownInstance | nil
---@return AbilityDataCooldownInstance
function override.new(catcher, target, child_instance)
    checkTypeErr(catcher, AbilityDataCastingCatcher, 'owner')
    checkTypeErr(target, AbilityTarget, 'target')
    if child_instance then checkTypeErr(child_instance, AbilityDataCooldownInstance, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityDataCooldownInstance)
    private.newData(instance, catcher, target)

    return instance
end

---@return number
function static.getCastingPeriod()
    return private.casting_period
end

--========
-- Public
--========

---@return Unit
function public:getCatcher()
    return private.data[self].catcher
end

---@return AbilityTarget
function public:getTarget()
    return private.data[self].target
end

---@param time_left number
function public:setTimeLeft(time_left)
    private.data[self].finish_time = private.casting_current_time + time_left
end

---@return number
function public:getTimeLeft()
    return private.data[self].finish_time - private.casting_current_time
end

---@param casting_time number
function public:start(casting_time)
    self:getCatcher():onCastingStart(self)
    private.casting_list[self] = private.datap[self]
end

function public:casting()
    self:getCatcher():onCastingLoop(self)
end

function public:cancel()
    self:getCatcher():onCastingCancel(self)
    private.casting_list[self] = nil
end

function public:interrupt()
    self:getCatcher():onCastingInterrupt(self)
    private.casting_list[self] = nil
end

function public:finish()
    self:getCatcher():onCastingFinish(self)
    private.casting_list[self] = nil
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.casting_list = setmetatable({}, {__mode = 'kv'})

---@param catcher AbilityDataCastingCatcher
---@param target AbilityTarget
function private.newData(self, catcher, target)
    local priv = {
        catcher = catcher,
        target = target,

        finish_time = -1,
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
            casting_data:casting()
        end
    end
end

if not IsCompiletime() then
    private.casting_timer = Timer.new()
    private.casting_timer:start(private.casting_period, true, private.castingLoop)
end

return static