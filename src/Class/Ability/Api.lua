--=========
-- Include
--=========

---@type AbilityTypeClass
local Type = require('Class.Ability.Type')
---@type AbilityEventClass
local Event = require('Class.Ability.Event')

--=====
-- API
--=====

---@class AbilityAPI
local AbilityAPI = {}

---@type table<string, AbilityTargetType>
AbilityAPI.TargetType = Type.TargetType
---@type table<string, AbilityCallbackType>
AbilityAPI.CallbackType = Type.CallbackType
---@type table<string, AbilityStatus>
AbilityAPI.Status = Type.Status
---@type fun(uniq_name:string, target_type:AbilityTargetType, user_data:any):AbilityType
AbilityAPI.newType = Type.new
---@type fun(caster:unit):AbilityCastInstance[]
AbilityAPI.getActiveCasts = Event.getCasterInstances

return AbilityAPI