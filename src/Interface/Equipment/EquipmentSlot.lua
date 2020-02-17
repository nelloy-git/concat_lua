--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleButton = FrameAPI.SimpleButton
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type InterfaceBagSyncClass
local SyncEvent = require('Interface.Bag.Sync')

--=======
-- Class
--=======

local InterfaceEquipmentSlot = Class.new('InterfaceEquipmentSlot', SimpleFrame)
---@class InterfaceEquipmentSlot : SimpleFrame
local public = InterfaceEquipmentSlot.public
---@class InterfaceEquipmentSlotClass : SimpleFrameClass
local static = InterfaceEquipmentSlot.static
---@type InterfaceEquipmentSlotClass
local override = InterfaceEquipmentSlot.override
local private = {}

--=========
-- Static
--=========

---@param equip InterfaceEquipment
---@param background string
---@param child_instance InterfaceEquipmentSlot | nil
---@return InterfaceEquipmentSlot
function override.new(equip, background, child_instance)
    local instance = child_instance or Class.allocate(InterfaceEquipmentSlot)
    instance = SimpleFrame.new(private.background_type, instance)
    instance:setTexture(background)

    private.newData(instance, equip)

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

---@param height any number
function public:setHeight(height)
    FramePublic.setHeight(self, height)
    private.update(self)
end

---@param item Item | nil
function public:setItem(item)
    local priv = private.data[self]
    priv.item = item

    if item then
        priv.icon:setTexture(item:getIcon())
        priv.icon:setVisible(true)
    else
        priv.icon:setVisible(false)
    end
end

---@param tooltip Frame
function public:setTooltip(tooltip)
    private.data[self].icon:setTooltip(tooltip)
end

---@return Item | nil
function public:getItem()
    return private.data[self].item
end

---@return InterfaceBag
function public:getBag()
    return private.data[self].bag
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.border_ratio = 1 / 16

private.background_type = SimpleFrameType.new('InterfaceEquipmentSlotBackground', true)
private.background_type:setWidth(0.040)
private.background_type:setHeight(0.040)
private.background_type:setTexture(Import.Icon.Empty)

private.border_type = SimpleFrameType.new('InterfaceEquipmentSlotBorder', true)
private.border_type:setWidth(0.040)
private.border_type:setHeight(0.040)
private.border_type:setTexture(Import.Icon.SlotBorder)

private.icon_type = SimpleButtonType.new('InterfaceEquipmentSlotIcon', true)
private.icon_type:setWidth(0.035)
private.icon_type:setHeight(0.035)
private.icon_type:setTexture('')

---@param self InterfaceEquipmentSlot
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = width * private.border_ratio
    local border_y = height * private.border_ratio

    priv.border:setWidth(width)
    priv.border:setHeight(height)

    priv.icon:setX(border_x)
    priv.icon:setY(border_y)
    priv.icon:setWidth(width - 2 * border_x)
    priv.icon:setHeight(height - 2 * border_y)
end

---@param icon SimpleButton
---@param player player
---@param mouse_button mousebuttontype
function private.mousePressCallback(icon, player, mouse_button)
    --SyncEvent.startEquipmentSlotPressedEvent(icon:getParent(), player, mouse_button)
end

---@param self InterfaceEquipmentSlot
function private.newData(self, equip)
    local border = SimpleFrame.new(private.border_type)
    local icon = SimpleButton.new(private.icon_type)
    local priv = {
        equip = equip,
        border = border,
        icon = icon,
        item = nil,
    }
    private.data[self] = priv

    border:setParent(self)

    icon:setParent(self)
    icon:setVisible(false)

    icon:addAction(SimpleButton.ActionType.MousePress, private.mousePressCallback)
end


return static