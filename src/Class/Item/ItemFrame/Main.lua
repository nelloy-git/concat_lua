--==========
-- Includes
--==========

---@type Frame
local Frame = require('Include.Frame')
---@type ItemTooltipFrame
local TooltipFrame = require('Include.ItemTooltipFrame')

--=======
-- Class
--=======

---@class ItemFrame
local ItemFrame = newClass('ItemFrame')
setmetatable(ItemFrame, Frame)
local ItemFrame_meta = newMeta(ItemFrame)

-- IconFrame
--  \---> Icon : Frame(BACKDROP)
--   \--> Area : Frame(FRAME)
--    \-> Tooltip : Frame(ItemTooltipBackground)
--         \-------> TypeIcon : Frame(BACKDROP)
--          \------> Title : Frame(ItemTooltipTitle)
--           \-----> Text : Frame(ItemTooltipText)
--            \----> Slot1 : Frame(BACKDROP)
--             \     \--> SlotContent : IconFrame
--              \--> ...
--               \-> SlotN : Frame(BACKDROP)
--                    \--> SlotContent : IconFrame

-- IconFrame
local Icon_key = 'Icon'

--================
-- Icon subframes
--================
local Area_key = 'Area'
local getAreaX = 0
local getAreaY = 0
local getAreaW -- Predefined
local getAreaH -- Predefined

local Tooltip_key = 'Tooltip'
local getTooltipX -- Predefined
local getTooltipY -- Predefined
local getTooltipW -- Predefined
local getTooltipH -- Predefined

    --===================
    -- Tooltip subframes
    --===================
    local TypeIcon_key = 'TypeIcon'
    local getTypeIconX -- Predefined
    local getTypeIconY -- Predefined
    local getTypeIconW -- Predefined
    local getTypeIconH -- Predefined

    local Title_key = 'Title'
    local getTitleX -- Predefined
    local getTitleY -- Predefined
    local getTitleW -- Predefined
    local getTitleH -- Predefined

    local Text_key = 'Text'
    local getTextX -- Predefined
    local getTextY -- Predefined
    local getTextW -- Predefined
    local getTextH -- Predefined

    local Slot_key = function(pos) return 'Slot'..tostring(pos) end
    local getSlotX -- Predefined
    local getSlotY -- Predefined
    local getSlotW -- Predefined
    local getSlotH -- Predefined

        --================
        -- Slot subframes
        --================
        local SlotContent_key = 'Content'
        local getSlotContentX -- Predefined
        local getSlotContentY -- Predefined
        local getSlotContentW -- Predefined
        local getSlotContentH -- Predefined


local initialized = false
function ItemFrame.init()
    if initialized then return nil end

    Frame.loadToc("war3mapImported\\Frame\\Item\\Tooltip.toc")

    initialized = true
end

function ItemFrame.new()
    local icon = Frame.newDefaultType('BACKDROP')
    setmetatable(icon, ItemFrame_meta)
    
    local title = Frame.newCustomType('ItemTooltipTitle')
    local text = Frame.newCustomType('ItemTooltipText')
    local type_icon = Frame.newCustomType('BACKDROP')

    -- Area
    local area = Frame.newDefaultType('FRAME')
    icon:setSubframe(Area_key, area)
    area:setX(0)
    area:setY(0)
    area:setWidth(getAreaW)
    area:setHeight(getAreaH)

    -- Tooltip
    local tooltip = Frame.newCustomType('ItemTooltipBackground')
    icon:setSubframe(Tooltip_key, tooltip)
    tooltip:setX(getTooltipX)
    tooltip:setY(getTooltipY)
    tooltip:setWidth(getTooltipW)
    tooltip:setHeight(getTooltipH)

        -- TypeIcon
        tooltip:setSubframe(TypeIcon_key, type_icon)

        -- Title
        tooltip:setSubframe(Title_key, title)
        title:setX(getTitleX)

        -- Text
        tooltip:setSubframe(Text_key, text)

    return icon
end

---@param self Frame
---@return number
getAreaW = function(self)
    return self:getParent():getWidth()
end

---@param self Frame
---@return number
getAreaH = function(self)
    return self:getParent():getHeight()
end

---@param self Frame
---@return number
getTooltipX = function(self)
    local parent = self:getParent()
    if parent:getAbsX() > Frame.getScreenWidth() / 2 then
        return -self:getWidth()
    else
        return parent:getWidth()
    end
end

---@param self Frame
---@return number
getTooltipY = function(self)
    local parent = self:getParent()
    if parent:getAbsY() > Frame.getScreenHeight() / 2 then
        return 0
    else
        return self:getHeight() - parent:getHeight()
    end
end

getTooltipW = function(self)
    return 0.2
end

getTooltipH = function(self)
    return 0.3
end


return ItemFrame