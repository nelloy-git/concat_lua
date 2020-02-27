--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local Frame = FrameAPI.Frame
local FramePublic = Class.getPublic(FrameAPI.Frame)
local SimpleEmpty = FrameAPI.SimpleEmpty
---@type InterfaceItemSlotSyncClass
local SyncEvent = require('Interface.Item.SlotSync')
---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type ActionClass
local Action = require('Utils.Action')

local SlotType = require('Interface.Item.SlotType')

--=======
-- Class
--=======

local InterfaceItemSlot = Class.new('InterfaceItemSlot', Frame)
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

---@param action_type InterfaceItemSlotActionEnum
---@param callback Callback
---@return Action | nil
function public:addAction(action_type, callback)
    local priv = private.data[self]
    local action = Action.new(callback, self)
    table.insert(priv.actions[action_type], action)

    return action
end

---@param action Action
---@return boolean
function public:removeAction(action_type, action)
    local priv = private.data[self]
    if not priv.trigger then
        Log.error(self, 'can not remove action from empty trigger.', 2)
    end

    local res = priv.trigger:removeAction(action)
    if priv.trigger:countActions() <= 0 then
        priv.trigger:destroy()
        priv.trigger = nil
    end

    return res
end

---@param tooltip Frame
function public:setTooltip(tooltip)
    local priv = private.data[self]

    if tooltip then
        priv.tooltip = tooltip:getObj()
        BlzFrameSetTooltip(priv.button, tooltip:getObj())
    else
        priv.tooltip = priv.detector
        BlzFrameSetTooltip(priv.button, priv.detector:getObj())
    end
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

    BlzFrameSetSize(priv.background, width, height)
    BlzFrameSetSize(priv.icon, icon_w, icon_h)
    BlzFrameSetSize(priv.count, count_w, count_h)
    BlzFrameSetSize(priv.count_icon, count_w, count_h)
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

        trigger = nil,
    }
    priv.tooltip = priv.detector
    BlzFrameSetText(priv.count, '5')

    private.data[self] = priv
end

function private.mouseDownCallback()
    local player = GetTriggerPlayer()
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for instance, priv in pairs(private.data) do
        if priv.tooltip:isVisible() then
            local actions = priv.actions[static.ActionType.MouseDown]
            for i = 1, #actions do
                actions[i]:run(instance, player, mouse_btn)
            end

            priv.got_left_mouse_btn = is_left
            priv.got_right_mouse_btn = is_right
        end
    end
end

function private.mouseUpCallback()
    local player = GetTriggerPlayer()
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for instance, priv in pairs(private.data) do
        if priv.tooltip:isVisible() then
            local actions = priv.actions[static.ActionType.MouseDown]
            for i = 1, #actions do
                actions[i]:run(instance, player, mouse_btn)
            end

            if (priv.got_left_mouse_btn and is_left) or (priv.got_right_mouse_btn and is_right) then
                actions = priv.actions[static.ActionType.MousePress]
                for i = 1, #actions do
                    actions[i]:run(instance, player, mouse_btn)
                end
            end
        end

        priv.got_left_mouse_btn = not is_left
        priv.got_right_mouse_btn = not is_right
    end
end

if not IsCompiletime() then
    --private.trigger_mouse_down = Trigger.new()
    --private.trigger_mouse_up = Trigger.new()
    --for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
    --    private.trigger_mouse_down:addPlayerEvent(EVENT_PLAYER_MOUSE_DOWN, Player(i))
    --    private.trigger_mouse_up:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, Player(i))
    --end
    --private.trigger_mouse_down:addAction(private.mouseDownCallback)
    --private.trigger_mouse_up:addAction(private.mouseUpCallback)
end

return static