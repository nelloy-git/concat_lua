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

---@type AbilityDataClass
local AbilityData = require(lib_modename..'.Data.Base')
AbilityLibAPI.EVENT = AbilityData.EVENT
AbilityLibAPI.addEventAction = AbilityData.addEventAction

---@type AbilityDataEventCallback
local simpleCallback = function(event, abil_data)
    print(event)
end

for _, event_name in pairs(AbilityLibAPI.EVENT) do
    AbilityLibAPI.addEventAction(event_name, simpleCallback)
end

Lib.finish()

return AbilityLibAPI