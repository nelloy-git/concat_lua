--=========
-- Include
--=========

---@type ParameterValueClass
local Value = require('Parameter.Value')
---@type ParameterValueListClass
local ValueList = require('Parameter.ValueList')
---@type ParameterData
local ParamData = require('Parameter.Data')

--=============
--     API
--=============

---@class ParameterAPI
local ParameterAPI = {}

ParameterAPI.ValueList = ValueList
ParameterAPI.ValueType = Value.ValueType
ParameterAPI.ParamType = ParamData.Type

ParameterAPI.isPhysic = ParamData.isParamPhysic
ParameterAPI.isMagic = ParamData.isParamMagic
ParameterAPI.isPercent = ParamData.isParamPercent
ParameterAPI.getShortName = ParamData.getShortName
ParameterAPI.getFullName = ParamData.getFullName
ParameterAPI.getIcon = ParamData.getIcon
ParameterAPI.getTooltip = ParamData.getTooltip
ParameterAPI.mathParameter = ParamData.mathParam

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