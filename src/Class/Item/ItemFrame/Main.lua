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
--        \------> Title : Frame(ItemTooltipTitle)
--         \-----> Text : Frame(ItemTooltipText)
--          \----> TypeIcon : Frame(BACKDROP)
--           \---> Slot1 : Frame(BACKDROP)
--            \     \--> SlotContent : IconFrame
--             \-> ...
--              \> SlotN : Frame(BACKDROP)
--                  \--> SlotContent : IconFrame

-- IconFrame
local Icon_key = 'Icon'
local Area_key = 'Area'
local Tooltip_key = 'Tooltip'

-- Tooltip
local Title_key = 'Title'
local Text_key = 'Text'
local TypeIcon_key = 'TypeIcon'
local function Slot_key(pos) return 'Slot'..tostring(pos) end

--Slot
local SlotContent_key = 'SlotContent'


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
    area:setWidth(function(self) return self:getParent():getWidth() end)
    area:setHeight(function(self) return self:getParent():getHeight() end)

    -- Tooltip
    local tooltip = Frame.newCustomType('ItemTooltipBackground')
    icon:setSubframe(Tooltip_key, tooltip)
    tooltip:setX(function(self)  end)

        -- Title
        tooltip:setSubframe(Title_key, title)

        -- Text
        tooltip:setSubframe(Text_key, text)

        -- TypeIcon
        tooltip:setSubframe(TypeIcon_key, type_icon)

    return icon
end

---@param self Frame
---@return number
local function getTooltipX(self)
    local parent = self:getParent()
    if parent:getAbsX() > Frame.getScreenWidth() / 2 then
        return -self:getWidth()
    else
        return parent:getWidth()
    end
end
---@param self Frame
---@return number
local function getTooltipY(self)
    local parent = self:getParent()
    if parent:getAbsY() > Frame.getScreenHeight() / 2 then
        return 0
    else
        return self:getHeight() - parent:getHeight()
    end
end


return ItemFrame