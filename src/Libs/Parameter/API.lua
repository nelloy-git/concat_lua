---@class ParameterLib
local ParameterLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.ClassLib),
    UtilsLib = require(LibList.UtilsLib),
    DamageLib = require(LibList.DamageLib)
}
local depencies = Lib.current().depencies

--=====
-- API
--=====

---@type ParameterDefines
local Defines = require(modname..'.Defines')
ParameterLibAPI.PhysicalDamage = Defines.PhysicalDamage
ParameterLibAPI.AttackSpeed = Defines.AttackSpeed
ParameterLibAPI.Defence = Defines.Defence
ParameterLibAPI.PhysicalDamageReduction = Defines.PhysicalDamageReduction
ParameterLibAPI.MagicalDamage = Defines.MagicalDamage
ParameterLibAPI.CooldownReduction = Defines.CooldownReduction
ParameterLibAPI.Resistance = Defines.Resistance
ParameterLibAPI.MagicalDamageReduction = Defines.MagicalDamageReduction
ParameterLibAPI.ControlReduction = Defines.ControlReduction
ParameterLibAPI.DodgeChance = Defines.DodgeChance
ParameterLibAPI.CriticalStrikeChance = Defines.CriticalStrikeChance
ParameterLibAPI.Health = Defines.Health
ParameterLibAPI.Regeneration = Defines.Regeneration
ParameterLibAPI.Mana = Defines.Mana
ParameterLibAPI.Recovery = Defines.Recovery
ParameterLibAPI.MoveSpeed = Defines.MoveSpeed
---@type table<number, Parameter>
ParameterLibAPI.AllParameters = Defines.AllParameters
---@type ParameterValueListClass
ParameterLibAPI.Container = require(modname..'.ValueList')
---@type ParameterClass
ParameterLibAPI.Parameter = require(modname..'.Parameter')
---@type ParameterContainerUnitClass
ParameterLibAPI.UnitContainer = require(modname..'.UnitContainer')
---@type ParameterValueListClass
ParameterLibAPI.ValueList = require(modname..'.ValueList')

--=======================
-- Register unit damage.
--=======================

---@type DamageType
local DamageType = depencies.DamageLib.DamageType
---@type DamageCallbackPriority
local Priority = depencies.DamageLib.CallbackPriority

for _, dmg_type in pairs(DamageType) do
    Lib.current().depencies.DamageLib.addCallback(ParameterLibAPI.UnitContainer.DamageCallback,
                                                  dmg_type, Priority.Highest)
end

Lib.finish()

return ParameterLibAPI