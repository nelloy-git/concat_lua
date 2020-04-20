--=========
-- Include
--=========

---@type AbilityOldTypeOldClass
local Type = require('AbilityOld.Type')
---@type AbilityOldClass
local AbilityOld = require('AbilityOld.AbilityOld')
require('AbilityOld.MustHave.Casting')
require('AbilityOld.MustHave.Cooldown')

--=============
--     API
--=============

---@class AbilityOldAPI
local AbilityOldAPI = {}

-- Enums
AbilityOldAPI.TargetingType = Type.TargetingType

-- Classes
AbilityOldAPI.Type = Type
AbilityOldAPI.AbilityOld = AbilityOld

-- Casting
AbilityOldAPI.getCastingPeriod = AbilityOld.getCastingPeriod
AbilityOldAPI.getCastingAbilityOld = AbilityOld.getCastingAbilityOld
AbilityOldAPI.getCastingTarget = AbilityOld.getCastingTarget
AbilityOldAPI.getCastingTimeLeft = AbilityOld.getCastingTimeLeft
AbilityOldAPI.getCastingTimeFull = AbilityOld.getCastingTimeFull
AbilityOldAPI.cancelCastingAbilityOld = AbilityOld.cancelCastingAbilityOld
AbilityOldAPI.interruptCastingAbilityOld = AbilityOld.interruptCastingAbilityOld
AbilityOldAPI.finishCastingAbilityOld = AbilityOld.finishCastingAbilityOld
AbilityOldAPI.extraPeriodForCastingAbilityOld = AbilityOld.extraPeriodForCastingAbilityOld

-- Targets
AbilityOldAPI.TargetNone = require('AbilityOld.Target.None')
AbilityOldAPI.TargetPoint = require('AbilityOld.Target.Point')
AbilityOldAPI.TargetUnit = require('AbilityOld.Target.Unit')
AbilityOldAPI.TargetDestructable = require('AbilityOld.Target.Destructable')
AbilityOldAPI.TargetItem = require('AbilityOld.Target.Item')

return AbilityOldAPI