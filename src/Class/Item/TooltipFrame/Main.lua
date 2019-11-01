--==========
-- Includes
--==========

---@type Frame
local Frame = require('Include.Frame')
---@type ItemFrame
local ItemFrame = require('Include.ItemFrame')

--=======
-- Class
--=======

---@class ItemFrameTooltip2:Frame
local ItemFrameTooltip = newClass('ItemFrameTooltip')
setmetatable(ItemFrameTooltip, Frame)
local ItemFrameTooltip_meta = newMeta(ItemFrameTooltip)


local TITLE_KEY = 'Title'
local TEXT_KEY = 'Text'
local TYPE_ICON_KEY = 'TypeIcon'
local SLOT_KEY = 'Slot'

local function getSlotKey(pos)
    return SLOT_KEY..tostring(pos)
end


local initialized = false
function ItemFrameTooltip.init()
    if initialized then return nil end

    Frame.loadToc("war3mapImported\\Frame\\Item\\Tooltip.toc")

    initialized = true
end

---@param slots number
---@return ItemFrameTooltip
function ItemFrameTooltip.new(slots)
    local tooltip = Frame.newDefaultType("BACKDROP")
    setmetatable(tooltip, ItemFrameTooltip_meta)
    tooltip.__slots = slots

    local title = Frame.newCustomType("ItemTooltipTitle")

    tooltip:setSubframe(TITLE_KEY, title)
end

return ItemFrameTooltip