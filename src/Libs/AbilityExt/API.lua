---@class AbilityLib
local AbilityLibAPI = {}
Lib.start('AbilityLib', {
    Binary = Lib.load(LibList.BinaryLib),
    Class = Lib.load(LibList.ClassLib),
    Handle = Lib.load(LibList.HandleLib),
    Input = Lib.load(LibList.InputLib),
    Types = Lib.load(LibList.TypesLib),
    Utils = Lib.load(LibList.UtilsLib),
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type AbilityExtContainerClass
AbilityLibAPI.Container = require(path..'Container') or error('')
---@type AbilityExtEventModule
local AbilityExtEventModule = require(path..'Event') or error('')
AbilityLibAPI.Event = AbilityExtEventModule.Enum
---@type AbilityExtTypeClass
AbilityLibAPI.Type = require(path..'Type') or error('')

AbilityLibAPI.Targeting = {}
---@type AbilityExtTypeTargetingClass
AbilityLibAPI.Targeting.Type = require(path..'Type.Targeting') or error('')
---@type AbilityExtTypeTargetingUnitClass
AbilityLibAPI.Targeting.Unit = require(path..'Type.Targeting.Unit') or error('')
---@type AbilityExtTypeTargetingFriendClass
AbilityLibAPI.Targeting.Friend = require(path..'Type.Targeting.Friend') or error('')

AbilityLibAPI.Casting = {}
---@type AbilityExtTypeCastingClass
AbilityLibAPI.Casting.Type = require(path..'Type.Casting') or error('')

AbilityLibAPI.Data = {}
---@type AbilityExtTypeDataClass
AbilityLibAPI.Data.Type = require(path..'Type.Data') or error('')

---@type AbilityExtClass
local Ability = require(path..'Ability') or error('')


--[[


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
]]
Lib.finish()

return AbilityLibAPI