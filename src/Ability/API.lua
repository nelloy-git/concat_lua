--=========
-- Include
--=========

---@type AbilityTypeClass
local Type = require('Ability.Type')
---@type AbilityClass
local Ability = require('Ability.Ability')
---@type AbilityTargetClass
local Target = require('Ability.Target')
---@type AbilityEventClass
local Event = require('Ability.Event')

--=============
--     API
--=============

---@class AbilityAPI
local AbilityAPI = {}

AbilityAPI.TargetType = Type.TargetingType
AbilityAPI.Status = Type.Status

AbilityAPI.Type = Type
AbilityAPI.Ability = Ability
AbilityAPI.Target = Target

return AbilityAPI