--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type UnitInventoryBagClass
local UnitInventoryBag = require('Unit.Inventory.Bag')
---@type ItemAPI
local ItemAPI = require('Item.API')

--=======
-- Class
--=======

local UnitInvetoryEvent = Class.new('UnitInvetoryEvent')
---@class UnitInvetoryEvent
local public = UnitInvetoryEvent.public
---@class UnitInvetoryEventClass
local static = UnitInvetoryEvent.static
---@type UnitInvetoryEventClass
local override = UnitInvetoryEvent.override
local private = {}

--=========
-- Static
--=========

---@param child_instance UnitInvetoryEvent | nil
---@return UnitInvetoryEvent
function static.new(child_instance)
    local instance = child_instance or Class.allocate(UnitInvetoryEvent)
    private.newData(instance)

    return instance
end

--========
-- Public
--========



--=========
-- Private
--=========

function private.puckUpAction()
    local item = ItemAPI.getItem(GetManipulatedItem())
    local bag = UnitInventoryBag.getByOwner(GetManipulatingUnit())

    local item_x = item:getModelX()
    local item_y = item:getModelY()
    item:destroyModel()

    if not bag then
        item:placeModel(item_x, item_y)
        return
    end

    local empty_pos = bag:getEmpty()
    if not empty_pos then
        item:placeModel(item_x, item_y)
        return
    end

    bag:set(item, empty_pos)
end

if not IsCompiletime() then
    private.pick_up_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        private.pick_up_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_PICKUP_ITEM, Player(i))
    end
    private.pick_up_trigger:addAction(private.puckUpAction)
end



return static