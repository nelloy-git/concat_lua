---@class UnitParameterContainerDB
local UnitParameterContainerDB = {}

---@param wc3_unit wc3_Unit
---@param container UnitParameterContainer
function UnitParameterContainerDB.add(wc3_unit, container)
    UnitParameterContainerDB[wc3_unit] = container
end

---@param wc3_unit wc3_Unit
function UnitParameterContainerDB.rm(wc3_unit)
    UnitParameterContainerDB[wc3_unit] = nil
end

---@param wc3_unit wc3_Unit
---@return UnitParameterContainer
function UnitParameterContainerDB.get(wc3_unit)
    return UnitParameterContainerDB[wc3_unit]
end

return UnitParameterContainerDB