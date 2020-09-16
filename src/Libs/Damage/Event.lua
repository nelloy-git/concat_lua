--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type TypesLib
local TypesLib = lib_dep.Types or error('')
local DamageType = TypesLib.DamageTypeEnum or error('')
local isDamageType = TypesLib.isDamageType
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Trigger = HandleLib.Trigger or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')
local pairsByKeys = UtilsLib.pairsByKeys or error('')

--========
-- Module
--========

---@class DamageEvent
local DamageEvent = {}

DamageEvent.callbacks = {}
for _, dmg_type in pairs(DamageType) do
    DamageEvent.callbacks[dmg_type] = {}
end

---@alias DamageEventCallback fun(dmg:number, dmg_type:damagetype, targ:Unit, src:Unit):number

--- Actions with same priority can will be executed in random order.
---@param dmg_type damagetype
---@param priority integer
---@param callback DamageEventCallback
---@return Action
function DamageEvent.addAction(dmg_type, priority, callback)
    if not isDamageType(dmg_type) then
        Log:err('variable \'dmg_type\' is not of type damagetype', 2)
    end
    isTypeErr(priority, 'number', 'priority')
    isTypeErr(callback, 'function', 'callback')

    local action_lists_by_priority = DamageEvent.callbacks[dmg_type]
    if not action_lists_by_priority[priority] then
        action_lists_by_priority[priority] = ActionList.new(DamageEvent)
    end
    local actions = action_lists_by_priority[priority]
    return actions:add(callback)
end

---@param action Action
---@return boolean
function DamageEvent.removeAction(action)
    for dmg_type, action_lists_by_priority in pairs(DamageEvent.callbacks) do
        for priority, actions in pairs(action_lists_by_priority) do
            if actions:remove(action) then return true end
        end
    end
    return false
end

---@param dmg number
---@param dmg_type damagetype
---@param targ Unit
---@param src Unit
---@return number
local function runActions(dmg, dmg_type, targ, src)
    local action_lists_by_priority = DamageEvent.callbacks[dmg_type]

    for _, actions in pairsByKeys(action_lists_by_priority, function(k1, k2) return k1 > k2 end) do
        local count = actions:count()
        for i = 1, count do
            dmg = actions:get(i):run(dmg, dmg_type, targ, src)
        end
    end

    return dmg
end

if not IsCompiletime() then
    local trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_DAMAGING, Player(i))
    end
    trigger:addAction(function()
        local dmg = GetEventDamage()
        local dmg_type = BlzGetEventDamageType()
        local targ = Unit.getLinked(BlzGetEventDamageTarget())
        local src = Unit.getLinked(GetEventDamageSource())

        dmg = runActions(dmg, dmg_type, targ, src)
        BlzSetEventDamage(dmg < 0 and 0 or dmg)
    end)
end

return DamageEvent