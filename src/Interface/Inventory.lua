--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type InterfaceInventoryBagClass
--local Bag = require('Interface.Inventory.Bag')
---@type InterfaceInventoryEquipmentClass
--local Equipment = require('Interface.Inventory.Equipment')
---@type InterfaceParameterTooltipClass
--local Parameters = require('Interface.Parameter.Tooltip')

--=======
-- Class
--=======

local InterfaceInventory = Class.new('InterfaceInventory', SimpleFrame)
---@class InterfaceInventory
local public = InterfaceInventory.public
---@class InterfaceInventoryClass
local static = InterfaceInventory.static
---@type InterfaceInventoryClass
local override = InterfaceInventory.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceInventory | nil
---@return InterfaceInventory
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceInventory)
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

---@param unit Unit | nil
function public:load(unit)
    local priv = private.data[self]

    priv.bag:load(unit)
    priv.equip:load(unit)
    priv.param:setUnit(unit)
end

---@return Unit
function public:getLoaded()
    return private.data[self].loaded
end

---@return number
function public:getSize()
    return private.data[self].size
end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.background_type = SimpleFrameType.new('InterfaceInventoryBackground', true)
private.background_type:setWidth(0.3)
private.background_type:setHeight(0.4)
--private.background_type:setTexture(Import.TransparentTexture)

private.empty_icon = Import.TransparentTexture
private.icon_background_texture = Import.Icon.Empty

private.space_ratio = 1 / 32

private.bag_x_ratio = 1 / 2
private.bag_y_ratio = 0
private.bag_width_ratio = 1 / 2
private.bag_height_ratio = 1 / 3

private.equip_x_ratio = 1 / 2
private.equip_y_ratio = private.bag_height_ratio
private.equip_width_ratio = 1 / 2
private.equip_height_ratio = 1 - private.bag_height_ratio

private.param_x_ratio = 0
private.param_y_ratio = 0
private.param_width_ratio = 1 - private.bag_width_ratio
private.param_height_ratio = 1

---@param self InterfaceInventory
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()

    priv.bag:setX(private.bag_x_ratio * width)
    priv.bag:setY(private.bag_y_ratio * height)
    priv.bag:setWidth(private.bag_width_ratio * width)
    priv.bag:setHeight(private.bag_height_ratio * height)

    priv.equip:setX(private.equip_x_ratio * width)
    priv.equip:setY(private.equip_y_ratio * height)
    priv.equip:setWidth(private.equip_width_ratio * width)
    priv.equip:setHeight(private.equip_height_ratio * height)

    priv.param:setX(private.param_x_ratio * width)
    priv.param:setY(private.param_y_ratio * height)
    priv.param:setWidth(private.param_width_ratio * width)
    priv.param:setHeight(private.param_height_ratio * height)
end

---@param self InterfaceInventory
function private.newData(self)
    local priv = {
        loaded = nil,

        bag = Bag.new(5, 4),
        equip = Equipment.new(),
        param = Parameters.new(20)
    }
    private.data[self] = priv

    priv.bag:setParent(self)
    priv.equip:setParent(self)
    priv.param:setParent(self)
end


return static