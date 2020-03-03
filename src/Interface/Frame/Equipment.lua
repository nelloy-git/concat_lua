--=========
-- Include
--=========

local Class = require('Utils.Class.Class')


---@type ActionListClass
local ActionList = require('Utils.ActionList')
---@type InterfaceFrameButtonClass
local Button = require('Interface.Frame.Button')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleImage = FrameAPI.SimpleImage
local BtnActionType = FrameAPI.SimpleButtonEvent
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type ItemAPI
local ItemAPI = require('Item.API')
local ItemType = ItemAPI.ItemType
local getItemTypeIcon = ItemAPI.getTypeIcon

--=======
-- Class
--=======

local InterfaceFrameEquipment = Class.new('InterfaceFrameEquipment', SimpleImage)
---@class InterfaceFrameEquipment
local public = InterfaceFrameEquipment.public
---@class InterfaceFrameEquipmentClass
local static = InterfaceFrameEquipment.static
---@type InterfaceFrameEquipmentClass
local override = InterfaceFrameEquipment.override
local private = {}

--=========
-- Static
--=========

---@alias InterfaceFrameEquipmentCallback fun(instance:InterfaceFrameEquipment, item_type:ItemTypeEnum, player:player, button:mousebuttontype, event:SimpleButtonEvent)

---@param child_instance InterfaceFrameEquipment | nil
---@return InterfaceFrameEquipment
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceFrameEquipment)
    instance = SimpleImage.new(instance)
    instance:setTexture(nil)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param unit_equip UnitInventoryEquipment
function public:setUnitEquipment(unit_equip)
    local priv = private.data[self]
    priv.unit_equip = unit_equip

    if not unit_equip then
        Log.error(self, 'got nil.', 2)
    end

    for _, item_type in pairs(ItemType) do
        if ItemAPI.isTypeEquipable(item_type) then
            private.setItemSlot(self, item_type, unit_equip:get(item_type))
        end
    end
end

--- Use item_type = nil for updating all slots.
---@param item_type ItemTypeEnum
function public:updateSlot(item_type)
    local priv = private.data[self]

    if not priv.unit_equip then
        return
    end

    if item_type then
        private.setItemSlot(self, item_type, priv.unit_equip:get(item_type))
        return
    end

    for _, it_type in pairs(ItemType) do
        if ItemAPI.isTypeEquipable(it_type) then
            private.setItemSlot(self, it_type, priv.unit_equip:get(it_type))
        end
    end
end

---@param level number
function public:setLevel(level)
    FramePublic.setLevel(self, level)
    for _, slot in pairs(private.data[self].slot) do
        slot:setLevel(level + 1)
    end
end

--- Async
---@param event SimpleButtonEvent
---@param callback InterfaceFrameEquipmentCallback
---@return Action | nil
function public:addAction(event, callback)
    return private.data[self].actions[event]:add(callback)
end

--- Async
---@param event SimpleButtonEvent
---@param action Action
---@return boolean
function public:removeAction(event, action)
    return private.data[self].actions[event]:remove(action)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.border_ratio = 1/32
private.space = 0.001
private.slot_size = Button.getDefaultSize()

private.SlotCol = {
    [ItemType.BAG] = 2,
    [ItemType.BELT] = 1,
    [ItemType.BOOTS] = 1,
    [ItemType.CHEST] = 1,
    [ItemType.EARRING] = 2,
    [ItemType.HANDS] = 0,
    [ItemType.HEAD] = 1,
    [ItemType.LEGS] = 1,
    [ItemType.WEAPON] = 0,
    [ItemType.NECKLACE] = 2,
    [ItemType.RING] = 2,
    [ItemType.OFFHAND] = 2,
    [ItemType.SHOULDERS] = 0,
}

private.SlotRow = {
    [ItemType.BAG] = 0,
    [ItemType.BELT] = 2,
    [ItemType.BOOTS] = 0,
    [ItemType.CHEST] = 3,
    [ItemType.EARRING] = 4,
    [ItemType.HANDS] = 2,
    [ItemType.HEAD] = 4,
    [ItemType.LEGS] = 1,
    [ItemType.WEAPON] = 1,
    [ItemType.NECKLACE] = 3,
    [ItemType.RING] = 2,
    [ItemType.OFFHAND] = 1,
    [ItemType.SHOULDERS] = 3,
}

---@param self InterfaceFrameEquipment
function private.updatePositions(self)
    local priv = private.data[self]

    local cols = 3
    local rows = 5
    local slot_size = private.slot_size
    local slots_width = slot_size * cols + (math.max(0, cols - 1)) * private.space
    local slots_height = slot_size * rows + (math.max(0, rows - 1)) * private.space
    local width = slots_width / (1 - 2 * private.border_ratio)
    local height = slots_height / (1 - 2 * private.border_ratio)
    local border_x = private.border_ratio * width
    local border_y = private.border_ratio * height

    FramePublic.setSize(self, width, height)
    self:setLevel(self:getLevel())

    for _, item_type in pairs(ItemType) do
        if ItemAPI.isTypeEquipable(item_type) then
            priv.slot[item_type]:setPoint(FRAMEPOINT_BOTTOMLEFT, FRAMEPOINT_BOTTOMLEFT,
                                          border_x + private.SlotCol[item_type] * (slot_size + private.space),
                                          border_y + private.SlotRow[item_type] * (slot_size + private.space))
        end
    end
end

---@param self InterfaceFrameEquipment
---@param item_type ItemTypeEnum
---@param item Item
function private.setItemSlot(self, item_type, item)
    local slot = private.data[self].slot[item_type]

    local icon = getItemTypeIcon(item_type)
    local progress
    if item then
        icon = item:getIcon()
        progress = item:getProgress()
    end

    slot:setIcon(icon)
    slot:setProgress(progress)
end

---@param self InterfaceFrameEquipment
function private.newData(self)
    local priv = {
        unit_equip = nil,
        slot = {},

        actions = {}
    }
    private.data[self] = priv

    for _, event in pairs(BtnActionType) do
        priv.actions[event] = ActionList.new()
    end

    for _, item_type in pairs(ItemType) do
        if ItemAPI.isTypeEquipable(item_type) then
            local slot = Button.new()
            slot:setParent(self)
            slot:setIcon(getItemTypeIcon(item_type))

            for _, event in pairs(BtnActionType) do
                slot:addAction(event, function (slot, player, btn, event)
                    priv.actions[event]:run(self, item_type, player, btn, event)
                end)
            end

            for j = 1, #Button.cornerName do
                slot:setCornerText(Button.cornerName[j], nil)
            end

            priv.slot[item_type] = slot
        end
    end

    private.updatePositions(self)
end


return static