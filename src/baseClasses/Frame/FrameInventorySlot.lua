local Frame = require('baseClasses.Frame.FrameData')

---@class FrameInventorySlot:Frame
local FrameInventorySlot = {
    __type = "FrameInventorySlotClass"
}
setmetatable(FrameInventorySlot, {__index = Frame})

local FrameInventorySlot_meta = {
    __type = "FrameInventorySlot",
    __index = FrameInventorySlot
}

local initialized = false
function FrameInventorySlot.init()
    if initialized then return nil end

    Frame.init()

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

---@param parent Frame
---@return FrameInventorySlot
function FrameInventorySlot.new(parent)
    local frame = Frame.new("InvetorySlot", parent)
    frame.__image = Frame.getByName("InventoryImage", 0)
    setmetatable(frame, FrameInventorySlot_meta)

    return frame
end

---@param image string
function FrameInventorySlot:setImage(image)
    BlzFrameSetTexture(self:getImageObj(), image, 0, true)
end

---@return Frame
function FrameInventorySlot:getImageFrame()
    return self.__image
end

return FrameInventorySlot