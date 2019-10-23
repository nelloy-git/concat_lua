--==========
-- Includes
--==========

---@type Frame
local Frame = require('Include.Frame')

--=======
-- Class
--=======

---@class ItemFrame
local ItemFrame = newClass('ItemFrame')
setmetatable(ItemFrame, Frame)
local ItemFrame_meta = newMeta(ItemFrame)

local ICON = 'icon'
local TOOLTIP = 'tooltip'

function ItemFrame.new(parent)
    local item_frame = Frame.newDefault('FRAME', parent)
    setmetatable(item_frame, ItemFrame_meta)
    
    local icon = Frame.newDefault("BACKDROP", item_frame)
    icon:setX(0)
    icon:setY(0)
    icon:setWidth(1)
    icon:setHeight(1)

    item_frame:addSubframe(ICON, icon)

    return item_frame
end

return ItemFrame