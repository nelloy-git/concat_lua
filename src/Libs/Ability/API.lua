---@class AbilityLib
local AbilityLibAPI = {}
Lib.start('AbilityLib', {
    Binary = Lib.load(LibList.BinaryLib),
    Class = Lib.load(LibList.ClassLib),
    Handle = Lib.load(LibList.HandleLib),
    Types = Lib.load(LibList.TypesLib),
    Utils = Lib.load(LibList.UtilsLib),
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type AbilitiesContainerClass
AbilityLibAPI.Container = require(path..'Data.Container') or error('')

---@type AbilityDataTypeClass
AbilityLibAPI.Type = require(path..'Data.Type') or error('')

---@type AbilityTargetDestructableClass
AbilityLibAPI.TargetDestructable = require(path..'Target.Destructable') or error('')
---@type AbilityTargetItemClass
AbilityLibAPI.TargetItem = require(path..'Target.Item') or error('')
---@type AbilityTargetNoneClass
AbilityLibAPI.TargetNone = require(path..'Target.None') or error('')
---@type AbilityTargetPointClass
AbilityLibAPI.TargetPoint = require(path..'Target.Point') or error('')
---@type AbilityTargetUnitClass
AbilityLibAPI.TargetUnit = require(path..'Target.Unit') or error('')

---@type AbilityDataClass
local AbilityData = require(path..'Data.Base') or error('')
AbilityLibAPI.EVENT = AbilityData.EVENT
AbilityLibAPI.addEventAction = AbilityData.addEventAction

---@type AbilityCastingClass
local AbilityCasting = require(path..'Casting.Base')
AbilityLibAPI.CastingLoopPeriod = AbilityCasting.getCastingPeriod()

---@type AbilityDataType
AbilityLibAPI.TestType = require(path..'TestType') or error('')

Lib.finish()

return AbilityLibAPI