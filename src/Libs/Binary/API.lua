---@class BinaryLib
local BinaryLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

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

---@type BinaryDataUnitClass
BinaryLibAPI.Unit = require(modname..'.UnitData')
BinaryLibAPI.UnitDB = require(modname..'.UnitValuesDB')

Lib.finish()

return BinaryLibAPI