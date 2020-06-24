--=========
-- Include
--=========

--region Include
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Trigger = UtilsLib.Handle.Trigger
---@type ParameterLib
local ParameterLib = depencies.ParameterLib
local PhysReduc = ParameterLib.PhysicalDamageReduction
local Def = ParameterLib.Defence
local MagicReduc = ParameterLib.MagicalDamageReduction
local Resistance = ParameterLib.Resistance

--========
-- Module
--========

local DamageEvent = {}

DamageEvent.phys_dmg_type = DAMAGE_TYPE_NORMAL
DamageEvent.magic_dmg_type = DAMAGE_TYPE_MAGIC
DamageEvent.true_dmg_type = DAMAGE_TYPE_UNKNOWN

DamageEvent.actions = {}

function DamageEvent.Init()
    if IsCompiletime() then
        return
    end

    local trigger = Trigger.new()
    for i = 1, bj_MAX_PLAYER_SLOTS do
        trigger:addPlayerEvent(EVENT_PLAYER_UNIT_DAMAGING, Player(i))
    end
    trigger:addAction(function()
        local dmg = GetEventDamage()
        local damager = GetEventDamageSource()
        local target = BlzGetEventDamageTarget()
        local dmg_type = BlzGetEventDamageType()

        if dmg_type == DamageEvent.phys_dmg_type then
            dmg = dmg * (1 - )
        end
    end)
end

return DamageEvent