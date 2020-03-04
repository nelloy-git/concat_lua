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
local SimpleButton = FrameAPI.SimpleButton
local BtnActionType = FrameAPI.SimpleButtonEvent
local FramePublic = Class.getPublic(FrameAPI.Frame)

--=======
-- Class
--=======

local InterfaceFrameBag = Class.new('InterfaceFrameBag', SimpleButton)
---@class InterfaceFrameBag : SimpleButton
local public = InterfaceFrameBag.public
---@class InterfaceFrameBagClass : SimpleButtonClass
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
    instance = SimpleButton.new(instance)
    instance:setTexture(nil)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Autosizing frame. Disabled function
---@param width number
---@param height number
function public:setSize(width, height)
    Log(Log.Wrn, self, 'Autosizing frame. Disabled function.', 2)
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
        priv.slot[i]:setVisible(true)
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

    if not priv.unit_bag then
        return
    end

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
    private.updatePositions(self)
end

---@param level number
function public:setLevel(level)
    FramePublic.setLevel(self, level)
    for _, slot in pairs(private.data[self].slot) do
        slot:setLevel(level + 1)
    end
end

---@return number
function public:getMaxSize()
    return private.data[self].max_size
end

--- Async
---@param event SimpleButtonEvent
---@param callback InterfaceFrameBagCallback
---@return Action | nil
function public:addAction(event, callback)
    return private.data[self].actions[event]:add(callback)
end

--- Async
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

private.max_bag_size = 20
private.slot_count = 'BOTTOMRIGHT'
private.border_ratio = 1/32
private.space = 0.001
private.slot_size = Button.getDefaultSize()

---@param self InterfaceFrameBag
function private.updatePositions(self)
    local priv = private.data[self]

    local size = priv.size
    local cols = priv.cols
    local rows, frac = math.modf(size / cols)
    rows = frac ~= 0 and rows + 1 or rows
    local slot_size = private.slot_size
    local slots_width = slot_size * cols + (math.max(0, cols - 1)) * private.space
    local slots_height = slot_size * rows + (math.max(0, rows - 1)) * private.space
    local width = slots_width / (1 - 2 * private.border_ratio)
    local height = slots_height / (1 - 2 * private.border_ratio)
    local border_x = private.border_ratio * width
    local border_y = private.border_ratio * height

    FramePublic.setSize(self, width, height)
    self:setLevel(self:getLevel())

    local i = 0
    for y = 1, rows do
        for x = 1, cols do
            i = i + 1
            priv.slot[i]:setPoint(FRAMEPOINT_BOTTOMRIGHT, FRAMEPOINT_BOTTOMRIGHT,
                                  -(border_x + (x - 1) * (slot_size + private.space)),
                                  border_y + (y - 1) * (slot_size + private.space))

        end
    end

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
        size = 10,
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
        slot:setVisible(false)

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