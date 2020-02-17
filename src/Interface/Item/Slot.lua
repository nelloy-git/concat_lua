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
---@type InterfaceItemSlotSyncClass
local SyncEvent = require('Interface.Item.SlotSync')

--=======
-- Class
--=======

local InterfaceItemSlot = Class.new('InterfaceItemSlot', SimpleFrame)
---@class InterfaceItemSlot : SimpleFrame
local public = InterfaceItemSlot.public
---@class InterfaceItemSlotClass : SimpleFrameClass
local static = InterfaceItemSlot.static
---@type InterfaceItemSlotClass
local override = InterfaceItemSlot.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceItemSlot | nil
---@return InterfaceItemSlot
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceItemSlot)
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

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.border_ratio = 1 / 16

private.background_type = SimpleFrameType.new('InterfaceItemSlotSlotBackground', true)
private.background_type:setWidth(0.035)
private.background_type:setHeight(0.035)
private.background_type:setTexture(Import.Icon.Empty)

private.border_type = SimpleFrameType.new('InterfaceEquipmentSlotBorder', true)
private.border_type:setWidth(0.040)
private.border_type:setHeight(0.040)
private.border_type:setTexture(Import.Icon.SlotBorder)

private.icon_type = SimpleButtonType.new('InterfaceItemSlotSlotIcon', true)
private.icon_type:setWidth(0.035)
private.icon_type:setHeight(0.035)
private.icon_type:setTexture('')

---@param self InterfaceItemSlot
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

---@param self InterfaceItemSlot
function private.newData(self)
    local priv = {
        border = SimpleFrame.new(private.border_type),
        icon = SimpleButton.new(private.icon_type),
        item = nil,
    }
    private.data[self] = priv

    priv.border:setParent(self)
    priv.border:setLevel(self:getLevel() + 2)

    priv.icon:setParent(self)
    priv.icon:setVisible(false)
    priv.icon:setLevel(self:getLevel() + 4)
    priv.icon:addAction(SimpleButton.ActionType.MousePress, SyncEvent.startSync)
end


return static