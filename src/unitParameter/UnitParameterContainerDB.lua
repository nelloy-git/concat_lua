---@class UnitParameterContainerDB
local UnitParameterContainerDB = {}

---@param wc3_unit wc3_unit
---@param container UnitParameterContainer
function UnitParameterContainerDB.add(wc3_unit, container)
    UnitParameterContainerDB[wc3_unit] = container
end

---@param wc3_unit wc3_unit
function UnitParameterContainerDB.rm(wc3_unit)
    UnitParameterContainerDB[wc3_unit] = nil
end

---@param wc3_unit wc3_unit
---@return UnitParameterContainer
function UnitParameterContainerDB.get(wc3_unit)
    return UnitParameterContainerDB[wc3_unit]
end

return UnitParameterContainerDB