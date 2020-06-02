local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type ObjectLib
local ObjectLib = depencies.Object
---@type UtilsLib
local UtilsLib = depencies.UtilsLib

---@type UnitParameterContainerClass
local UnitContainer = require(lib_modname..'.UnitContainer')

if IsCompiletime() then
    return
end

local dmg_trigger = ObjectLib.Trigger.new()
for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
    dmg_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_DAMAGING, Player(i))
end
dmg_trigger:addAction(function()
    local damage     = GetEventDamage() -- число урона
    local damageType = BlzGetEventDamageType()
    if damage < 1 then return end

    local target = GetTriggerUnit() -- тот кто получил урон
    local attacker = GetEventDamageSource() -- тот кто нанёс урон
end)