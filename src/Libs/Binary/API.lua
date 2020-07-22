---@class BinaryLib
local BinaryLibAPI = {}
local libmodename = Compiletime(Lib.getModname())
Lib.start(libmodename)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.ClassLib),
    UtilsLib = require(LibList.UtilsLib)
}

--=====
-- API
--=====

---@type BinaryUtils
local Utils = require(libmodename..'.Utils')

---@type BinaryDataUnitClass
BinaryLibAPI.Unit = require(libmodename..'.UnitData')
BinaryLibAPI.UnitDB = require(libmodename..'.UnitValuesDB')
BinaryLibAPI.getUnitId = Utils.nextUnitId
BinaryLibAPI.getHeroId = Utils.nextHeroId
---@type BinaryDataAbilityClass
BinaryLibAPI.Ability = require(libmodename..'.AbilityData')
BinaryLibAPI.AbilityDB = require(libmodename..'.AbilityValuesDB')
BinaryLibAPI.getAbilityId = Utils.nextAbilityId

Lib.finish()

return BinaryLibAPI