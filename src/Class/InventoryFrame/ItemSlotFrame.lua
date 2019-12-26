--=========
-- Include
--=========

local Class = require('Utils.Class')

--=======
-- Class
--=======

---@type any
local ItemSlotFrame = Class.newClass('ItemSlotFrame')

---@class ItemSlotFrame
local public = ItemSlotFrame.public
---@class ItemSlotFrameClass
local static = ItemSlotFrame.static
---@type table
local override = ItemSlotFrame.override
---@type table(ItemSlotFrame, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return ItemSlotFrame
function static.new(instance_data)
    local instance = instance_data or Class.newInstanceData(ItemSlotFrame)
    local priv = {
        icon = nil,
        
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    freeInstanceData(self)
end

return ItemSlotFrame