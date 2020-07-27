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
BinaryLibAPI.Unit = require(libmodename..'.Unit')
BinaryLibAPI.getUnitId = Utils.nextUnitId
BinaryLibAPI.getHeroId = Utils.nextHeroId
---@type BinaryAbilityClass
BinaryLibAPI.Ability = require(libmodename..'.Ability')
BinaryLibAPI.getAbilityId = Utils.nextAbilityId
BinaryLibAPI.getOrderId = Utils.nextOrderId

Lib.finish()

return BinaryLibAPI