--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type Unit
local Unit = require('Unit.Unit')
---@type Interface
local Interface = require('Interface.Interface')

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

---@param bag_slot InterfaceItemBagSlot
function static.pressedBagSlot(bag_slot)
    local player = GetTriggerPlayer()
    local unit = bag_slot:getBag():getLoadedBag():getOwner()
    local item = bag_slot:getItem()

    print(player, ' pressed ', item, ' from ', unit)
end

function static.pressedEquipmentSlot(equip_slot)
end

private.selected_unit = {}
if not IsCompiletime then
    private.local_player = GetLocalPlayer()

    private.selection_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        private.selection_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SELECTED, Player(i))
    end
    private.selection_trigger:addAction(function() 
        local player = GetTriggerPlayer()
        local unit = Unit.getInstance(GetTriggerUnit())
        private.selected_unit[player] = unit

        if player == private.local_player then
            Interface.Bag:loadBag(unit.Bag)
        end
    end)
end

return static