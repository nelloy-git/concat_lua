--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleImage = FrameAPI.SimpleImage
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type InterfaceFrameButtonClass
local Button = require('Interface.Item.Slot')
---@type InterfaceItemTooltipClass
local ItemTooltip = require('Interface.Item.Tooltip')

--=======
-- Class
--=======

local InterfaceInventoryBag = Class.new('InterfaceInventoryBag', SimpleImage)
---@class InterfaceInventoryBag
local public = InterfaceInventoryBag.public
---@class InterfaceInventoryBagClass
local static = InterfaceInventoryBag.static
---@type InterfaceInventoryBagClass
local override = InterfaceInventoryBag.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceInventoryBag | nil
---@return InterfaceInventoryBag
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceInventoryBag)
    instance = SimpleImage.new(instance)
    instance:setTexture('ui\\console\\human\\human-transport-slot.dds')

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
end

---@param height number
function public:setHeight(height)
end

function public:setColumns(cols)
    private.data[self].cols = cols
    self:update()
end

---@param unit Unit | nil
function public:load(unit)
    local priv = private.data[self]
    priv.loaded = unit

    if not unit then
        for i = 1, priv.size do
            priv.slot[i]:setVisible(false)
        end
        return
    end

    local unit_bag = unit:getBag()
    local bag_size = unit_bag:getSize()
    if bag_size > priv.size then
        Log.error(self, 'unitd\'s bag is too large.', 2)
    end

    for i = 1, bag_size do
        local item = unit_bag:get(i)

        priv.slot[i]:setItem(item)
        priv.slot[i]:setVisible(true)
        priv.tooltip[i]:setItem(item, unit)
    end

    for i = bag_size + 1, priv.size do
        priv.slot[i]:setVisible(false)
    end
end

---@return Unit
function public:getLoaded()
    return private.data[self].loaded
end

---@return number
function public:getSize()
    return private.data[self].size
end

function public:update()
    local priv = private.data[self]
    local size = priv.loaded:getBag():getSize()
    local cols = priv.cols
    local rows = math.ceil(size / cols)
    local slot_size = priv.slot[1]:getWidth()
    local width = (slot_size * cols + (cols - 1) * private.space) / (1 - 2 * private.border_ratio)
    local height = (slot_size * rows + (rows - 1) * private.space) / (1 - 2 * private.border_ratio)
    local border_x = private.border_ratio * width
    local border_y = private.border_ratio * height

    local i = 0
    for x = 1, cols do
        for y = 1, rows do
            i = i + 1

            local slot = priv.slot[i]
            slot:setPoint(FRAMEPOINT_TOPLEFT, FRAMEPOINT_TOPLEFT,
                          border_x + (x - 1) * (slot_size + private.space),
                          height - border_y - (y - 1) * (slot_size + private.space))
        end
    end

    FramePublic.setWidth()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.slot_count = 'BOTTOMRIGHT'
private.border_ratio = 1 / 16
private.space = 0.005

---@param self InterfaceInventoryBag
function private.newData(self)
    local priv = {
        loaded = nil,
        cols = 5,
        max_size = 40,

        slot = {},
        slot_count = {},
        --tooltip = {}
    }
    private.data[self] = priv

    for i = 1, priv.size do
        local slot = Button.new()
        slot:setParent(self)

        for j = 1, #Button.cornerName do
            slot:setCornerText(Button.cornerName[j], nil)
        end

        priv.slot[i] = slot

        --priv.tooltip[i] = ItemTooltip.new()
        --priv.tooltip[i]:setParent(self)

        --priv.slot[i]:setTooltip(priv.tooltip[i])
    end
end


return static