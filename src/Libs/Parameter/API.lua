---@class ParameterLib
local ParameterLibAPI = {}
Lib.start('ParameterLib', {
    Asset = Lib.load(LibList.AssetLib) or error(''),
    Class = Lib.load(LibList.ClassLib) or error(''),
    Damage = Lib.load(LibList.DamageLib) or error(''),
    Handle = Lib.load(LibList.HandleLib) or error(''),
    Types = Lib.load(LibList.TypesLib) or error(''),
    Utils = Lib.load(LibList.UtilsLib) or error(''),
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type ParameterClass
ParameterLibAPI.Parameter = require(path..'Parameter') or error('')

---@type ParameterDefines
local Defines = require(path..'Defines') or error('')
ParameterLibAPI.PhysicalDamage = Defines.PhysicalDamage or error('')
ParameterLibAPI.AttackSpeed = Defines.AttackSpeed or error('')
ParameterLibAPI.Defence = Defines.Defence or error('')
ParameterLibAPI.PhysicalDamageReduction = Defines.PhysicalDamageReduction or error('')
ParameterLibAPI.MagicalDamage = Defines.MagicalDamage or error('')
ParameterLibAPI.CooldownReduction = Defines.CooldownReduction or error('')
ParameterLibAPI.Resistance = Defines.Resistance or error('')
ParameterLibAPI.MagicalDamageReduction = Defines.MagicalDamageReduction or error('')
ParameterLibAPI.ControlReduction = Defines.ControlReduction or error('')
ParameterLibAPI.DodgeChance = Defines.DodgeChance or error('')
ParameterLibAPI.CriticalStrikeChance = Defines.CriticalStrikeChance or error('')
ParameterLibAPI.Health = Defines.Health or error('')
ParameterLibAPI.Regeneration = Defines.Regeneration or error('')
ParameterLibAPI.Mana = Defines.Mana or error('')
ParameterLibAPI.Recovery = Defines.Recovery or error('')
ParameterLibAPI.MoveSpeed = Defines.MoveSpeed or error('')
---@type table<number, Parameter>
ParameterLibAPI.AllParameters = Defines.AllParameters or error('')

local Damage = require(path..'Damage') or error('')
---@type ParameterContainerUnitClass
ParameterLibAPI.UnitContainer = require(path..'Container.Unit') or error('')

Lib.finish()

return ParameterLibAPI