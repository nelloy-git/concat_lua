---@type UnitEvent
local UnitEvent = require('baseClasses.Unit.UnitEvent')
local SelectedUnit = require('baseClasses.Unit.UnitSelected')

local Interface = require('baseClasses.Frame.Interface')
---@type InventoryFrame
local Inventory = Interface.INVENTORY

local ParameterAreaEvent = {}

function ParameterAreaEvent.init()
    UnitEvent.UNIT_SELECTED:addAction(runFuncInDebug, ParameterAreaEvent.updateUnit)
    UnitEvent.UNIT_CHANGED_PARAMETERS:addAction(runFuncInDebug, ParameterAreaEvent.updateParameters)
end

function ParameterAreaEvent.updateUnit()
    local selected = SelectedUnit.getSelectedByPlayer()
    local count = #selected
    if count == 1 then
        local param_area = Inventory:getParametersArea()
        param_area:setUnit(selected[1])
    end
end

function ParameterAreaEvent.updateParameters()
    local unit = UnitEvent.GetUnitWithChangedParameters()
    --if Inventory:getUnit()
end

return ParameterAreaEvent