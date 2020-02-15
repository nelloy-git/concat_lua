--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')

--=======
-- Class
--=======

local Backdrop = Class.new('Backdrop', Frame)
---@class Backdrop : Frame
local public = Backdrop.public
---@class BackdropClass : FrameClass
local static = Backdrop.static
---@type BackdropClass
local override = Backdrop.override

local private = {}

--========
-- Static
--========

---@param backdrop_type BackdropType
---@param child_data Backdrop | nil
---@return Backdrop
function override.new(backdrop_type, child_data)
    local instance = child_data or Class.allocate(Backdrop)
    instance = Frame.new(backdrop_type, instance)
    private.newData(instance, backdrop_type)

    return instance
end

--========
-- Public
--========

---@param texture string
function public:setTexture(texture)
    local priv = private.data[self]
    priv.texture = texture
    BlzFrameSetTexture(self:getObj(), texture, 0, true)
end

---@return string
function public:getTexture()
    return private[self].texture
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Backdrop
---@param backdrop_type BackdropType
function private.newData(self, backdrop_type)
    local priv = {
        texture = backdrop_type:getBackground(),
    }

    private.data[self] = priv
end

return static