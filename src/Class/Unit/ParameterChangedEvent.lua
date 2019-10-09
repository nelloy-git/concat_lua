--=========
-- Include
--=========

---@type UnitEvent
local UnitEvent = require('Class.Unit.Event')

--========
-- Module
--========

local UnitParameterEvent = {}

UnitParameterEvent.UNIT_CHANGED_PARAMETER = UnitEvent.new('UNIT_CHANGED_PARAMETER')
---@return Unit
function UnitParameterEvent.GetUnitWithChangedParameters() return nil end
---@return ParameterType
function UnitParameterEvent.GetChangedParameterType() return nil end
---@return number
function UnitParameterEvent.GetChangedParameterOldValue() return nil end
---@return number
function UnitParameterEvent.GetChangedParameterNewValue() return nil end

---@param unit Unit
---@param param_type ParameterType
---@param old_value number
---@param new_value number
function UnitParameterEvent.runUnitChangedParameterEvent(unit, param_type, old_value, new_value)
    -- Save previous variables.
    local prev_get_unit = UnitEvent.GetUnitWithChangedParameters
    local prev_get_name = UnitEvent.GetChangedParameterType
    local prev_get_old_val = UnitEvent.GetChangedParameterOldVaue
    local prev_get_new_val = UnitEvent.GetChangedParameterewValue
    -- Set new variables.
    UnitEvent.GetUnitWithChangedParameters = function() return unit end 
    UnitEvent.GetChangedParameterType = function() return param_type end
    UnitEvent.GetChangedParameterOldValue = function() return old_value end
    UnitEvent.GetChangedParameterNewValue = function() return new_value end

    UnitEvent.UNIT_CHANGED_PARAMETERS:run()

    -- Restore variables.
    UnitEvent.GetUnitWithChangedParameters = prev_get_unit
    UnitEvent.GetChangedParameterType = prev_get_name
    UnitEvent.GetChangedParameterOldValue = prev_get_old_val
    UnitEvent.GetChangedParameterNewValue = prev_get_new_val
end

return UnitParameterEvent