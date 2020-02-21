--=========
-- Include
--=========

---@type AbilityTypeClass
local Type = require('Ability.Type')
---@type AbilityClass
local Ability = require('Ability.Ability')
---@type AbilityCastInstanceClass
local CastInstance = require('Ability.CastInstance')
---@type AbilityEventClass
local Event = require('Ability.Event')

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

-- Utils
AbilityAPI.cancel = Event.cancelCurrentCasting
AbilityAPI.interrupt = Event.interruptCurrentCasting
AbilityAPI.finish = Event.finishCurrentCasting

-- Targets
AbilityAPI.TargetNone = require('Ability.Target.None')
AbilityAPI.TargetPoint = require('Ability.Target.Point')
AbilityAPI.TargetUnit = require('Ability.Target.Unit')
AbilityAPI.TargetDestructable = require('Ability.Target.Destructable')
AbilityAPI.TargetItem = require('Ability.Target.Item')

return AbilityAPI