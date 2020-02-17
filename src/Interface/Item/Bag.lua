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
---@type InterfaceItemBagSlotClass
local ItemBagSlot = require('Interface.Item.BagSlot')
---@type InterfaceItemTooltipClass
local ItemTooltip = require('Interface.Item.Tooltip')

--=======
-- Class
--=======

local InterfaceItemBag = Class.new('InterfaceItemBag', SimpleFrame)
---@class InterfaceItemBag
local public = InterfaceItemBag.public
---@class InterfaceItemBagClass
local static = InterfaceItemBag.static
---@type InterfaceItemBagClass
local override = InterfaceItemBag.override
local private = {}

--=========
-- Static
--=========

---@param cols number
---@param rows number
---@param child_instance InterfaceItemBag | nil
---@return InterfaceItemBag
function override.new(cols, rows, child_instance)
    local instance = child_instance or Class.allocate(InterfaceItemBag)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance, cols, rows)

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

---@param unit_bag UnitInventoryBag
function public:loadBag(unit_bag)
    local priv = private.data[self]
    priv.loaded_bag = unit_bag

    if unit_bag and unit_bag:getSize() ~= priv.size then
        Log.error(self, 'ui bag and unit bag have different sizes.', 2)
    end

    for col = 1, priv.cols do
        for row = 1, priv.rows do
            local item
            if unit_bag then
                item = unit_bag:get(private.getPos(col, row, priv.cols))
            else
                item = nil
            end
            private.setItem(self, item, col, row)
        end
    end
end

---@return UnitInventoryBag | nil
function public:getLoadedBag()
    return private.data[self].loaded_bag
end

---@return number
function public:getSize()
    return private.data[self].size
end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.background_type = SimpleFrameType.new('InterfaceItemBagBackground', true)
private.background_type:setWidth(0.2)
private.background_type:setWidth(0.16)
private.background_type:setTexture(Import.InventoryBackground)

private.empty_icon = Import.TransparentTexture
private.icon_background_texture = Import.Icon.Empty

private.border_ratio = 1/16
private.space = 0.005
private.tooltip_width = 0.2

function private.setItem(self, item, col, row)
    local priv = private.data[self]
    local pos = private.getPos(col, row, priv.cols)

    priv.item[pos] = item
    priv.slot[pos]:setItem(item)
    priv.tooltip[pos]:setItem(item)
end

---@param self InterfaceItemBag
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = private.border_ratio * width
    local border_y = private.border_ratio * height
    local cols = priv.cols
    local rows = priv.rows
    local slot_width = (width - 2 * border_x - (cols - 1) * private.space) / cols
    local slot_height = (height - 2 * border_y - (rows - 1) * private.space) / rows


    for x = 1, priv.cols do
        for y = 1, priv.rows do
            local pos = private.getPos(x, y, priv.cols)
            local slot = priv.slot[pos]
            slot:setX(border_x + (x - 1) * (slot_width + private.space))
            slot:setY(border_y + (y - 1) * (slot_height + private.space))
            slot:setWidth(slot_width)
            slot:setHeight(slot_height)

            local tooltip = priv.tooltip[pos]
            tooltip:setX(-private.tooltip_width)
            tooltip:setY(0)
            tooltip:setWidth(private.tooltip_width)
            tooltip:setHeight(height)
        end
    end
end

---@param item Item
---@param slot InterfaceItemBagSlot
---@param tooltip InterfaceItemTooltip
function private.loadItem(item, slot, tooltip)
    if not item then
        slot:setItemIcon(nil)
        slot:setTexture(private.icon_background_texture)
        return
    end

    item.Frame = slot
    item.Tooltip = tooltip
    item:update()
end

function private.getPos(x, y, cols)
    return x + (y - 1) * cols
end

---@param self InterfaceItemBag
function private.newData(self, cols, rows)
    local priv = {
        loaded_bag = nil,
        cols = cols,
        rows = rows,
        size = cols * rows,

        slot = {},
        tooltip = {},
        item = {}
    }
    private.data[self] = priv

    for x = 1, cols do
        for y = 1, rows do
            local pos = private.getPos(x, y, cols)
            priv.slot[pos] = ItemBagSlot.new(self)
            priv.slot[pos]:setParent(self)

            priv.tooltip[pos] = ItemTooltip.new()
            priv.tooltip[pos]:setParent(self)

            priv.slot[pos]:setTooltip(priv.tooltip[pos])
        end
    end
end


return static