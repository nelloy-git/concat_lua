local Frame = require('baseClasses.Frame.FrameData')
local FrameOrigin = require('baseClasses.Frame.FrameOrigin')
local InventorySlot = require('baseClasses.Frame.FrameInventorySlot')

---@class FrameInventory:Frame
local FrameInventory = {
    __type = "FrameInventoryClass"
}

local FrameInventory_meta = {
    __type = "FrameInventory",
    __index = FrameInventory
}

local inv_x = 0.05
local inv_y = 0.1
local inv_offset_x = 0.005
local inv_offset_y = 0.005
local slot_width = 0.03
local slot_height = 0.03
local inv_width = 2 * inv_offset_x + 8 * slot_width
local inv_height = 4 * inv_offset_y + 12 * slot_height
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
function FrameInventory.init()
    if initialized then return nil end

    Frame.init()
    FrameOrigin.init()
    InventorySlot.init()

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    local inventory = Frame.new("InventoryBackground", Frame.GAME_UI)
    inventory:setAbsPosition(inv_x, inv_y)
    inventory:setSize(inv_width, inv_height)

    --===========
    -- Left side
    --===========
    inventory.__head = InventorySlot.new(inventory)
    inventory.__head:setPosition(inventory, inv_offset_x, inv_offset_y)
    inventory.__head:setSize(slot_width, slot_height)
    inventory.__head:setImage(inv_image.head)

    inventory.__necklace = InventorySlot.new(inventory)
    inventory.__necklace:setPosition(inventory.__head, 0, slot_height)
    inventory.__necklace:setSize(slot_width, slot_height)
    inventory.__necklace:setImage(inv_image.necklace)

    inventory.__shoulder = InventorySlot.new(inventory)
    inventory.__shoulder:setPosition(inventory.__necklace, 0, slot_height)
    inventory.__shoulder:setSize(slot_width, slot_height)
    inventory.__shoulder:setImage(inv_image.shoulder)

    inventory.__chest = InventorySlot.new(inventory)
    inventory.__chest:setPosition(inventory.__shoulder, 0, slot_height)
    inventory.__chest:setSize(slot_width, slot_height)
    inventory.__chest:setImage(inv_image.chest)

    inventory.__belt = InventorySlot.new(inventory)
    inventory.__belt:setPosition(inventory.__chest, 0, slot_height)
    inventory.__belt:setSize(slot_width, slot_height)
    inventory.__belt:setImage(inv_image.belt)

    inventory.__legs = InventorySlot.new(inventory)
    inventory.__legs:setPosition(inventory.__belt, 0, slot_height)
    inventory.__legs:setSize(slot_width, slot_height)
    inventory.__legs:setImage(inv_image.legs)

    inventory.__boots = InventorySlot.new(inventory)
    inventory.__boots:setPosition(inventory.__legs, 0, slot_height)
    inventory.__boots:setSize(slot_width, slot_height)
    inventory.__boots:setImage(inv_image.boots)

    inventory.__weapon = InventorySlot.new(inventory)
    inventory.__weapon:setPosition(inventory.__boots, 0, slot_height)
    inventory.__weapon:setSize(slot_width, slot_height)
    inventory.__weapon:setImage(inv_image.weapon)

    --============
    -- Right side
    --============
    inventory.__earring_1 = InventorySlot.new(inventory)
    inventory.__earring_1:setPosition(inventory.__inventory, inv_width - inv_offset_x - slot_width, inv_offset_y)
    inventory.__earring_1:setSize(slot_width, slot_height)
    inventory.__earring_1:setImage(inv_image.earring)

    inventory.__earring_2 = InventorySlot.new(inventory)
    inventory.__earring_2:setPosition(inventory.__earring_1, 0, slot_height)
    inventory.__earring_2:setSize(slot_width, slot_height)
    inventory.__earring_2:setImage(inv_image.earring)

    inventory.__ring_1 = InventorySlot.new(inventory)
    inventory.__ring_1:setPosition(inventory.__earring_2, 0, slot_height)
    inventory.__ring_1:setSize(slot_width, slot_height)
    inventory.__ring_1:setImage(inv_image.ring)

    inventory.__ring_2 = InventorySlot.new(inventory)
    inventory.__ring_2:setPosition(inventory.__ring_1, 0, slot_height)
    inventory.__ring_2:setSize(slot_width, slot_height)
    inventory.__ring_2:setImage(inv_image.earring)

    inventory.__bracers = InventorySlot.new(inventory)
    inventory.__bracers:setPosition(inventory.__ring_2, 0, slot_height)
    inventory.__bracers:setSize(slot_width, slot_height)
    inventory.__bracers:setImage(inv_image.earring)

    inventory.__gloves = InventorySlot.new(inventory)
    inventory.__gloves:setPosition(inventory.__bracers, 0, slot_height)
    inventory.__gloves:setSize(slot_width, slot_height)
    inventory.__gloves:setImage(inv_image.earring)

    inventory.__bag = InventorySlot.new(inventory)
    inventory.__bag:setPosition(inventory.__gloves, 0, slot_height)
    inventory.__bag:setSize(slot_width, slot_height)
    inventory.__bag:setImage(inv_image.earring)

    inventory.__offhand = InventorySlot.new(inventory)
    inventory.__offhand:setPosition(inventory.__bag, 0, slot_height)
    inventory.__offhand:setSize(slot_width, slot_height)
    inventory.__offhand:setImage(inv_image.earring)

    --=====
    -- Bag
    --=====
    inventory.__bag_slots = {}
    for j = 1, 4 do
        for i = 1, 8 do
            local slot = InventorySlot.new(inventory)
            slot:setPosition(inventory, inv_offset_x + i * slot_width, 3 * inv_offset_y + (8 + j) * slot_height)
            slot:setSize(slot_width, slot_height)
            slot:setImage(inv_image.empty)
            table.insert(inventory.__bag_slots, #inventory.__bag_slots, slot)
        end
    end

    --======
    -- Belt
    --======
    inventory.__belt_slots = {}
    for i = 1, 6 do
        local slot = InventorySlot.new(inventory)
        slot:setPosition(inventory, inv_offset_x + (i + 1) * slot_width, inv_offset_y + 7 * slot_height)
        slot:setSize(slot_width, slot_height)
        slot:setImage(inv_image.empty)
        table.insert(inventory.__belt_slots, #inventory.__belt_slots, slot)
    end

    initialized = true
end

---@return FrameInventory
function FrameInventory.new()


    --return frame
end


return FrameInventory