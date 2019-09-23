---@class FrameInventory
local FrameInventory = {
    __type = "FrameInventoryClass"
}

local FrameInventory_meta = {
    __type = "FrameInventory",
    __index = FrameInventory
}

local game_ui

local initialized = false
function FrameInventory.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    game_ui = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    initialized = true
end

---@return FrameInventory
function FrameInventory.new()
    --local panel = BlzCreateFrameByType("BACKDROP", "InterfacePanel", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)

    local invetory = BlzCreateFrame("InvetoryPanel", game_ui, 0, 0)
    --BlzFrameSetSize(invetory, 0.210, 0.240)

    BlzFrameSetAbsPoint(invetory, FRAMEPOINT_TOPLEFT, 0.590, 0.420)
    BlzFrameSetAbsPoint(invetory, FRAMEPOINT_BOTTOMRIGHT, 0.8, 0.180)

    local frame = {
        __Inventory  = invetory,
        __HeadSlot = BlzGetFrameByName("InventoryHead", 0),
        __ChestSlot = BlzGetFrameByName("InventoryChest", 0),
        __BeltSlot = BlzGetFrameByName("InventoryBelt", 0),
        __LegsSlot = BlzGetFrameByName("InventoryLegs", 0),
        __BootsSlot = BlzGetFrameByName("InventoryBoots", 0),
        __ShouldersSlot = BlzGetFrameByName("InventoryShoulders", 0),
        __BracersSlot = BlzGetFrameByName("InventoryBracers", 0),
        __WeaponSlot = BlzGetFrameByName("InventoryWeapon", 0),
        __GlovesSlot = BlzGetFrameByName("InventoryGloves", 0),
        __OffhandSlot = BlzGetFrameByName("InventoryOffhand", 0),
        __NecklaceSlot = BlzGetFrameByName("InventoryNecklace", 0),
        __Earring1Slot = BlzGetFrameByName("InventoryEarring1", 0),
        __Earring2Slot = BlzGetFrameByName("InventoryEarring2", 0),
        __Ring1Slot = BlzGetFrameByName("InventoryRing1", 0),
        __Ring2Slot = BlzGetFrameByName("InventoryRing2", 0),
        __Ring3Slot = BlzGetFrameByName("InventoryRing3", 0),
        __Ring4Slot = BlzGetFrameByName("InventoryRing4", 0),
        __BagSlot = {
            [1] = BlzGetFrameByName("InventorySlot1", 0),
            [2] = BlzGetFrameByName("InventorySlot2", 0),
            [3] = BlzGetFrameByName("InventorySlot3", 0),
            [4] = BlzGetFrameByName("InventorySlot4", 0),
            [5] = BlzGetFrameByName("InventorySlot5", 0),
            [6] = BlzGetFrameByName("InventorySlot6", 0),
            [7] = BlzGetFrameByName("InventorySlot7", 0),
            [8] = BlzGetFrameByName("InventorySlot8", 0),
            [9] = BlzGetFrameByName("InventorySlot9", 0),
            [10] = BlzGetFrameByName("InventorySlot10", 0),
            [11] = BlzGetFrameByName("InventorySlot11", 0),
            [12] = BlzGetFrameByName("InventorySlot12", 0),
            [13] = BlzGetFrameByName("InventorySlot13", 0),
            [14] = BlzGetFrameByName("InventorySlot14", 0),
            [15] = BlzGetFrameByName("InventorySlot15", 0),
            [16] = BlzGetFrameByName("InventorySlot16", 0),
            [17] = BlzGetFrameByName("InventorySlot17", 0),
            [18] = BlzGetFrameByName("InventorySlot18", 0),
            [19] = BlzGetFrameByName("InventorySlot19", 0),
            [20] = BlzGetFrameByName("InventorySlot20", 0),
            [21] = BlzGetFrameByName("InventorySlot21", 0),
            [22] = BlzGetFrameByName("InventorySlot22", 0),
            [23] = BlzGetFrameByName("InventorySlot23", 0),
            [24] = BlzGetFrameByName("InventorySlot24", 0),
            [25] = BlzGetFrameByName("InventorySlot25", 0),
            [26] = BlzGetFrameByName("InventorySlot26", 0),
            [27] = BlzGetFrameByName("InventorySlot27", 0),
            [28] = BlzGetFrameByName("InventorySlot28", 0),
            [29] = BlzGetFrameByName("InventorySlot29", 0),
            [30] = BlzGetFrameByName("InventorySlot30", 0),
            [31] = BlzGetFrameByName("InventorySlot31", 0),
            [32] = BlzGetFrameByName("InventorySlot32", 0),
        }
    }
    setmetatable(frame, FrameInventory_meta)

    --BlzFrameSetTexture(frame.__HeadSlot, "war3mapImported\\Icons\\Inventory\\Head.blp", 0, true)
    --BlzFrameSetTexture(frame.__ChestSlot, "war3mapImported\\Icons\\Inventory\\Chest.blp", 0, true)
    --BlzFrameSetTexture(frame.__BeltSlot, "war3mapImported\\Icons\\Inventory\\Belt.blp", 0, true)
    --BlzFrameSetTexture(frame.__LegsSlot, "war3mapImported\\Icons\\Inventory\\Legs.blp", 0, true)
    --BlzFrameSetTexture(frame.__BootsSlot, "war3mapImported\\Icons\\Inventory\\Boots.blp", 0, true)
    --BlzFrameSetTexture(frame.__ShouldersSlot, "war3mapImported\\Icons\\Inventory\\Shoulder.blp", 0, true)
    --BlzFrameSetTexture(frame.__BracersSlot, "war3mapImported\\Icons\\Inventory\\Bracers.blp", 0, true)
    --BlzFrameSetTexture(frame.__WeaponSlot, "war3mapImported\\Icons\\Inventory\\MeleeWeapon.blp", 0, true)
    --BlzFrameSetTexture(frame.__GlovesSlot, "war3mapImported\\Icons\\Inventory\\Gloves.blp", 0, true)
    --BlzFrameSetTexture(frame.__OffhandSlot, "war3mapImported\\Icons\\Inventory\\Shield.blp", 0, true)
    --BlzFrameSetTexture(frame.__NecklaceSlot, "war3mapImported\\Icons\\Inventory\\Necklace.blp", 0, true)
    --BlzFrameSetTexture(frame.__Earring1Slot, "war3mapImported\\Icons\\Inventory\\Earring.blp", 0, true)
    --BlzFrameSetTexture(frame.__Earring2Slot, "war3mapImported\\Icons\\Inventory\\Earring.blp", 0, true)
    --BlzFrameSetTexture(frame.__Ring1Slot, "war3mapImported\\Icons\\Inventory\\Ring.blp", 0, true)
    --BlzFrameSetTexture(frame.__Ring2Slot, "war3mapImported\\Icons\\Inventory\\Ring.blp", 0, true)
    --BlzFrameSetTexture(frame.__Ring3Slot, "war3mapImported\\Icons\\Inventory\\Ring.blp", 0, true)
    --BlzFrameSetTexture(frame.__Ring4Slot, "war3mapImported\\Icons\\Inventory\\Ring.blp", 0, true)

    return frame
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