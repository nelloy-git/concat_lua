--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ActionListClass
local ActionList = require('Utils.ActionList')
---@type InterfaceFrameButtonClass
local Button = require('Interface.Frame.Button')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleImage = FrameAPI.SimpleImage
local BtnActionType = FrameAPI.SimpleButtonEvent
local FramePublic = Class.getPublic(FrameAPI.Frame)

--=======
-- Class
--=======

local InterfaceFrameBag = Class.new('InterfaceFrameBag', SimpleImage)
---@class InterfaceFrameBag : SimpleImage
local public = InterfaceFrameBag.public
---@class InterfaceFrameBagClass : SimpleImageClass
local static = InterfaceFrameBag.static
---@type InterfaceFrameBagClass
local override = InterfaceFrameBag.override
local private = {}

--=========
-- Static
--=========

---@alias InterfaceFrameBagCallback fun(instance:InterfaceFrameBag, pos:number, player:player, button:mousebuttontype, event:SimpleButtonEvent)

---@param child_instance InterfaceFrameBag | nil
---@return InterfaceFrameBag
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceFrameBag)
    instance = SimpleImage.new(instance)
    instance:setTexture('ui\\console\\human\\human-transport-slot.dds')

    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Disabled. Autosized frame.
---@param width number
function public:setWidth(width)
end

--- Disabled. Autosized frame.
---@param height number
function public:setHeight(height)
end

---@param unit_bag UnitInventoryBag | nil
function public:setUnitBag(unit_bag)
    local priv = private.data[self]
    priv.unit_bag = unit_bag

    if not unit_bag then
        priv.size = 0
    else
        priv.size = unit_bag:getSize()
    end

    for i = 1, priv.size do
        private.setItemSlot(self, i, unit_bag:get(i))
    end

    for i = priv.size + 1, priv.max_size do
        priv.slot[i]:setVisible(false)
    end

    private.updatePositions(self)
end

--- Use pos = nil or pos <= 0 for updating all slots.
---@param pos number
function public:updateSlot(pos)
    local priv = private.data[self]

    if pos and pos > 0 then
        private.setItemSlot(self, pos, priv.unit_bag:get(pos))
        return
    end

    for i = 1, priv.size do
        private.setItemSlot(self, i, priv.unit_bag:get(pos))
    end
end

---@param cols number
function public:setColumns(cols)
    private.data[self].cols = cols
    self:update()
end

---@return number
function public:getMaxSize()
    return private.data[self].max_size
end

---@param event SimpleButtonEvent
---@param callback InterfaceFrameBagCallback
---@return Action | nil
function public:addAction(event, callback)
    return private.data[self].actions[event]:add(callback)
end

---@param event SimpleButtonEvent
---@param action Action
---@return boolean
function public:removeAction(event, action)
    return private.data[self].actions[event]:remove(action)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.max_bag_size = 40
private.slot_count = 'BOTTOMRIGHT'
private.border_ratio = 1 / 16
private.space = 0.005
private.slot_size = Button.getDefaultSize()

---@param self InterfaceFrameBag
function private.updatePositions(self)
    local priv = private.data[self]

    local size = priv.size
    local cols = priv.cols
    local rows = math.ceil(size / cols)
    local slot_size = private.slot_size
    local slots_width = slot_size * cols + (math.min(0, cols - 1)) * private.space
    local slots_height = slot_size * rows + (math.min(0, rows - 1)) * private.space
    local width = slots_width / (1 - 2 * private.border_ratio)
    local height = slots_height / (1 - 2 * private.border_ratio)
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

    FramePublic.setWidth(self, width)
    FramePublic.setHeight(self, height)
end

---@param self InterfaceFrameBag
---@param pos number
---@param item Item
function private.setItemSlot(self, pos, item)
    local priv = private.data[self]

    if pos < 1 or pos > priv.max_size then
        Log.error(self, 'wrong item position.', 2)
    end

    local slot = priv.slot[pos]

    local icon
    local count
    local progress
    if item then
        icon = item:getIcon()
        count = item:getCount()
        progress = item:getProgress()

        if count == 1 then
            count = nil
        end
    end

    slot:setIcon(icon)
    slot:setCornerText(private.slot_count, tostring(count))
    slot:setProgress(progress)
end

---@param self InterfaceFrameBag
function private.newData(self)
    local priv = {
        cols = 5,
        size = 0,
        max_size = private.max_bag_size,

        unit_bag = nil,
        slot = {},

        actions = {}
    }
    private.data[self] = priv

    for _, event in pairs(BtnActionType) do
        priv.actions[event] = ActionList.new()
    end

    for i = 1, private.max_bag_size do
        local slot = Button.new()
        slot:setParent(self)

        for _, event in pairs(BtnActionType) do
            slot:addAction(event, function (slot, player, btn, event)
                priv.actions[event]:run(self, i, player, btn, event)
            end)
        end

        for j = 1, #Button.cornerName do
            slot:setCornerText(Button.cornerName[j], nil)
        end

        priv.slot[i] = slot
    end

    private.updatePositions(self)
end


return static