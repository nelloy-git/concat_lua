---@class ParameterLib
local ParameterLibAPI = {}
__ParameterLib = Compiletime(Lib.getSelf())

---@type ParameterDefines
local Defines = require(__ParameterLib..'Defines')
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
ParameterLibAPI.Container = require(__ParameterLib..'ValueList')

__ParameterLib = nil
return ParameterLibAPI