--=========
-- Include
--=========

--region Include
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Trigger = UtilsLib.Handle.Trigger
local Action = UtilsLib.Action
local Unit = UtilsLib.Handle.Unit

--========
-- Module
--========

---@class DamageEvent
local DamageEvent = {}

DamageEvent.DamageType = {}
DamageEvent.DamageType.Physical = DAMAGE_TYPE_NORMAL
DamageEvent.DamageType.Magical = DAMAGE_TYPE_MAGIC
DamageEvent.DamageType.True = DAMAGE_TYPE_UNKNOWN

---@alias DamageEventCallbackPriority number
DamageEvent.CallbackPriority.Highest = 0
DamageEvent.CallbackPriority.High = 1
DamageEvent.CallbackPriority.Medium = 2
DamageEvent.CallbackPriority.Low = 3
DamageEvent.CallbackPriority.Lowest = 4

local function isCallbackPriority(val)
    for _, priority in pairs(DamageEvent.CallbackPriority) do
        if val == priority then return true end
    end
    return false
end

DamageEvent.callbacks = {}
for _, priority in pairs(DamageEvent.CallbackPriority) do
    DamageEvent.callbacks[priority] = {}
end

local callbacks = {}
local function executeCallbacks(dmg, dmg_type, target, damager)
    for i = 1, #callbacks do
        dmg = callbacks[i]:run(dmg, dmg_type, target, damager)
    end
    return dmg
end

function DamageEvent.Init()
    if IsCompiletime() then
        return
    end

    local trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_DAMAGING, Player(i))
    end
    trigger:addAction(function()
        local dmg = executeCallbacks(GetEventDamage(), BlzGetEventDamageType(),
                                     Unit.getLinked(BlzGetEventDamageTarget()),
                                     Unit.getLinked(GetEventDamageSource()))
        BlzSetEventDamage(dmg < 0 and 0 or dmg)
    end)
end

local UnitDamageTarget = UnitDamageTarget
---@param dmg number
---@param dmg_type damagetype
---@param target Unit
---@param damager Unit
function DamageEvent.damageUnit(dmg, dmg_type, target, damager)
    UnitDamageTarget(damager:getHandleData(), target:getHandleData(),
                     dmg, false, false, ATTACK_TYPE_CHAOS, dmg_type, WEAPON_TYPE_WHOKNOWS)
end

---@alias DamageEventCallback fun(dmg:number, dmg_type:damagetype, target:Unit, damager:Unit)

---@param callback DamageEventCallback
---@return Action
function DamageEvent.addCallback(callback, priority)
    local action = Action.new(callback)
    table.insert(callbacks, action)

    return action
end

---@param action Action
---@return boolean
function DamageEvent.removeCallback(action)
    for i = 1, #callbacks do
        if callbacks[i] == action then
            table.remove(callbacks, i)
            return true
        end
    end
    return false
end

return DamageEvent