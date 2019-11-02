local Frame = require('baseClasses.Frame.FrameData')
local InventorySlot = require('baseClasses.Frame.Inventory.InventorySlot')
local ParametersArea = require('baseClasses.Frame.Inventory.Parameter.ParametersArea')

---@class InventoryFrame:Frame
local InventoryFrame = {
    __type = "InventoryFrameClass"
}
setmetatable(InventoryFrame, {__index = Frame})

local InventoryFrame_meta = {
    __type = "InventoryFrame",
    __index = InventoryFrame
}

local offset_x = 0.002
local offset_y = 0.002
local slot_size_part = 0.125

local inv_image = {
    bag = "war3mapImported\\Icons\\Inventory\\Bag.blp",
    belt = "war3mapImported\\Icons\\Inventory\\Belt.blp",
    boots = "war3mapImported\\Icons\\Inventory\\Boots.blp",
    bracers = "war3mapImported\\Icons\\Inventory\\Bracers.blp",
    chest = "war3mapImported\\Icons\\Inventory\\Chest.blp",
    earring = "war3mapImported\\Icons\\Inventory\\Earring.blp",
    empty = "war3mapImported\\Icons\\Inventory\\Empty.blp",
    gloves = "war3mapImported\\Icons\\Inventory\\Gloves.blp",
    head = "war3mapImported\\Icons\\Inventory\\Head.blp",
    legs = "war3mapImported\\Icons\\Inventory\\Legs.blp",
    necklace = "war3mapImported\\Icons\\Inventory\\Necklace.blp",
    offhand = "war3mapImported\\Icons\\Inventory\\Shield.blp",
    ring = "war3mapImported\\Icons\\Inventory\\Ring.blp",
    shoulder = "war3mapImported\\Icons\\Inventory\\Shoulder.blp",
    weapon = "war3mapImported\\Icons\\Inventory\\MeleeWeapon.blp",
}

local initialized = false
function InventoryFrame.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

