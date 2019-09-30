---@type Frame
local Frame = require('baseClasses.Frame.FrameData')
---@type InventorySlotFrame
local InventorySlot = require('baseClasses.Frame.Inventory.InventorySlot')

---@class ItemTooltipFrame:Frame
local ItemTooltipFrame = {
    __type = 'ItemTooltipFrame'..'Class'
}
setmetatable(ItemTooltipFrame, {__index = Frame})

local ItemTooltipFrame_meta = {
    __type = 'ItemTooltipFrame',
    __index = ItemTooltipFrame,
}

local offset_x = 0.001
local offset_y = 0.001

local icon_size_part = 0.25
local slot_size_part = 0.15

local initialized = false
function ItemTooltipFrame.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

---@param parent Frame
---@return ItemTooltipFrame
function ItemTooltipFrame.new(parent)
    local frame = Frame.new("ItemTooltipBackground", parent)
    setmetatable(frame, ItemTooltipFrame_meta)

    frame.__icon = InventorySlot.new(frame)
    frame.__slots = {}
    frame.__title = Frame.new("ParameterTooltipTitle", frame)
    frame.__text = Frame.new("ParameterTooltipText", frame)

    frame:update()
    return frame
end

function ItemTooltipFrame:update()
    local w = self:getWidth()
    local h = self:getHeight()
    local icon_size = icon_size_part * w
    local slot_size = slot_size_part * w

    self.__icon:setPosition(offset_x, offset_y)
    self.__icon:setSize(icon_size, icon_size)

    self.__title:setPosition(2 * offset_x + icon_size, offset_y)
    self.__title:setSize(w - (3 * offset_x + size), 0.015)

    if #self.__slots > 0 then
        for i = 1, #self.__slots do
            local slot = self.__slots[i]
            slot:setPosition(offset_x + (i - 1) * slot_size, 2 * offset_y + icon_size)
            slot:setSize(slot_size, slot_size)
        end

        self.__text:setPosition(offset_x, 3 * offset_y + icon_size + slot_size)
        self.__text:setSize(w - 2 * offset_x, h - (3 * offset_y + icon_size + slot_size))
    else
        self.__text:setPosition(offset_x, 2 * offset_y + icon_size)
        self.__text:setSize(w - 2 * offset_x, h - (2 * offset_y + icon_size))
    end
end

---@param icon string
function ItemTooltipFrame:setIcon(icon)
    self.__icon:setIcon(icon)
end

---@return boolean
function ItemTooltipFrame:addEmptySlot()
    if slot_size_part * (#self.__slots + 1) < 1 then
        table.insert(self.__slots, #self.__slots + 1, InventorySlot.new(self))
        self:update()
        return true
    end
    return false
end

---@param pos number
---@param item_frame ItemFrame
---@return boolean
function ItemTooltipFrame:setSlot(pos, item_frame)
    if pos < 1 or pos > #self.__slots then
        return false
    end
    ---@type ItemFrame
    local slot = self.__slots[pos]
    if item_frame ~= nil then 
        slot:setItem(item_frame)
    end
end

---@param pos number
---@return Frame
function ItemTooltipFrame:getSlot(pos)
    return self.__slots[pos]
end

---@param title string
function ItemTooltipFrame:setTitle(title)
    BlzFrameSetText(self.__title:getObj(), title)
end

---@param title string
function ItemTooltipFrame:setText(title)
    BlzFrameSetText(self.__text:getObj(), title)
end

return ItemTooltipFrame