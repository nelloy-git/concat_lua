---@class TypesLib
local TypesAPI = {}
Lib.start('Types', {
    Utils = Lib.load(LibList.UtilsLib) or error('')
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type AttackTypeModule
local AttackType = require(path..'AttackType') or error('')
TypesAPI.AttackTypeEnum = AttackType.Enum
TypesAPI.isAttackType = AttackType.isAttackType
TypesAPI.attackTypeToString = AttackType.toStr

---@type TargetTypeModule
local TargetType = require(path..'TargetType') or error('')
TypesAPI.TargetTypeEnum = TargetType.Enum
TypesAPI.isTargetType = TargetType.isTargetType
TypesAPI.targetTypetoString = TargetType.toStr

Lib.finish()

return TypesAPI