---@param parent Frame
---@return InventoryFrame
function InventoryFrame.new(parent)
    local frame = Frame.new("InventoryBackground", parent)
    setmetatable(frame, InventoryFrame_meta)

    --===========
    -- Left side
    --===========
    frame.__head = InventorySlot.new(frame)
    frame.__head:setBackgroundIcon(inv_image.head)

    frame.__necklace = InventorySlot.new(frame)
    frame.__necklace:setBackgroundIcon(inv_image.necklace)

    frame.__shoulder = InventorySlot.new(frame)
    frame.__shoulder:setBackgroundIcon(inv_image.shoulder)

    frame.__chest = InventorySlot.new(frame)
    frame.__chest:setBackgroundIcon(inv_image.chest)

    frame.__belt = InventorySlot.new(frame)
    frame.__belt:setBackgroundIcon(inv_image.belt)

    frame.__legs = InventorySlot.new(frame)
    frame.__legs:setBackgroundIcon(inv_image.legs)

    frame.__boots = InventorySlot.new(frame)
    frame.__boots:setBackgroundIcon(inv_image.boots)

    frame.__weapon = InventorySlot.new(frame)
    frame.__weapon:setBackgroundIcon(inv_image.weapon)

    --============
    -- Right side
    --============
    frame.__earring_1 = InventorySlot.new(frame)
    frame.__earring_1:setBackgroundIcon(inv_image.earring)

    frame.__earring_2 = InventorySlot.new(frame)
    frame.__earring_2:setBackgroundIcon(inv_image.earring)

    frame.__ring_1 = InventorySlot.new(frame)
    frame.__ring_1:setBackgroundIcon(inv_image.ring)

    frame.__ring_2 = InventorySlot.new(frame)
    frame.__ring_2:setBackgroundIcon(inv_image.ring)

    frame.__bracers = InventorySlot.new(frame)
    frame.__bracers:setBackgroundIcon(inv_image.bracers)

    frame.__gloves = InventorySlot.new(frame)
    frame.__gloves:setBackgroundIcon(inv_image.gloves)

    frame.__bag = InventorySlot.new(frame)
    frame.__bag:setBackgroundIcon(inv_image.bag)

    frame.__offhand = InventorySlot.new(frame)
    frame.__offhand:setBackgroundIcon(inv_image.offhand)

    --=======
    -- Stats
    --=======
    frame.__parameters = ParametersArea.new(frame)

    --=====
    -- Bag
    --=====
    frame.__bag_slots = {}
    for j = 1, 4 do
        for i = 1, 8 do
            local slot = InventorySlot.new(frame)
            slot:setBackgroundIcon(inv_image.empty)
            table.insert(frame.__bag_slots, #frame.__bag_slots + 1, slot)
        end
    end

    --======
    -- Belt
    --======
    frame.__belt_slots = {}
    for i = 1, 6 do
        local slot = InventorySlot.new(frame)
        slot:setBackgroundIcon(inv_image.empty)
        table.insert(frame.__belt_slots, #frame.__belt_slots + 1, slot)
    end

    frame:update()

    return frame
end

---@return ParametersAreaFrame
function InventoryFrame:getParametersArea()
    return self.__parameters
end

---@param unit Unit
function InventoryFrame:setUnit(unit)
    self.__unit = unit
end

---@return Unit
function InventoryFrame:getUnit()
    return self.__unit
end

function InventoryFrame:update()
    local w = self:getWidth()
    local h = self:getHeight()
    local size = slot_size_part * (w - 4 * offset_y)

    self:applyMainFramePos()

    self.__head:setPosition(offset_x, offset_y + 0 * size)
    self.__head:setSize(size, size)
    self.__necklace:setPosition(offset_x, offset_y + 1 * size)
    self.__necklace:setSize(size, size)
    self.__shoulder:setPosition(offset_x, offset_y + 2 * size)
    self.__shoulder:setSize(size, size)
    self.__chest:setPosition(offset_x, offset_y + 3 * size)
    self.__chest:setSize(size, size)
    self.__belt:setPosition(offset_x, offset_y + 4 * size)
    self.__belt:setSize(size, size)
    self.__legs:setPosition(offset_x, offset_y + 5 * size)
    self.__legs:setSize(size, size)
    self.__boots:setPosition(offset_x, offset_y + 6 * size)
    self.__boots:setSize(size, size)
    self.__weapon:setPosition(offset_x, offset_y + 7 * size)
    self.__weapon:setSize(size, size)

    self.__earring_1:setPosition(w - offset_x - size, offset_y + 0 * size)
    self.__earring_1:setSize(size, size)
    self.__earring_2:setPosition(w - offset_x - size, offset_y + 1 * size)
    self.__earring_2:setSize(size, size)
    self.__ring_1:setPosition(w - offset_x - size, offset_y + 2 * size)
    self.__ring_1:setSize(size, size)
    self.__ring_2:setPosition(w - offset_x - size, offset_y + 3 * size)
    self.__ring_2:setSize(size, size)
    self.__bracers:setPosition(w - offset_x - size, offset_y + 4 * size)
    self.__bracers:setSize(size, size)
    self.__gloves:setPosition(w - offset_x - size, offset_y + 5 * size)
    self.__gloves:setSize(size, size)
    self.__bag:setPosition(w - offset_x - size, offset_y + 6 * size)
    self.__bag:setSize(size, size)
    self.__offhand:setPosition(w - offset_x - size, offset_y + 7 * size)
    self.__offhand:setSize(size, size)

    self.__parameters:setPosition(2 * offset_x + size, offset_y)
    self.__parameters:setSize(6 * size, 6.5 * size)

    for i = 1, 6 do
        local slot = self.__belt_slots[i]
        slot:setPosition(2 * offset_x + i * size, offset_y + 6.5 * size)
        slot:setSize(size, size)
    end

    for j = 1, 4 do
        for i = 1, 8 do
            local slot = self.__bag_slots[(j - 1) * 8 + i]
            slot:setPosition(2 * offset_x + (i - 1) * size, h - offset_y - (5 - j) * size)
            slot:setSize(size, size)
        end
    end
end


return InventoryFrame