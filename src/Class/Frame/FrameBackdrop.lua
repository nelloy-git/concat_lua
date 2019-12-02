--=========
-- Include
--=========

---@type FrameObjectClass
local FrameObject = require('Class.Frame.FrameObject')

--=======
-- Class
--=======

---@type FrameBackdropClass
local FrameBackdrop = newClass('FrameBackdrop', FrameObject)

---@class FrameBackdrop
local public = FrameBackdrop.public
---@class FrameBackdropClass
local static = FrameBackdrop.static
---@type table
local override = FrameBackdrop.override
---@type table(FrameBackdrop, table)
local private = {}

private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameBackdrop
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameBackdrop)
    local wc3_frame = BlzCreateFrameByType("BACKDROP", "BACKDROP", private.game_ui_frame, "", 0)
    instance = FrameObject.new(wc3_frame, instance)

    local priv = {
        texture = nil,
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    FrameObject.public.free(self)
end

---@param texture string
function public:setTexture(texture)
    private[self].texture = texture
    BlzFrameSetTexture(FrameObject.getWc3Frame(self), texture, 0, true)
end

---@return string
function public:getTexture()
    return private[self].texture
end

return FrameBackdrop