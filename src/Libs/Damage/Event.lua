--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Action
local Log = UtilsLib.DefaultLogger
local Unit = UtilsLib.Handle.Unit
local Trigger = UtilsLib.Handle.Trigger

---@type DamageDefines
local Defines = require(lib_modname..'.Defines')
local DamageType = Defines.DamageType

--endregion

--========
-- Module
--========

---@class DamageEvent
local DamageEvent = {}

---@alias DamageCallbackPriority number
DamageEvent.CallbackPriority = {}
DamageEvent.CallbackPriority.Highest = 1
DamageEvent.CallbackPriority.High = 2
DamageEvent.CallbackPriority.Medium = 3
DamageEvent.CallbackPriority.Low = 4
DamageEvent.CallbackPriority.Lowest = 5

local function isCallbackPriority(val)
    for _, priority in pairs(DamageEvent.CallbackPriority) do
        if val == priority then return true end
    end
    return false
end

DamageEvent.Callbacks = {}
for _, dmg_type in pairs(DamageType) do
    DamageEvent.Callbacks[dmg_type] = {}
    for priority = DamageEvent.CallbackPriority.Highest, DamageEvent.CallbackPriority.Lowest do
        DamageEvent.Callbacks[dmg_type][priority] = {}
    end
end

local function executeCallbacks(dmg, dmg_type, target, damager)
    local callbacks = DamageEvent.Callbacks[dmg_type]

    for priority = DamageEvent.CallbackPriority.Highest, DamageEvent.CallbackPriority.Lowest do
        for i = 1, #callbacks[priority] do
            dmg = callbacks[priority][i]:run(dmg, dmg_type, target, damager)
        end
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
---@param sound weapontype
function DamageEvent.damageUnit(dmg, dmg_type, target, damager, sound)
    if not Defines.isDamageType(dmg_type) then
        Log:err('variable \'dmg_type\'('..tostring(dmg_type)..') is not of type DamageType', 2)
    end

    local is_attack = dmg_type == DamageType.PhysicalAttack or
                      dmg_type == DamageType.MagicalAttack or
                      dmg_type == DamageType.ChaosAttack
    UnitDamageTarget(damager:getHandleData(), target:getHandleData(),
                     dmg, is_attack, false, ATTACK_TYPE_CHAOS, dmg_type, sound)
end

---@alias DamageEventCallback fun(dmg:number, dmg_type:damagetype, target:Unit, damager:Unit)

---@param callback DamageEventCallback
---@param dmg_type DamageType
---@param priority DamageCallbackPriority
---@return Action
function DamageEvent.addCallback(callback, dmg_type, priority)
    if not Defines.isDamageType(dmg_type) then
        Log:err('variable \'dmg_type\'('..tostring(dmg_type)..') is not of type DamageType', 2)
    end

    if not isCallbackPriority(priority) then
        Log:err('variable \'priority\'('..tostring(priority)..') is not of type DamageCallbackPriority', 2)
    end

    local action = Action.new(callback)
    table.insert(DamageEvent.Callbacks[dmg_type][priority], action)

    return action
end

---@param action Action
---@return boolean
function DamageEvent.removeCallback(action)
    for _, dmg_type in pairs(DamageType) do
        local callbacks = DamageEvent.Callbacks[dmg_type]

        for priority = DamageEvent.CallbackPriority.Highest, DamageEvent.CallbackPriority.Lowest do
            for i = 1, #callbacks[priority] do
                if callbacks[priority][i] == action then
                    table.remove(callbacks[priority], i)
                    return true
                end
            end
        end
    end
    return false
end

return DamageEvent