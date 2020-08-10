---@class AbilityLib
local AbilityLibAPI = {}
local lib_modename = Compiletime(Lib.getModname())
Lib.start(lib_modename)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.ClassLib),
    UtilsLib = require(LibList.UtilsLib),
    BinaryLib = require(LibList.BinaryLib),
}

--=====
-- API
--=====

---@type AbilitiesContainerClass
AbilityLibAPI.Container = require(lib_modename..'.Data.Container')

---@type AbilityDataTypeClass
AbilityLibAPI.Type = require(lib_modename..'.Data.Type')
---@type AbilityDataType
AbilityLibAPI.TestType = require(lib_modename..'.TestType')

---@type AbilityTargetDestructableClass
AbilityLibAPI.TargetDestructable = require(lib_modename..'.Target.Destructable')
---@type AbilityTargetItemClass
AbilityLibAPI.TargetItem = require(lib_modename..'.Target.Item')
---@type AbilityTargetNoneClass
AbilityLibAPI.TargetNone = require(lib_modename..'.Target.None')
---@type AbilityTargetPointClass
AbilityLibAPI.TargetPoint = require(lib_modename..'.Target.Point')
---@type AbilityTargetUnitClass
AbilityLibAPI.TargetUnit = require(lib_modename..'.Target.Unit')

--AbilityLibAPI.Test = require(lib_modename..'.Dummy.Type')

Lib.finish()

return AbilityLibAPI