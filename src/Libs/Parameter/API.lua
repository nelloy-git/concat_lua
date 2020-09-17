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
ParameterLibAPI.Enum = {
    PDMG = Defines.PhysicalDamage or error(''),
    PDEF = Defines.Defence or error(''),
    PRES = Defines.PhysicalDamageReduction or error(''),
    MDMG = Defines.MagicalDamage or error(''),
    MDEF = Defines.Resistance or error(''),
    MRES = Defines.MagicalDamageReduction or error(''),
    ASPD = Defines.AttackSpeed or error(''),
    CDR = Defines.CooldownReduction or error(''),
    CRES = Defines.ControlReduction or error(''),
    DCH = Defines.DodgeChance or error(''),
    CRCH = Defines.CriticalStrikeChance or error(''),
    LIFE = Defines.Health or error(''),
    REGEN = Defines.Regeneration or error(''),
    MANA = Defines.Mana or error(''),
    RECOV = Defines.Recovery or error(''),
    MSPD = Defines.MoveSpeed or error(''),
}
---@type table<number, Parameter>
ParameterLibAPI.AllParameters = Defines.AllParameters or error('')

---@type ParameterContainerUnitClass
ParameterLibAPI.UnitContainer = require(path..'Container.Unit') or error('')

---@type ParameterDamageEvent
local DamageEvent = require(path..'Damage')

Lib.finish()

return ParameterLibAPI