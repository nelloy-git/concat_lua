---@class UnitDB
local UnitDB = {}

---@param unit_obj userdata
---@param unit Unit
---@return nil
function UnitDB.add(unit_obj, unit)
    UnitDB[unit_obj] = unit
end

---@param unit_obj userdata
---@return nil
function UnitDB.rm(unit_obj)
    UnitDB[unit_obj] = nil
end

---@param unit_obj userdata
---@return Unit
function UnitDB.get(unit_obj)
    return UnitDB[unit_obj]
end

return UnitDB