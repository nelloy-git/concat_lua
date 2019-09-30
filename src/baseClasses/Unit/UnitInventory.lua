---@type Unit
local Unit = require('baseClasses.Unit.UnitData')

---@class UnitInventory
local UnitInventory = {
    __type = 'UnitInvetoryClass'
}

local UnitInventory_meta = {
    __type = 'UnitInventory',
    __index = UnitInventory
}

Unit.addCreationFunction(function(unit)
    if unit.__inventory then
        Debug("UnitInventory error: Unit instance already has field __inventory.")
        return false
    end

    unit.__inventory = UnitInventory.new()

    return true
end)

---@return UnitInventory
function UnitInventory.new()
    local inventory = {}
end

function UnitInventory.init()
end

return UnitInventory