local Frame = require('baseClasses.Frame.FrameData')
local InventorySlot = require('baseClasses.Frame.FrameInventorySlot')

---@class FrameItem
local FrameItem = {
    __type = "FrameItemClass"
}
setmetatable(FrameItem, {__index = Frame})

local FrameItem_meta = {
    __type = "FrameItem",
    __index = FrameItem
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
function FrameItem.init()
    if initialized then return nil end

    Frame.init()
    InventorySlot.init()

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

function FrameItem.new(parent)
    local img_frame = Frame.new("BACKDROP", parent)
    BlzFrameSetTexture(img_frame:getObj(), "", 0, true)
    setmetatable(img_frame, FrameItem_meta)

    img_frame.__tooltip = Frame.new("InventoryBackground", img_frame)
    img_frame.__tooltip:setSize(tooltip_width, tooltip_height)

    img_frame.__tooltip_icon = Frame.new("InvetorySlot", img_frame.__tooltip)
    img_frame.__tooltip_icon:setPosition(img_frame.__tooltip, tooltip_icon_x, tooltip_icon_y)
    img_frame.__tooltip_icon:setSize(tooltip_icon_width, tooltip_icon_height)

    img_frame.__tooltip_title = Frame.new("InventoryItemTooltipTitle", 0)
    img_frame.__tooltip_title:setPosition(img_frame.__tooltip, tooltip_title_x, tooltip_title_y)
    --BlzFrameSetFont(img_frame.__tooltip_title:getObj(), "war3mapImported/fonts/ParchmentMF.ttf", tooltip_title_font, 0)
    
    img_frame.__tooltip_text = Frame.getByName("InventoryItemTooltipText", 0)
    img_frame.__tooltip_text:setPosition(img_frame.__tooltip, tooltip_text_x, tooltip_text_y)
    img_frame.__tooltip_text:setSize(tooltip_text_width, tooltip_text_height)

    img_frame.__tooltip_slots = {}
    for i = 1, 5 do
        img_frame.__tooltip_slots[i] = InventorySlot.new(img_frame.__tooltip)
        img_frame.__tooltip_slots[i]:setPosition(img_frame.__tooltip, tooltip_slot_x + (i - 1) * tooltip_slot_width, tooltip_slot_y)
        img_frame.__tooltip_slots[i]:setSize(tooltip_slot_width, tooltip_slot_height)
    end

    return img_frame
end

function FrameItem:setPosition(pos)
end

---@param width number
---@param height number
function FrameItem:setButtonSize(width, height)
    self.__btn_width = width
    self.__btn_height = height
    BlzFrameSetSize(self.__btn_img, width, height)
end

---@param width number
---@param height number
function FrameItem:setTooltipSize(width, height)
    BlzFrameSetSize(self.__tooltip, width, height)
end

function FrameItem:moveTooltipTopLeft()
    BlzFrameClearAllPoints(self.__tooltip)
    BlzFrameSetPoint(self.__tooltip, FRAMEPOINT_BOTTOMRIGHT, self.__btn_img, FRAMEPOINT_BOTTOMLEFT, 0, 0)
end

function FrameItem:moveTooltipTopRight()
    BlzFrameClearAllPoints(self.__tooltip)
    BlzFrameSetPoint(self.__tooltip, FRAMEPOINT_BOTTOMLEFT, self.__btn_img, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
end

function FrameItem:moveTooltipBottomLeft()
    BlzFrameClearAllPoints(self.__tooltip)
    BlzFrameSetPoint(self.__tooltip, FRAMEPOINT_TOPRIGHT, self.__btn_img, FRAMEPOINT_TOPLEFT, 0, 0)
end

function FrameItem:moveTooltipBottomRight()
    BlzFrameClearAllPoints(self.__tooltip)
    BlzFrameSetPoint(self.__tooltip, FRAMEPOINT_TOPLEFT, self.__btn_img, FRAMEPOINT_TOPRIGHT, 0, 0)
end

return FrameItem