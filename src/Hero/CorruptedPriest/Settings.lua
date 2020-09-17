--=========
-- Include
--=========

---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib) or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local Param = ParamLib.Enum
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
    [Param.PDMG] = 0,
    [Param.ASPD] = 0,
    [Param.PDEF] = 3,
    [Param.PRES] = 0,
    [Param.MDMG] = 10,
    [Param.CDR] = 0,
    [Param.MRES] = 5,
    [Param.MRES] = 0,
    [Param.CRES] = 0,
    [Param.DCH] = 0,
    [Param.CRCH] = 0,
    [Param.LIFE] = 300,
    [Param.REGEN] = 3,
    [Param.MANA] = 200,
    [Param.RECOV] = 5,
    [Param.MSPD] = 0,
}

return Settings