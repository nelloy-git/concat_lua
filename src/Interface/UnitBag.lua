--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleFramePublic = Class.getPublic(SimpleFrame)
---@type InterfaceItemClass
local Item = require('Interface.Item')
---@type InterfaceItemTooltipClass
local ItemTooltip = require('Interface.ItemTooltip')

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

private.offset_ratio = 1/16
private.border = 0.005
private.tooltip_width = 0.2

---@param item Item
---@param slot InterfaceItem
---@param tooltip InterfaceItemTooltip
function private.loadItem(item, slot, tooltip)
    if not item then
        slot:setItemIcon(nil)
        slot:setTexture(private.icon_background_texture)
    end

    slot:setItemIcon(item:getIcon())
    tooltip:setTitle(item:getName())
    print('here')
    tooltip:setDescription(item:getDescription())
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

    local slot_size = Item.getDefaultSize()
    local slots_width = cols * (slot_size + private.border) - private.border
    local slots_height = rows * (slot_size + private.border) - private.border
    local offset_x = slots_width * private.offset_ratio
    local offset_y = slots_height * private.offset_ratio

    for x = 1, cols do
        for y = 1, rows do
            local pos = private.getPos(x, y, cols)
            local item = Item.new()
            item:setParent(self)
            item:setX(offset_x + (x - 1) * (item:getWidth() + private.border))
            item:setY(offset_y + (y - 1) * (item:getHeight() + private.border))

            local tooltip = ItemTooltip.new()
            tooltip:setParent(self)
            tooltip:setX(-private.tooltip_width)
            tooltip:setY(0)
            tooltip:setWidth(private.tooltip_width)
            tooltip:setHeight(2 * offset_y + slots_height)

            item:setTooltip(tooltip)

            priv.slot[pos] = item
            priv.tooltip[pos] = tooltip
        end
    end

    self:setWidth(2 * offset_x + slots_width)
    self:setHeight(2 * offset_y + slots_height)
end


return static