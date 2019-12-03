--=========
-- Include
--=========

--=======
-- Class
--=======

---@type FrameTooltipClass
local FrameTooltip = newClass('FrameTooltip')

---@class FrameTooltip
local public = FrameTooltip.public
---@class FrameTooltipClass
local static = FrameTooltip.static
---@type table
local override = FrameTooltip.override
---@type table(FrameTooltip, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameTooltip
function static.new(instance_data)
    local instance = instance_data or newInstanceData(FrameTooltip)
    local priv = {
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    freeInstanceData(self)
end

return FrameTooltip