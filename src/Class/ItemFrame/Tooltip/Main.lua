--==========
-- Includes
--==========

---@type Frame
local Frame = require('Include.Frame')

--=======
-- Class
--=======

---@class ItemFrameTooltip:Frame
local ItemFrameTooltip = newClass('ItemFrameTooltip')
setmetatable(ItemFrameTooltip, Frame)
local ItemFrameTooltip_meta = newMeta(ItemFrameTooltip)

local initialized = false
function ItemFrameTooltip.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

function ItemFrameTooltip.new(parent)
    local item_frame_tooltip = Frame.newDefault("BACKDROP", parent)
    
    local 

end

return ItemFrameTooltip