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

local inv_x = 0.1
local inv_y = 0.5
local inv_width = 0.3
local inv_height = 0.5
local inv_offset_x = 0.005
local inv_offset_y = 0.005
local slot_width = 0.025
local slot_height = 0.025
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

    local background = Frame.new("InventoryBackground", Frame.GAME_UI)
    background:setAbsPoint(FRAMEPOINT_TOPLEFT, inv_x, inv_y)
    background:setAbsPoint(FRAMEPOINT_BOTTOMRIGHT, inv_x + inv_width, inv_y - inv_height)

    -- Left side

    local head = InventorySlot.new()
    head:setParent(background)
    head:setPoint(FRAMEPOINT_TOPLEFT, background, FRAMEPOINT_TOPLEFT, inv_offset_x, -inv_offset_y)
    head:setPoint(FRAMEPOINT_BOTTOMRIGHT, background, FRAMEPOINT_TOPLEFT, inv_offset_x + slot_width, -inv_offset_y - slot_height)
    head:setImage(inv_image.head)

    local necklace = InventorySlot.new()
    necklace:setParent(background)
    necklace:setPoint(FRAMEPOINT_TOPLEFT, head, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    necklace:setPoint(FRAMEPOINT_BOTTOMRIGHT, head, FRAMEPOINT_BOTTOMRIGHT, 0, -slot_height)
    necklace:setImage(inv_image.necklace)

    local shoulder = InventorySlot.new()
    shoulder:setParent(background)
    shoulder:setPoint(FRAMEPOINT_TOPLEFT, necklace, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    shoulder:setPoint(FRAMEPOINT_BOTTOMRIGHT, necklace, FRAMEPOINT_BOTTOMRIGHT, 0, -slot_height)
    shoulder:setImage(inv_image.shoulder)

    local chest = InventorySlot.new()
    chest:setParent(background)
    chest:setPoint(FRAMEPOINT_TOPLEFT, shoulder, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    chest:setPoint(FRAMEPOINT_BOTTOMRIGHT, shoulder, FRAMEPOINT_BOTTOMRIGHT, 0, -slot_height)
    chest:setImage(inv_image.chest)

    local belt = InventorySlot.new()
    belt:setParent(background)
    belt:setPoint(FRAMEPOINT_TOPLEFT, chest, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    belt:setPoint(FRAMEPOINT_BOTTOMRIGHT, chest, FRAMEPOINT_BOTTOMRIGHT, 0, -slot_height)
    belt:setImage(inv_image.belt)

    local legs = InventorySlot.new()
    legs:setParent(background)
    legs:setPoint(FRAMEPOINT_TOPLEFT, belt, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    legs:setPoint(FRAMEPOINT_BOTTOMRIGHT, belt, FRAMEPOINT_BOTTOMRIGHT, 0, -slot_height)
    legs:setImage(inv_image.legs)

    local boots = InventorySlot.new()
    boots:setParent(background)
    boots:setPoint(FRAMEPOINT_TOPLEFT, legs, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    boots:setPoint(FRAMEPOINT_BOTTOMRIGHT, legs, FRAMEPOINT_BOTTOMRIGHT, 0, -slot_height)
    boots:setImage(inv_image.boots)

    local weapon = InventorySlot.new()
    weapon:setParent(background)
    weapon:setPoint(FRAMEPOINT_TOPLEFT, boots, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    weapon:setPoint(FRAMEPOINT_BOTTOMRIGHT, boots, FRAMEPOINT_BOTTOMRIGHT, 0, -slot_height)
    weapon:setImage(inv_image.weapon)

    local sprite = Frame.new("MODEL", background)
    BlzFrameSetModel(sprite.__frame_obj, "war3mapImported\\units\\SwordNya.mdx", 1)
    sprite:setAbsPoint(FRAMEPOINT_TOPLEFT, 0.5, 0.5)
    sprite:setAbsPoint(FRAMEPOINT_BOTTOMRIGHT, 0.6, 0.4)
    --local portrait = Frame.PORTRAIT
    --portrait:clearAllPoints()
    --portrait:setParent(weapon)
    --portrait:hide()
    --portrait:show()
    --portrait:setAbsPoint(FRAMEPOINT_CENTER, 0, 0)
    --portrait:show()

    initialized = true
end

---@return FrameInventory
function FrameInventory.new()


    --return frame
end

---@param frame FrameItem
function FrameInventory:removeBelt(frame)
    BlzFrameSetParent(frame.__btn_img, game_ui)
end

---@param frame FrameItem
function FrameInventory:setBelt(frame)
    BlzFrameSetParent(frame.__btn_img, self.__BeltSlot)
    BlzFrameSetAllPoints(frame.__btn_img, self.__BeltSlot)
end

return FrameInventory