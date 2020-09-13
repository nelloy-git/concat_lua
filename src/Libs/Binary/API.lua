---@class BinaryLib
local BinaryLibAPI = {}
Lib.start('BinaryLib', {
    Class = Lib.load(LibList.ClassLib),
    UtilsLib = Lib.load(LibList.UtilsLib),
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type BinaryUtils
local Utils = require(path..'Utils')

---@type BinaryUnitClass
BinaryLibAPI.Unit = require(path..'Unit')
BinaryLibAPI.getUnitId = Utils.nextUnitId
BinaryLibAPI.getHeroId = Utils.nextHeroId
---@type BinaryAbilityClass
BinaryLibAPI.Ability = require(path..'Ability')
BinaryLibAPI.getAbilityId = Utils.nextAbilityId
BinaryLibAPI.getOrderId = Utils.nextOrderId

Lib.finish()

return BinaryLibAPI