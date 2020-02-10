--=========
-- Include
--=========

---@type ParameterUnitClass
local ParameterUnit = require('Parameter.Unit')
---@type ParameterItemClass
local ParameterItem = require('Parameter.Item')
---@type ParameterValueClass
local ParameterValue = require('Parameter.Value')
---@type ParameterData
local ParameterData = require('Parameter.Data')

--=============
--     API
--=============

---@class ParameterAPI
local ParameterAPI = {}

ParameterAPI.ValueType = ParameterValue.ValueType
ParameterAPI.ParamType = ParameterData.Type

ParameterAPI.getShortName = ParameterData.getShortName
ParameterAPI.getFullName = ParameterData.getFullName
ParameterAPI.getIcon = ParameterData.getIcon
ParameterAPI.getTooltip = ParameterData.getTooltip

ParameterAPI.newUnitContainer = ParameterUnit.new
ParameterAPI.getUnitContainer = ParameterUnit.get

ParameterAPI.newItemContainer = ParameterItem.new

--=========
-- Example
--=========

--[[
    local API = ParameterAPI

    local u = CreateUnit(Player(0), ID('hfoo'), 0, 0, 0)
    local params = API.newUnitController(u)
    params:set(API.ParamType.PDmg, API.ValueType, 10)
]] 

return ParameterAPI