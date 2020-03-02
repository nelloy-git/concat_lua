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
---@type Import
local Import = require('Resources.Import')
---@type ItemAPI
local ItemAPI = require('Item.API')
local ItemType = ItemAPI.ItemType
local getItemTypeIcon = ItemAPI.getTypeIcon

--=======
-- Class
--=======

local InterfaceInventoryEquipment = Class.new('InterfaceInventoryEquipment', SimpleImage)
---@class InterfaceInventoryEquipment
local public = InterfaceInventoryEquipment.public
---@class InterfaceInventoryEquipmentClass
local static = InterfaceInventoryEquipment.static
---@type InterfaceInventoryEquipmentClass
local override = InterfaceInventoryEquipment.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceInventoryEquipment | nil
---@return InterfaceInventoryEquipment
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceInventoryEquipment)
    instance = SimpleImage.new(instance)
    instance:setTexture('ui\\console\\human\\human-transport-slot.dds')

    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Disabled. Autosized frame.
---@param width number
function public:setWidth(width)
end

--- Disabled. Autosized frame.
---@param height number
function public:setHeight(height)
end

---@param unit_equip UnitInventoryEquipment | nil
function public:setUnitEquipment(unit_equip)
    local priv = private.data[self]
    priv.unit_equio = unit_equip

    if not unit_equip then
        self:setAlpha(0)
    end

    local unit_equip = unit:getEquipment()
    for _, item_type in pairs(ItemType) do
        if ItemAPI.isTypeEquipable(item_type) then
            priv.slot[item_type]:setItem(unit_equip:get(item_type))
        end
    end
end

---@return Unit
function public:getLoaded()
    return private.data[self].loaded
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.background_type = SimpleFrameType.new('InterfaceInventoryEquipmentBackground', true)
private.background_type:setWidth(0.2)
private.background_type:setWidth(0.4)
private.background_type:setTexture(Import.InventoryBackground)

private.empty_icon = Import.TransparentTexture
private.icon_background_texture = Import.Icon.Empty

private.border_x_ratio = 1/6
private.border_y_ratio = 1/12
private.space_ratio = 1/24
private.tooltip_width = 0.2
private.tooltip_height = 0.16

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

---@param self InterfaceInventoryEquipment
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = private.border_x_ratio * width
    local border_y = private.border_y_ratio * height
    local space_x = private.space_ratio * width
    local space_y = private.space_ratio * height
    local slot_width = (width - 2 * border_x - 2 * space_x) / 3
    local slot_height = (height - 2 * border_y - 4 * space_y) / 5

    for name, item_type in pairs(ItemType) do
        if ItemAPI.isTypeEquipable(item_type) then
            local slot = priv.slot[item_type]
            slot:setX(border_x + private.SlotCol[item_type] * (slot_width + space_x))
            slot:setY(border_y + private.SlotRow[item_type] * (slot_height + space_y))
            slot:setWidth(slot_width)
            slot:setHeight(slot_height)

            local tooltip = priv.tooltip[item_type]
            tooltip:setX(-private.tooltip_width)
            tooltip:setY(height - private.tooltip_height)
            tooltip:setWidth(private.tooltip_width)
            tooltip:setHeight(height - private.tooltip_height)
        end
    end
end

---@param self InterfaceInventoryEquipment
function private.newData(self)
    local priv = {
        loaded = nil,

        slot = {},
        tooltip = {},
    }
    private.data[self] = priv

    for _, item_type in pairs(ItemType) do
        if ItemAPI.isTypeEquipable(item_type) then
            priv.slot[item_type] = ItemSlot.new()
            priv.slot[item_type]:setParent(self)
            priv.slot[item_type]:setTexture(getItemTypeIcon(item_type))

            priv.tooltip[item_type] = ItemTooltip.new()
            priv.tooltip[item_type]:setParent(self)

            priv.slot[item_type]:setTooltip(priv.tooltip[item_type])
        end
    end
end


return static