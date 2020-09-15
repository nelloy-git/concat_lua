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
TypesAPI.AttackTypeEnum = AttackType.Enum or error('')
TypesAPI.isAttackType = AttackType.isAttackType or error('')
TypesAPI.attackTypeToString = AttackType.toStr or error('')

---@type DamageTypeModule
local DamageType = require(path..'DamageType') or error('')
TypesAPI.DamageTypeEnum = DamageType.Enum or error('')
TypesAPI.isDamageType = DamageType.isDamageType or error('')
TypesAPI.damageTypeToString = DamageType.toStr or error('')

---@type FrameEventTypeModule
local FrameEventType = require(path..'FrameEventType') or error('')
TypesAPI.FrameEventTypeEnum = FrameEventType.Enum or error('')
TypesAPI.isFrameEventType = FrameEventType.isFrameEventType or error('')
TypesAPI.frameEventtoString = FrameEventType.toStr or error('')

---@type TargetTypeModule
local TargetType = require(path..'TargetType') or error('')
TypesAPI.TargetTypeEnum = TargetType.Enum or error('')
TypesAPI.isTargetType = TargetType.isTargetType or error('')
TypesAPI.targetTypetoString = TargetType.toStr or error('')

Lib.finish()

return TypesAPI