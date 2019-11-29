--=========
-- Include
--=========

---@type Frame
local Frame = require('Class.Frame.Frame')

--=======
-- Class
--=======

---@type FrameBackdropClass
local FrameBackdrop = newClass('FrameBackdrop', Frame)

---@class FrameBackdrop
local public = FrameBackdrop.public
---@class FrameBackdropClass
local static = FrameBackdrop.static
---@type table
local override = FrameBackdrop.override
---@type table(FrameBackdrop, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameBackdrop
function override.new(parent, instance_data)
    local instance = instance_data or newInstanceData(FrameBackdrop)
    local priv = {
        parent = parent,
        wc3_frame = BlzCreateFrameByType("BACKDROP", "BACKDROP", parent, "", 0)
    }
    private[instance] = priv

    instance = Frame.new(instance)

    return instance
end

function public:free()
    local priv = private[self]
    BlzDestroyFrame(priv.wc3_frame)

    private[self] = nil
    Frame.public.free(self)
end

function public:setTexture()
    local priv = private[self]
    BlzFrameSetTexture(frame: framehandle, texFile: string, flag: integer, blend: boolean)
end

return FrameBackdrop