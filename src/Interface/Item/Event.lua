--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

--=======
-- Class
--=======

local InterfaceItemEvent = Class.new('InterfaceItemEvent')
---@class InterfaceItemEvent
local public = InterfaceItemEvent.public
---@class InterfaceItemEventClass
local static = InterfaceItemEvent.static
---@type InterfaceItemEventClass
local override = InterfaceItemEvent.override
local private = {}

--=========
-- Static
--=========

---@alias InterfaceBagSlotPressedCallback fun(player:player, owner:Unit, item:Item)

---@param bag_slot InterfaceItemBagSlot
function static.pressedBagSlot(bag_slot)
    local player = GetTriggerPlayer()
    local unit = bag_slot:getBag():getLoadedBag():getOwner()
    local item = bag_slot:getItem()

    if private.pressedBagCallback then
        private.pressedBagCallback(player, unit, item)
    end
end

function static.pressedEquipmentSlot(equip_slot)
end

---@param callback InterfaceBagSlotPressedCallback
function static.setPressedBagSlotCallback(callback)
    private.pressedBagCallback = callback
end

private.pressedBagCallback = function (player, unit, item)
    print(player, ' pressed ', item, ' from ', unit)
end

return static