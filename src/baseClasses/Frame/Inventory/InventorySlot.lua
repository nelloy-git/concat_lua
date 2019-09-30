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

    frame.__background = Frame.new("BACKDROP", frame)

    return frame
end

function InventorySlotFrame:update()
    local w = self:getWidth()
    --local h = self:getHeight()
    local size = w - 2 * offset_x

    self.__background:setPosition(offset_x, offset_y)
    self.__background:setSize(size, size)

    if self.__item ~= nil then
        self.__item:setPosition(0, 0)
        self.__item:setSize(size, size)
    end
end

---@param icon string
function InventorySlotFrame:setBackgroundIcon(icon)
    BlzFrameSetTexture(self.__background:getObj(), icon, 0, true)
end

---@param item_frame ItemFrame|nil
function InventorySlotFrame:setItem(item_frame)
    self.__item = item_frame
    if item_frame then
        item_frame:setParent(self.__background)
    end
end

---@return ItemFrame|nil
function InventorySlotFrame:getItem()
    return self.__item
end

return InventorySlotFrame