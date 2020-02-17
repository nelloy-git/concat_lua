--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type ItemAPI
local ItemAPI = require('Item.API')
local ItemType = ItemAPI.ItemType
---@type InterfaceEquipmentSlotClass
local ItemSlot = require('Interface.Equipment.EquipmentSlot')

--=======
-- Class
--=======

local InterfaceEquipment = Class.new('InterfaceEquipment', SimpleFrame)
---@class InterfaceEquipment
local public = InterfaceEquipment.public
---@class InterfaceEquipmentClass
local static = InterfaceEquipment.static
---@type InterfaceEquipmentClass
local override = InterfaceEquipment.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceEquipment | nil
---@return InterfaceEquipment
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceEquipment)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance)

    return instance
end

--static.addBagSlotPressedAction = SyncEvent.addBagSlotPressedAction
--static.removeBagSlotPressedAction = SyncEvent.removeBagSlotPressedAction

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    FramePublic.setWidth(self, width)
    private.update(self)
end

---@param height number
function public:setHeight(height)
    FramePublic.setHeight(self, height)
    private.update(self)
end

---@param unit_equip UnitInventoryEquipment | nil
function public:loadEquipment(unit_equip)
    local priv = private.data[self]
    priv.loaded_equip = unit_equip

    if not unit_equip then
        for item_type, _ in pairs(private.AvailableSlotTypes) do
            priv.slot[item_type]:setItem(nil)
        end
        return
    end

    for item_type, _ in pairs(private.AvailableSlotTypes) do
        priv.slot[item_type]:setItem(unit_equip:get(item_type))
    end
end

---@return UnitInventoryBag | nil
function public:getLoadedEquip()
    return private.data[self].loaded_equip
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.background_type = SimpleFrameType.new('InterfaceEquipmentBackground', true)
private.background_type:setWidth(0.2)
private.background_type:setWidth(0.4)
private.background_type:setTexture(Import.InventoryBackground)

private.empty_icon = Import.TransparentTexture
private.icon_background_texture = Import.Icon.Empty

private.border_ratio = 1/16
private.space_ratio = 1/32
--private.tooltip_width = 0.2

private.AvailableSlotTypes = {
    [ItemType.BAG] = true,
    [ItemType.BELT] = true,
    [ItemType.BOOTS] = true,
    [ItemType.CHEST] = true,
    [ItemType.EARRING] = true,
    [ItemType.HANDS] = true,
    [ItemType.HEAD] = true,
    [ItemType.LEGS] = true,
    [ItemType.WEAPON] = true,
    [ItemType.NECKLACE] = true,
    [ItemType.RING] = true,
    [ItemType.OFFHAND] = true,
    [ItemType.SHOULDERS] = true,
}

private.AvailableSlotIcon = {
    [ItemType.BAG] = Import.Icon.Bag,
    [ItemType.BELT] = Import.Icon.Belt,
    [ItemType.BOOTS] = Import.Icon.Boots,
    [ItemType.CHEST] = Import.Icon.Chest,
    [ItemType.EARRING] = Import.Icon.Earring,
    [ItemType.HANDS] = Import.Icon.Hands,
    [ItemType.HEAD] = Import.Icon.Head,
    [ItemType.LEGS] = Import.Icon.Legs,
    [ItemType.WEAPON] = Import.Icon.Weapon,
    [ItemType.NECKLACE] = Import.Icon.Necklace,
    [ItemType.RING] = Import.Icon.Ring,
    [ItemType.OFFHAND] = Import.Icon.Offhand,
    [ItemType.SHOULDERS] = Import.Icon.Shoulders,
}

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

---@param self InterfaceEquipment
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = private.border_ratio * width
    local border_y = private.border_ratio * height
    local space_x = private.space_ratio * width
    local space_y = private.space_ratio * height
    local slot_width = (width - 2 * border_x - 2 * space_x) / 3
    local slot_height = (height - 2 * border_y - 4 * space_y) / 5

    for item_type,_ in pairs(private.AvailableSlotTypes) do
        local slot = priv.slot[item_type]
        slot:setX(border_x + private.SlotCol[item_type] * (slot_width + space_x))
        slot:setY(border_y + private.SlotRow[item_type] * (slot_height + space_y))
        slot:setWidth(slot_width)
        slot:setHeight(slot_height)
    end
end

---@param self InterfaceEquipment
function private.newData(self)
    local priv = {
        loaded_equip = nil,

        slot = {},
        tooltip = {},
        item = {}
    }
    private.data[self] = priv

    for item_type, icon in pairs(private.AvailableSlotIcon) do
        priv.slot[item_type] = ItemSlot.new(self, icon)
        priv.slot[item_type]:setParent(self)
    end
end


return static