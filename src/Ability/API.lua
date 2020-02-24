--=========
-- Include
--=========

---@type AbilityTypeClass
local Type = require('Ability.Type')
---@type AbilityCastInstanceClass
local CastInstance = require('Ability.CastInstance')
---@type AbilityClass
local Ability = require('Ability.Ability')

--=============
--     API
--=============

---@class AbilityAPI
local AbilityAPI = {}

-- Enums
AbilityAPI.TargetingType = Type.TargetingType
AbilityAPI.Status = CastInstance.Status

-- Classes
AbilityAPI.Type = Type
AbilityAPI.Ability = Ability
AbilityAPI. CastInstance = CastInstance

-- Utils
--AbilityAPI.cancel = Event.cancelCurrentCasting
--AbilityAPI.interrupt = Event.interruptCurrentCasting
--AbilityAPI.finish = Event.finishCurrentCasting

-- Targets
AbilityAPI.TargetNone = require('Ability.Target.None')
AbilityAPI.TargetPoint = require('Ability.Target.Point')
AbilityAPI.TargetUnit = require('Ability.Target.Unit')
AbilityAPI.TargetDestructable = require('Ability.Target.Destructable')
AbilityAPI.TargetItem = require('Ability.Target.Item')

return AbilityAPI