--=========
-- Include
--=========

---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local id2int = UtilsLib.Functions.id2int
local Icon = UtilsLib.Icon

--========
-- Module
--========

---@class CorruptedPriestSettings
local Settings = {}

Settings.Name = 'Corrupted priest'
Settings.BaseId = id2int('Hpal')
Settings.Id = BinaryLib.getHeroId()
Settings.Icon = Compiletime(Icon.BTNPriest)

----------------
-- Parameters --
----------------

Settings.Params = {
    [ParamLib.PhysicalDamage] = 0,
    [ParamLib.AttackSpeed] = 0,
    [ParamLib.Defence] = 3,
    [ParamLib.PhysicalDamageReduction] = 0,
    [ParamLib.MagicalDamage] = 10,
    [ParamLib.CooldownReduction] = 0,
    [ParamLib.Resistance] = 5,
    [ParamLib.MagicalDamageReduction] = 0,
    [ParamLib.ControlReduction] = 0,
    [ParamLib.DodgeChance] = 0,
    [ParamLib.CriticalStrikeChance] = 0,
    [ParamLib.Health] = 300,
    [ParamLib.Regeneration] = 3,
    [ParamLib.Mana] = 200,
    [ParamLib.Recovery] = 5,
    [ParamLib.MoveSpeed] = 0,
}

return Settings