local Frame = require('baseClasses.Frame.FrameData')

---@class InventorySlotFrame:Frame
local InventorySlotFrame = {
    __type = "InventorySlotClassFrame"
}
setmetatable(InventorySlotFrame, {__index = Frame})

local InventorySlotFrame_meta = {
    __type = "InventorySlotFrame",
    __index = InventorySlotFrame
}

local offset_x = 0.004
local offset_y = 0.004

local initialized = false
function InventorySlotFrame.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

---@param parent Frame
---@return InventorySlotFrame
function InventorySlotFrame.new(parent)
    local frame = Frame.new("InvetorySlotBackground", parent)
    setmetatable(frame, InventorySlotFrame_meta)

    frame.__image = Frame.new("BACKDROP", frame)

    return frame
end

function InventorySlotFrame:update()
    local w = self:getWidth()
    local h = self:getHeight()
    self:applyMainFramePos()

    self.__image:setPosition(offset_x, offset_y)
    self.__image:setSize(w - 2 * offset_x, h - 2 * offset_y)
end

---@param icon string
function InventorySlotFrame:setIcon(icon)
    BlzFrameSetTexture(self.__image:getObj(), icon, 0, true)
end

return InventorySlotFrame