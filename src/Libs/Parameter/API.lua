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
---@type Parameter
ParameterLibAPI.PhysicalDamage = Defines.PhysicalDamage
---@type Parameter
ParameterLibAPI.AttackSpeed = Defines.AttackSpeed
---@type Parameter
ParameterLibAPI.Defence = Defines.Defence
---@type Parameter
ParameterLibAPI.PhysicalDamageReduction = Defines.PhysicalDamageReduction
---@type Parameter
ParameterLibAPI.MagicalDamage = Defines.MagicalDamage
---@type Parameter
ParameterLibAPI.CooldownReduction = Defines.CooldownReduction
---@type Parameter
ParameterLibAPI.Resistance = Defines.Resistance
---@type Parameter
ParameterLibAPI.MagicalDamageReduction = Defines.MagicalDamageReduction
---@type Parameter
ParameterLibAPI.ControlReduction = Defines.ControlReduction
---@type Parameter
ParameterLibAPI.DodgeChance = Defines.DodgeChance
---@type Parameter
ParameterLibAPI.CriticalStrikeChance = Defines.CriticalStrikeChance
---@type Parameter
ParameterLibAPI.Health = Defines.Health
---@type Parameter
ParameterLibAPI.Regeneration = Defines.Regeneration
---@type Parameter
ParameterLibAPI.Mana = Defines.Mana
---@type Parameter
ParameterLibAPI.MoveSpeed = Defines.MoveSpeed
---@type Parameter[]
ParameterLibAPI.AllParameters = Defines.AllParameters
---@type ParameterValueListClass
ParameterLibAPI.Container = require(modname..'.ValueList')
---@type UnitParameterContainerClass
ParameterLibAPI.UnitContainer = require(modname..'.UnitContainer')

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