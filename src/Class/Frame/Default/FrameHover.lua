--=========
-- Include
--=========

---@type FrameClass
local Frame = require('Class.Frame.Frame')

--=======
-- Class
--=======

---@type FrameHoverClass
local FrameHover = newClass('FrameHover', Frame)

---@class FrameHover
local public = FrameHover.public
---@class FrameHoverClass
local static = FrameHover.static
---@type table
local override = FrameHover.override
---@type table(FrameHover, table)
local private = {}

if not is_compiletime then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameHover
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameHover)
    local wc3_frame = BlzCreateFrameByType("FRAME", "FRAME", private.game_ui_frame, "", 0)
    instance = Frame.new(wc3_frame, instance)

    local priv = {
        tooltip = nil,
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    Frame.public.free(self)
end

---@param frame Frame
function public:setTooltip(frame)
    private[self].tooltip = frame
    BlzFrameSetTooltip(self:getFramehandle(), frame:getFramehandle())
end

---@return Frame
function public:getTooltip()
    return private[self].tooltip
end


return FrameHover