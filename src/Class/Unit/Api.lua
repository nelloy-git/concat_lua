--=========
-- Include
--=========

---@type UnitClass
local Unit = require('Class.Unit.Unit')
---@type UnitAnimationClass
local Animation = require('Class.Unit.Animation')

--=============
--     API
--=============

---@class UnitAPI
local UnitAPI = {}

UnitAPI.AnimationType = Animation.AnimationType

UnitAPI.newUnit = Unit.new
UnitAPI.getUnit = Unit.getInstance

return UnitAPI