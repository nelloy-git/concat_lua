--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')

--=======
-- Class
--=======

local Highlight = Class.new('Highlight', Frame)
---@class Highlight : Frame
local public = Highlight.public
---@class HighlightClass : FrameClass
local static = Highlight.static
---@type HighlightClass
local override = Highlight.override

local private = {}

--========
-- Static
--========

---@param highlight_type HighlightType
---@param child_data Highlight | nil
---@return Highlight
function override.new(highlight_type, child_data)
    local instance = child_data or Class.allocate(Highlight)
    instance = Frame.new(highlight_type, instance)
    private.newData(instance, highlight_type)

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

---@param self Highlight
---@param highlight_type HighlightType
function private.newData(self, highlight_type)
    local priv = {
        texture = highlight_type:getTexture()(),
    }

    private.data[self] = priv
end

return static