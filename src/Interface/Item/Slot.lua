--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local Frame = FrameAPI.Frame
local FramePublic = Class.getPublic(FrameAPI.Frame)
local SimpleEvent = FrameAPI.SimpleEvent
local SimpleEmpty = FrameAPI.SimpleEmpty
---@type InterfaceItemSlotSyncClass
local SyncEvent = require('Interface.Item.SlotSync')
---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type ActionClass
local Action = require('Utils.Action')

--local SlotType = require('Interface.Item.SlotType')

require('Interface.Frame.Button')

--=======
-- Class
--=======

local InterfaceItemSlot = Class.new('InterfaceItemSlot', Frame)
---@class InterfaceItemSlot : Frame
local public = InterfaceItemSlot.public
---@class InterfaceItemSlotClass : FrameClass
local static = InterfaceItemSlot.static
---@type InterfaceItemSlotClass
local override = InterfaceItemSlot.override
local private = {}

--=========
-- Static
--=========

---@alias InterfaceItemSlotActionEnum number

---@table <string, number>
static.ActionType = {}
---@type InterfaceItemSlotActionEnum
static.ActionType.OnMouseDown = 1
---@type InterfaceItemSlotActionEnum
static.ActionType.OnMouseUp = 2

---@param child_instance InterfaceItemSlot | nil
---@return InterfaceItemSlot
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceItemSlot)
    instance = Frame.new(SlotType.FrameType, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    --FramePublic.setWidth(self, width)
    --private.update(self)
end

---@param height any number
function public:setHeight(height)
    --FramePublic.setHeight(self, height)
    --private.update(self)
end

---@param item Item | nil
function public:setItem(item)
    local priv = private.data[self]
    priv.item = item

    private.setIcon(self, item)
    private.setCount(self, item)
end

---@param tooltip Frame
function public:setTooltip(tooltip)
    local priv = private.data[self]

    if tooltip then
        priv.tooltip = tooltip:getObj()
        BlzFrameSetTooltip(priv.button, tooltip:getObj())
    else
        priv.tooltip = priv.detector
        BlzFrameSetTooltip(priv.button, priv.detector)
    end

    SimpleEvent.setMouseDetector(self, priv.tooltip)
end

---@return Item | nil
function public:getItem()
    return private.data[self].item
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.icon_ratio = 7 / 8
private.count_ratio = 1 / 4

---@param self InterfaceItemSlot
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local icon_w = width * private.icon_ratio
    local icon_h = height * private.icon_ratio
    local count_w = width * private.count_ratio
    local count_h = height * private.count_ratio

    --BlzFrameSetSize(priv.background, width, height)
    --BlzFrameSetSize(priv.button, icon_w, icon_h )
    --BlzFrameSetSize(priv.icon, icon_w, icon_h)
    --BlzFrameSetSize(priv.count, count_w, count_h)
    --BlzFrameSetSize(priv.count_icon, count_w, count_h)
end

---@param self InterfaceItemSlot
---@param item Item
function private.setIcon(self, item)
    local priv = private.data[self]

    if item then
        BlzFrameSetVisible(priv.button, true)
        BlzFrameSetTexture(priv.icon, item:getIcon())
    else
        BlzFrameSetVisible(priv.button, false)
    end
end

---@param self InterfaceItemSlot
---@param item Item
function private.setCount(self, item)
    local priv = private.data[self]
    local count = 1
    if item then
        count = item:getCount()
    end

    if count > 1 then
        BlzFrameSetVisible(priv.count, true)
        BlzFrameSetVisible(priv.count_icon, true)
        BlzFrameSetText(priv.count, string.format('%d', count))
    else
        BlzFrameSetVisible(priv.count, false)
        BlzFrameSetVisible(priv.count_icon, false)
    end
end

---@param self InterfaceItemSlot
function private.newData(self)
    local priv = {
        background = BlzGetFrameByName(SlotType.backgroundName, 0),
        button = BlzGetFrameByName(SlotType.buttonName, 0),
        icon = BlzGetFrameByName(SlotType.iconName, 0),
        count = BlzGetFrameByName(SlotType.countName, 0),
        count_icon = BlzGetFrameByName(SlotType.countBackgroundName, 0),

        detector = BlzCreateSimpleFrame(SimpleEmpty:getName(), nil, 0),
        tooltip = nil,

        item = nil
    }
    priv.tooltip = priv.detector
    private.data[self] = priv

    BlzFrameSetVisible(priv.tooltip, false)
    BlzFrameSetTooltip(priv.button, priv.tooltip)

    local trigger = Trigger.new()
    trigger:addFrameEvent(priv.button, FRAMEEVENT_CONTROL_CLICK)
    trigger:addAction(function() print('Control click.') end)
    --BlzFrameSetVisible(priv.button, true)
    --BlzFrameSetVisible(priv.count, false)
    --BlzFrameSetVisible(priv.count_icon, false)

    SimpleEvent.setMouseDetector(self, priv.tooltip)
    SimpleEvent.addAction(SimpleEvent.Type.OnMousePress, self, SyncEvent.startSync)
end

return static