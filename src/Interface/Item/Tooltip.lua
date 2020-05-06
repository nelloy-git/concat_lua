--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleTextType = FrameAPI.SimpleTextType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleText = FrameAPI.SimpleText
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type ItemAPI
local ItemAPI = require('Item.API')
local ItemType = ItemAPI.ItemType
---@type InterfaceParameterTooltipClass
local ItemParamTooltip = require('Interface.Parameter.Tooltip')
---@type InterfaceItemSlotClass
local ItemSlot = require('Interface.Item.Slot')

--=======
-- Class
--=======

local InterfaceItemTooltip = Class.new('InterfaceItemTooltip', SimpleFrame)
---@class InterfaceItemTooltip : SimpleFrame
local public = InterfaceItemTooltip.public
---@class InterfaceItemTooltipClass : SimpleFrameClass
local static = InterfaceItemTooltip.static
---@type InterfaceItemTooltipClass
local override = InterfaceItemTooltip.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceItemTooltip | nil
---@return InterfaceItemTooltip
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceItemTooltip)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance)

    return instance
end

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

---@param item Item | nil
---@param unit Unit
function public:setItem(item, unit)
    local priv = private.data[self]
    priv.item = item

    if item then
        priv.title:setText(item:getName())
        priv.description:setText(item:getDescription())
        priv.icon:setTexture(private.ItemTypeIcon[item:getType()])
        priv.params:setItem(item, unit)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.border_ratio_x = 0.05
private.border_ratio_y = 0.05
private.space_ratio_x = 0.05
private.space_ratio_y = 0.05
private.icon_ratio = 0.15
private.descript_ratio = 0.15

private.background_type = SimpleFrameType.new('InterfaceItemTooltipBackground', true)
private.background_type:setTexture(Import.InventoryBackground)

private.icon_type = SimpleFrameType.new('InterfaceItemTooltipIcon', true)
private.icon_type:setTexture(Import.Icon.Empty)

private.title_type = SimpleTextType.new('InterfaceItemTooltipTitle', true)
private.title_type:setFont('fonts\\nim_____.ttf')
private.title_type:setFontSize(0.012)
private.title_type:setAnchor('CENTER')

private.description_type = SimpleTextType.new('InterfaceItemTooltipDescription', true)
private.description_type:setFont('fonts\\nim_____.ttf')
private.description_type:setFontSize(0.009)
private.description_type:setAnchor('CENTER')

private.ItemTypeIcon = {
    [ItemType.BAG] = Import.Icon.Bag,
    [ItemType.BELT] = Import.Icon.Belt,
    [ItemType.BOOTS] = Import.Icon.Boots,
    [ItemType.CHEST] = Import.Icon.Chest,
    [ItemType.EARRING] = Import.Icon.Earring,
    [ItemType.HANDS] = Import.Icon.Hands,
    [ItemType.HEAD] = Import.Icon.Head,
    [ItemType.LEGS] = Import.Icon.Legs,
    [ItemType.MISCELLANEOUS] = Import.Icon.Miscellaneous,
    [ItemType.NECKLACE] = Import.Icon.Necklace,
    [ItemType.OFFHAND] = Import.Icon.Offhand,
    [ItemType.USABLE] = Import.Icon.Usable,
    [ItemType.RING] = Import.Icon.Ring,
    [ItemType.SHOULDERS] = Import.Icon.Shoulders,
    [ItemType.WEAPON] = Import.Icon.Weapon,
}

---@param self InterfaceItemTooltip
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = private.border_ratio_x * width
    local border_y = private.border_ratio_y * height
    local space_x = private.space_ratio_x * width
    local space_y = private.space_ratio_y * width
    local icon_size = private.icon_ratio * width
    local descr_height = private.descript_ratio * height

    -- Icon
    priv.icon:setX(border_x)
    priv.icon:setY(height - border_y - icon_size)
    priv.icon:setWidth(icon_size)
    priv.icon:setHeight(icon_size)

    -- Title
    priv.title:setX(border_x + icon_size + space_x)
    priv.title:setY(height - border_y - icon_size)
    priv.title:setWidth(width - 2 * border_x - space_x - icon_size)
    priv.title:setHeight(icon_size)

    -- Description
    priv.description:setX(border_x)
    priv.description:setY(height - border_y - icon_size - space_y - descr_height)
    priv.description:setWidth(width - 2 * border_x)
    priv.description:setHeight(descr_height)

    -- Parameters
    priv.params:setX(border_x)
    priv.params:setY(border_y)
    priv.params:setWidth(width - 2 * border_x)
    priv.params:setHeight(height - 2 * border_y - icon_size - 2 * space_y - descr_height)
end

---@param self InterfaceItemTooltip
function private.newData(self)
    local priv = {
        icon = ItemSlot.new(),
        title = SimpleText.new(private.title_type),
        description = SimpleText.new(private.description_type),
        params = ItemParamTooltip.new(7),

        item = nil
    }
    private.data[self] = priv

    priv.icon:setParent(self)

    priv.title:setParent(self)
    priv.title:setText('Title')

    priv.description:setParent(self)
    priv.description:setText('Description')

    priv.params:setParent(self)
end


return static