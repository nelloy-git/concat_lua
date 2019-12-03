--=========
-- Include
--=========

--=======
-- Class
--=======

---@type FrameTableClass
local FrameTable = newClass('FrameTable')

---@class FrameTable
local public = FrameTable.public
---@class FrameTableClass
local static = FrameTable.static
---@type table
local override = FrameTable.override
---@type table(FrameTable, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameTable
function static.new(instance_data)
    local instance = instance_data or newInstanceData(FrameTable)
    local priv = {
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    freeInstanceData(self)
end

return FrameTable