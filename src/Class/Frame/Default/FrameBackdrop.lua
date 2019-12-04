--=========
-- Include
--=========

---@type FrameClass
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

if not is_compiletime then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameBackdrop
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameBackdrop)
    local wc3_frame = BlzCreateFrameByType("BACKDROP", "BACKDROP", private.game_ui_frame, "", 0)
    instance = Frame.new(wc3_frame, instance)

    local priv = {
        texture = nil,
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    Frame.public.free(self)
end

function public:onTextureChange()
    local priv = private[self]
    BlzFrameSetTexture(self:getWc3Frame(self), priv.texture, 0, true)
end

---@param texture string
function public:setTexture(texture)
    private[self].texture = texture
    self:onTextureChange()
end

---@return string
function public:getTexture()
    return private[self].texture
end

return FrameBackdrop