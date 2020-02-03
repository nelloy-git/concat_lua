--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameClass
local Frame = require('Class.Frame.Frame')

--=======
-- Class
--=======

local FrameSimpleText = Class.new('FrameSimpleText', Frame)
---@class FrameSimpleText : Frame
local public = FrameSimpleText.public
---@class FrameSimpleTextClass : FrameClass
local static = FrameSimpleText.static
---@type FrameSimpleTextClass
local override = FrameSimpleText.override
local private = {}

--=========
-- Static
--=========

---@param simple_button_type SimpleButtonType
---@param child_instance FrameSimpleText
---@return FrameSimpleText
function override.new(simple_button_type, child_instance)
    local instance = child_instance or Class.allocate(FrameSimpleText)
    instance = Frame.new(simple_button_type, instance)
    private.newData(instance, simple_button_type)

    return instance
end

--========
-- Public
--========

---@param texture string
function public:setTexture(texture)
    local priv = private[self]
    priv.texture = texture
    -- Remember its simpleframe
    BlzFrameSetTexture(priv.texture_framehandle, texture, 0, true)
end

---@return string
function public:getTexture()
    return private[self].texture
end

---@param callback Callback
---@return Action | nil
function public:addAction(callback)
    local priv = private[self]

    if not priv.trigger then
        priv.trigger = Trigger.new()
        priv.trigger:addFrameEvent(self:getFramehandle(), FRAMEEVENT_CONTROL_CLICK)
    end

    return priv.trigger:addAction(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local res = private[self].trigger:removeAction(action)
    if res and priv.trigger and priv.trigger:countActions() <= 0 then
        priv.trigger:free()
    end
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

---@param instance FrameSimpleText
---@param simple_button_type SimpleButtonType
function private.newData(instance, simple_button_type)
    local priv = {
        texture_framehandle = BlzGetFrameByName(simple_button_type:getTextureName(), 0),

        texture = '',
        trigger = nil,
    }
    private[instance] = priv
end

---@param instance FrameSimpleText
function private.freeData(instance)
    private[instance] = nil
end

return static