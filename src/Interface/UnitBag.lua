--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type ItemFrameClass
local ItemFrame = require('Item.Frame')
---@type ItemTooltipClass
local ItemTooltip = require('Item.Tooltip')

--=======
-- Class
--=======

local InterfaceUnitBag = Class.new('InterfaceUnitBag', SimpleFrame)
---@class InterfaceUnitBag
local public = InterfaceUnitBag.public
---@class InterfaceUnitBagClass
local static = InterfaceUnitBag.static
---@type InterfaceUnitBagClass
local override = InterfaceUnitBag.override
local private = {}

--=========
-- Static
--=========

---@param cols number
---@param rows number
---@param child_instance InterfaceUnitBag | nil
---@return InterfaceUnitBag
function override.new(cols, rows, child_instance)
    local instance = child_instance or Class.allocate(InterfaceUnitBag)
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

    local unit_bag_size = unit_bag:getSize()
    if unit_bag_size > priv.size then
        Log.error(self, 'unit\'s bag is too large for loading.', 2)
    end

    for i = 1, unit_bag_size do
        private.loadItem(unit_bag:get(i), priv.slot[i], priv.tooltip[i])
    end

    for i = unit_bag_size + 1, priv.size do
        priv.slot[i]:setItemIcon(nil)
        priv.slot[i]:setTexture(private.empty_icon)
    end
end

---@return number
function public:getSize()
    return private.data[self].size
end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.background_type = SimpleFrameType.new('InterfaceUnitBagBackground')
private.background_type:setTexture('war3mapImported\\Icons\\Inventory\\Background.tga')

private.empty_icon = 'war3mapImported\\Icons\\Transparent32x32.tga'
private.icon_background_texture = 'war3mapImported\\Icons\\Inventory\\EmptyBag.tga'

private.border_ratio = 1/16
private.space = 0.005
private.tooltip_width = 0.2

---@param self InterfaceUnitBag
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
---@param slot InterfaceItem
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

---@param self InterfaceUnitBag
function private.newData(self, cols, rows)
    local priv = {
        cols = cols,
        rows = rows,
        size = cols * rows,

        slot = {},
        tooltip = {}
    }
    private.data[self] = priv

    for x = 1, cols do
        for y = 1, rows do
            local pos = private.getPos(x, y, cols)
            priv.slot[pos] = ItemFrame.new()
            priv.slot[pos]:setParent(self)

            priv.tooltip[pos] = ItemTooltip.new()
            priv.tooltip[pos]:setParent(self)

            priv.slot[pos]:setTooltip(priv.tooltip[pos])
        end
    end
end


return static