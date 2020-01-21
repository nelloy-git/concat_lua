--=========
-- Include
--=========

local Class = require('utils.Class.Class')

--=======
-- Class
--=======

local ItemSlotFrame = Class.new('ItemSlotFrame')

---@class ItemSlotFrame
local public = ItemSlotFrame.public
---@class ItemSlotFrameClass
local static = ItemSlotFrame.static
local override = ItemSlotFrame.override
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return ItemSlotFrame
function static.new(instance_data)
    local instance = instance_data or Class.allocate(ItemSlotFrame)
    local priv = {
        icon = nil,
        
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    Class.free(self)
end

return ItemSlotFrame