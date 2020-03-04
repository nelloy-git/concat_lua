--=========
-- Include
--=========

---@type ParameterUnitClass
local Unit = require('Parameter.Unit')
---@type ParameterItemClass
local Item = require('Parameter.Item')
---@type ParameterValueClass
local Value = require('Parameter.Value')
---@type ParameterData
local Data = require('Parameter.Data')

--=============
--     API
--=============

---@class ParameterAPI
local ParameterAPI = {}

ParameterAPI.ValueType = Value.ValuePos
ParameterAPI.ParamType = Data.Type

ParameterAPI.getShortName = Data.getShortName
ParameterAPI.getFullName = Data.getFullName
ParameterAPI.getIcon = Data.getIcon
ParameterAPI.getTooltip = Data.getTooltip
ParameterAPI.mathParameter = Data.mathParam

ParameterAPI.Unit = Unit
ParameterAPI.Item = Item

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