---@class BinaryLib
local BinaryLibAPI = {}
Lib.start('BinaryLib', {
    Asset = Lib.load(LibList.AssetLib) or error(''),
    Class = Lib.load(LibList.ClassLib) or error(''),
    Types = Lib.load(LibList.TypesLib) or error(''),
    Utils = Lib.load(LibList.UtilsLib) or error(''),
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type BinaryUtils
local Utils = require(path..'Utils') or error('')

---@type BinaryAbilityClass
BinaryLibAPI.Ability = require(path..'Ability') or error('')
BinaryLibAPI.getAbilityId = Utils.nextAbilityId or error('')
BinaryLibAPI.getOrderId = Utils.nextOrderId or error('')

---@type BinaryUnitClass
BinaryLibAPI.Unit = require(path..'Unit') or error('')
BinaryLibAPI.getUnitId = Utils.nextUnitId or error('')
BinaryLibAPI.getHeroId = Utils.nextHeroId or error('')

Lib.finish()

return BinaryLibAPI