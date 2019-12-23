--=========
-- Include
--=========

---@type FrameClass
local Frame = require('Class.Frame.Frame')

--=======
-- Class
--=======

---@type FrameOverlayClass
local FrameOverlay = newClass('FrameOverlay', Frame)

---@class FrameOverlay : Frame
local public = FrameOverlay.public
---@class FrameOverlayClass : FrameClass
local static = FrameOverlay.static
---@type table
local override = FrameOverlay.override
---@type table(FrameOverlay, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FrameOverlay
function static.new(instance_data)
    local instance = instance_data or newInstanceData(FrameOverlay)
    local priv = private.new(instance)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

--=========
-- Private
--=========

local private_data = {}
---@param self FrameOverlay
---@return FrameOverlayPrivate
function private.new(self)
    ---@class FrameOverlayPrivate
    local priv = {
    }
    private_data[self] = priv
    return priv
end

---@param self FrameOverlay
---@return FrameOverlayPrivate
function private.get(self)
    return private_data[self]
end

---@param self FrameOverlay
function private.free(self)
    private_data[self] = nil
end

return FrameOverlay