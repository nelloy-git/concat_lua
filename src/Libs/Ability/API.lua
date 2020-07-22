---@class AbilityLib
local AbilityLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.ClassLib),
    UtilsLib = require(LibList.UtilsLib),
    BinaryLib = require(LibList.BinaryLib)
}

--=====
-- API
--=====

---@type AbilitiesContainerClass
AbilityLibAPI.Container = require(modname..'.Container')
---@type AbilityTypeClass
AbilityLibAPI.Type = require(modname..'.Type')
---@type AbilityType
AbilityLibAPI.TestType = require(modname..'.TestType')

---@type AbilityTargetDestructableClass
AbilityLibAPI.TargetDestructable = require(modname..'.Target.Destructable')
---@type AbilityTargetItemClass
AbilityLibAPI.TargetItem = require(modname..'.Target.Item')
---@type AbilityTargetNoneClass
AbilityLibAPI.TargetNone = require(modname..'.Target.None')
---@type AbilityTargetPointClass
AbilityLibAPI.TargetPoint = require(modname..'.Target.Point')
---@type AbilityTargetUnitClass
AbilityLibAPI.TargetUnit = require(modname..'.Target.Unit')

Lib.finish()

return AbilityLibAPI