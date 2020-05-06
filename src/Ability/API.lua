--=========
-- Include
--=========

---@type AbilityTypeClass
--local Type = require('Ability.Type')
---@type AbilityClass
--local Ability = require('Ability.Ability')
--require('Ability.MustHave.Casting')
--require('Ability.MustHave.Cooldown')

--=============
--     API
--=============
---@class AbilityAPI
local AbilityAPI = {}

--[[
-- Enums
AbilityAPI.TargetingType = Type.TargetingType

-- Classes
AbilityAPI.Type = Type
AbilityAPI.Ability = Ability

-- Casting
AbilityAPI.getCastingPeriod = Ability.getCastingPeriod
AbilityAPI.getCastingAbility = Ability.getCastingAbility
AbilityAPI.getCastingTarget = Ability.getCastingTarget
AbilityAPI.getCastingTimeLeft = Ability.getCastingTimeLeft
AbilityAPI.getCastingTimeFull = Ability.getCastingTimeFull
AbilityAPI.cancelCastingAbility = Ability.cancelCastingAbility
AbilityAPI.interruptCastingAbility = Ability.interruptCastingAbility
AbilityAPI.finishCastingAbility = Ability.finishCastingAbility
AbilityAPI.extraPeriodForCastingAbility = Ability.extraPeriodForCastingAbility

-- Targets
AbilityAPI.TargetNone = require('Ability.Target.None')
AbilityAPI.TargetPoint = require('Ability.Target.Point')
AbilityAPI.TargetUnit = require('Ability.Target.Unit')
AbilityAPI.TargetDestructable = require('Ability.Target.Destructable')
AbilityAPI.TargetItem = require('Ability.Target.Item')
]]
return AbilityAPI