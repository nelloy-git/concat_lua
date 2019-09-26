local Frame = require('baseClasses.Frame.FrameData')

---@class FrameInventorySlot:Frame
local FrameInventorySlot = {
    __type = "FrameInventorySlotClass"
}
setmetatable(FrameInventorySlot, {__index = Frame})

local FrameInventory_meta = {
    __type = "FrameInventorySlot",
    __index = FrameInventorySlot
}

local inv_width
local inv_height

local initialized = false
function FrameInventorySlot.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

---@return FrameInventorySlot
function FrameInventorySlot.new()
    local frame Frame.new("InvetorySlot", Frame.GAME_UI)
    frame.__image = Frame.getByName("InventoryImage", 0)

    return frame
end

---@param image string
function FrameInventorySlot:setImage(image)
    BlzFrameSetTexture(self:getImageObj(), image, 0, true)
end

---@return framehandle
function FrameInventorySlot:getImageObj()
    return self.__image:getObj()
end

return FrameInventorySlot