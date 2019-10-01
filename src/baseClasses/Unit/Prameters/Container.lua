---@type DataBase
local DataBase = require('utils.DataBase')
---@type UnitParameterType
local UnitParameterType = require('baseClasses.Unit.Prameters.Type')
---@type UnitParameterValue
local UnitParameterValue = require('baseClasses.Unit.Prameters.Value')

---@class UnitParameterContainer
local UnitParameterContainer, UnitParameterContainer_meta = newClass("UnitParameterContainer")
UnitParameterContainer.__db = DataBase.new('Unit', 'UnitParameterContainer')

function UnitParameterContainer.new()
    local container = {}
end

return UnitParameterContainer