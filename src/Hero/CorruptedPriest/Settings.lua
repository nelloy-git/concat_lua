--=========
-- Include
--=========

---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib) or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamType = ParamLib.ParamType or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local id2int = UtilsLib.id2int or error('')

--========
-- Module
--========

---@class CorruptedPriestSettings
local Settings = {}

Settings.Name = 'Corrupted priest'
Settings.BaseId = id2int('Hpal')
Settings.Id = BinaryLib.getUnitId()
Settings.Icon = Compiletime('ReplaceableTextures\\\\CommandButtons\\\\BTNPriest.blp')

----------------
-- Parameters --
----------------

Settings.Params = {
    [ParamType.PATK] = 10,
    [ParamType.PSPD] = 0.5,
    [ParamType.PDEF] = 2,
    [ParamType.PRES] = 0.05,
    [ParamType.MATK] = 20,
    [ParamType.MSPD] = 0,
    [ParamType.MDEF] = 5,
    [ParamType.MRES] = 0.1,
    [ParamType.CRIT] = 0,
    [ParamType.LIFE] = 500,
    [ParamType.REGE] = 3,
    [ParamType.MANA] = 300,
    [ParamType.RECO] = 1,
    [ParamType.MOVE] = 220,
}

return Settings