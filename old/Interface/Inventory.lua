---@type InventoryFrame
local InventoryFrame = require('baseClasses.Frame.Inventory.Inventory')

local InventoryController = {
    __type = 'InventoryControllerClass'
}

local InventoryController_meta = {
    __type = 'InventoryConotroller',
    __index = InventoryController
}

function InventoryController.new()
    local controller = {}
    setmetatable(controller, InventoryController_meta)

    controller.__inv_frame = InventoryFrame.new()
    
    controller.__inv_frame:setPosition(0.2, 0.1)
    controller.__inv_frame:setSize(0.2, 0.3)
    
    return controller
end

---@param unit Unit
function InventoryController:setTargetUnit(unit)
    self.__target = unit
    self:update()
end

function InventoryController:update()
end

return InventoryController