---@type Frame
local Frame = require('baseClasses.Frame.FrameData')
---@type Frame
local ItemTooltip = require('baseClasses.Frame.Inventory.Item.Tooltip')

---@class ItemFrame
local ItemFrame = {
    __type = "ItemFrameClass"
}
setmetatable(ItemFrame, {__index = Frame})

local ItemFrame_meta = {
    __type = "ItemFrame",
    __index = ItemFrame
}

local tooltip_width = 0.1
local tooltip_height = 0.2
local tooltip_offset_x = 0.005
local tooltip_offset_y = 0.005

local tooltip_icon_x = tooltip_offset_x
local tooltip_icon_y = tooltip_offset_y
local tooltip_icon_width = 0.2 * tooltip_width
local tooltip_icon_height = tooltip_icon_width

local tooltip_slot_x = tooltip_offset_x
local tooltip_slot_y = tooltip_icon_y + tooltip_icon_height + tooltip_offset_y
local tooltip_slot_width = 0.12 * tooltip_width
local tooltip_slot_height = tooltip_slot_width

local tooltip_title_font = 0.014
local tooltip_title_x = tooltip_icon_x + tooltip_icon_width + tooltip_offset_x
local tooltip_title_y = tooltip_icon_y + tooltip_icon_height / 2 - tooltip_title_font / 2

local tooltip_text_font = 0.012
local tooltip_text_x = tooltip_offset_x
local tooltip_text_y = tooltip_slot_y + tooltip_slot_height + tooltip_offset_y
local tooltip_text_width = tooltip_width - 2 * tooltip_offset_x
local tooltip_text_height = tooltip_height - 2 * tooltip_offset_y

local initialized = false
function ItemFrame.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

---@param parent Frame
function ItemFrame.new(parent)
    local frame = Frame.new("BACKDROP", parent)
    BlzFrameSetTexture(frame:getObj(), "", 0, true)
    setmetatable(frame, ItemFrame_meta)

    frame.__hover = Frame.new("FRAME", frame)
    frame.__tooltip = ItemTooltip.new(frame)

    BlzFrameSetTooltip(frame.__hover:getObj(), frame.__tooltip:getObj())

    frame:update()

    return frame
end

function ItemFrame:update()
    local x = self:getX()
    local y = self:getY()
    local w = self:getWidth()
    local h = self:getHeight()
    local half_screen_w = Frame.getScreenWidth() / 2
    local half_screen_h = Frame.getScreenHeight() / 2

    self.__hover:setPosition(0, 0)
    self.__hover:setSize(w, h)

    if x > half_screen_w and y > half_screen_h then
        self.__tooltip:setPosition(-self.__tooltip:getWidth(), 0)
    elseif x <= half_screen_w and y > half_screen_h then
        self.__tooltip:setPosition(w, 0)
    elseif x > half_screen_w and y <= half_screen_h then
        self.__tooltip:setPosition(-self.__tooltip:getWidth(), -self.__tooltip:getHeight() + h)
    else
        self.__tooltip:setPosition(w, -self.__tooltip:getHeight() + h)
    end
end

---@param icon string
function ItemFrame:setIcon(icon)
    BlzFrameSetTexture(self:getObj(), icon, 0, true)
end

---@return ItemTooltipFrame
function ItemFrame:getTooltip()
    return self.__tooltip
end

return ItemFrame