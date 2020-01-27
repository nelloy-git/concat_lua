--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

local FrameSimple = Class.new('FrameSimple')
---@class FrameSimple
local public = FrameSimple.public
---@class FrameSimpleClass
local static = FrameSimple.static
---@type FrameSimpleClass
local override = FrameSimple.override
local private = {}

--=========
-- Static
--=========

---@param simple_type FrameSimpleType
---@param child_instance FrameSimple | nil
---@return FrameSimple
function static.new(simple_type, child_instance)
    local instance = child_instance or Class.allocate(FrameSimple)
    private.newData(instance, simple_type)

    return instance
end

--========
-- Public
--========

function public:setX(x)
    local priv = private[self]
    priv.x = x
    BlzFrameSetAbsPoint(priv.main_frame, FRAMEPOINT_BOTTOMLEFT, x, priv.y)
end

function public:setY(y)
    local priv = private[self]
    priv.y = y
    BlzFrameSetAbsPoint(priv.main_frame, FRAMEPOINT_BOTTOMLEFT, priv.x, y)
end

function public:setTexture(texture)
    BlzFrameSetTexture(private[self].texture_frame, texture, 0, true)
end

function public:setText(text)
    BlzFrameSetText(private[self].string_frame, text)
end

function public:setFont(font, size)
    BlzFrameSetFont(private[self].string_frame, font, size, 0)
end

function public:setVisible(flag)
    BlzFrameSetVisible(private[self].main_frame, flag)
end

function public:setTooltip(simple_frame)
    BlzFrameSetTooltip(private[self].main_frame, private[simple_frame].main_frame)
    BlzFrameSetVisible(private[simple_frame].main_frame, false)
end

function public:setOnClick(callback)
    priv = private[self]
    if not priv.on_click_trigger then
        priv.on_click_trigger = Trigger.new()
        priv.on_click_trigger:addFrameEvent(priv.main_frame, FRAMEEVENT_CONTROL_CLICK)
    elseif priv.on_click_action then
        priv.on_click_trigger:removeAction(priv.on_click_action)
    end
    priv.on_click_trigger:addAction(callback)
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

if not IsCompiletime() then
    private.game_ui = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

---@param instance FrameSimple
---@param simple_type FrameSimpleType
function private.newData(instance, simple_type)
    local main_frame = BlzCreateSimpleFrame(simple_type:getName(), private.game_ui, 0)
    local texture_frame = BlzGetFrameByName(simple_type:getTextureFrameName(), 0)
    local string_frame = BlzGetFrameByName(simple_type:getStringFrameName(), 0)

    local priv = {
        main_frame = main_frame,
        texture_frame = texture_frame,
        string_frame = string_frame,

        x = 0,
        y = 0,

        on_click_trigger = nil,
        on_click_action = nil
    }
    private[instance] = priv
end

---@param instance FrameSimple
function private.freeData(instance)
    local priv = private[instance]
    if priv.on_click_trigger then
        priv.on_click_trigger:free()
    end
    private[instance] = nil
end

return static