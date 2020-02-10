--=========
-- Include
--=========

---@type AbilityTypeClass
local Type = require('Class.Ability.Type')
---@type AbilityEventClass
local Event = require('Class.Ability.Event')

--=============
--     API
--=============

---@class AbilityAPI
local AbilityAPI = {}

AbilityAPI.TargetType = Type.TargetType
AbilityAPI.CallbackType = Type.CallbackType
AbilityAPI.Status = Type.Status
AbilityAPI.newType = Type.new
AbilityAPI.getActiveCasts = Event.getCasterInstances

return AbilityAPI