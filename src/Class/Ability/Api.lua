--=========
-- Include
--=========

---@type AbilityTypeClass
local Type = require('Class.Ability.Callbacks')

local UnitControl = require('Class.Ability.UnitControl')

--=====
-- API
--=====

local AbilityAPI = {}

---@type table<string, AbilityDummyTargetType>
AbilityAPI.TargetType = Type.TargetType
---@type fun(uniq_name:string, target_type:AbilityDummyTargetType):AbilityType
AbilityAPI.newType = Type.new


return AbilityAPI