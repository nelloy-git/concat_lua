--=========
-- Include
--=========

---@type UnitTypeClass
local UnitType = require('Unit.Type')
---@type UnitClass
local Unit = require('Unit.Unit')
require('Unit.MustHave.Flags')
require('Unit.MustHave.Position')

--=============
--     API
--=============

---@class UnitAPI
local UnitAPI = {}

UnitAPI.Unit = Unit

UnitAPI.Type = UnitType
UnitAPI.UnitTypeClass = UnitType.Classification

return UnitAPI