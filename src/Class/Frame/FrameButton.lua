--=========
-- Include
--=========

---@type Frame
local FrameObject = require('Class.Frame.FrameObject')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

---@type FrameButtonClass
local FrameButton = newClass('FrameButton', FrameObject)

---@class FrameButton
local public = FrameButton.public
---@class FrameButtonClass
local static = FrameButton.static
---@type table
local override = FrameButton.override
---@type table(FrameButton, table)
local private = {}

private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameButton
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameButton)
    local wc3_frame = BlzCreateFrameByType("BUTTON", "BUTTON", private.game_ui_frame, "", 0)
    instance = FrameObject.new(wc3_frame, instance)

    local priv = {
        texture = nil,

        on_press_trigger = nil,
        on_press_action = nil,

        on_mouse_enter_trigger = nil,
        on_mouse_enter_action = nil,

        on_mouse_leave_trigger = nil,
        on_mouse_leave_action = nil,

        on_mouse_release_trigger = nil,
        on_mouse_release_action = nil,

        on_mouse_wheel_trigger = nil,
        on_mouse_wheel_action = nil
    }
    private[instance] = priv

    return instance
end

function public:free()
    local priv = private[self]
    if priv.on_press_trigger then priv.on_press_trigger:free() end
    if priv.on_press_action then priv.on_press_action:free() end
    if priv.on_mouse_enter_trigger then priv.on_mouse_enter_trigger:free() end
    if priv.on_mouse_enter_action then priv.on_mouse_enter_action:free() end
    if priv.on_mouse_leave_trigger then priv.on_mouse_leave_trigger:free() end
    if priv.on_mouse_leave_action then priv.on_mouse_leave_action:free() end
    if priv.on_mouse_release_trigger then priv.on_mouse_release_trigger:free() end
    if priv.on_mouse_release_action then priv.on_mouse_release_action:free() end
    if priv.on_mouse_wheel_trigger then priv.on_mouse_wheel_trigger:free() end
    if priv.on_mouse_wheel_action then priv.on_mouse_wheel_action:free() end

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

---@param callback callback
function public:setPressCallback(callback)
    local priv = private[self]

    if not priv.on_press_trigger then
        priv.on_press_trigger = Trigger.new()
        priv.on_press_trigger:addFrameEvent(self:getWc3Frame(), FRAMEEVENT_CONTROL_CLICK)
    end

    if priv.on_press_action then
        priv.on_press_trigger:removeAction(priv.on_press_action)
    end
    priv.on_press_action = priv.on_press:addAction(callback)
end

---@param callback callback
function public:setMouseEnterCallback(callback)
    local priv = private[self]

    if not priv.on_mouse_enter_trigger then
        priv.on_mouse_enter_trigger = Trigger.new()
        priv.on_mouse_enter_trigger:addFrameEvent(self:getWc3Frame(), FRAMEEVENT_MOUSE_ENTER)
    end

    if priv.on_mouse_enter_action then
        priv.on_mouse_enter_trigger:removeAction(priv.on_mouse_enter_action)
    end
    priv.on_mouse_enter_action = priv.on_mouse_enter:addAction(callback)
end

---@param callback callback
function public:setMouseLeaveCallback(callback)
    local priv = private[self]

    if not priv.on_mouse_leave_trigger then
        priv.on_mouse_leave_trigger = Trigger.new()
        priv.on_mouse_leave_trigger:addFrameEvent(self:getWc3Frame(), FRAMEEVENT_MOUSE_LEAVE)
    end

    if priv.on_mouse_leave_action then
        priv.on_mouse_leave_trigger:removeAction(priv.on_mouse_leave_action)
    end
    priv.on_mouse_leave_action = priv.on_mouse_leave:addAction(callback)
end

---@param callback callback
function public:setMouseReleaseCallback(callback)
    local priv = private[self]

    if not priv.on_mouse_release_trigger then
        priv.on_mouse_release_trigger = Trigger.new()
        priv.on_mouse_release_trigger:addFrameEvent(self:getWc3Frame(), FRAMEEVENT_MOUSE_UP)
    end

    if priv.on_mouse_release_action then
        priv.on_mouse_release_trigger:removeAction(priv.on_mouse_release_action)
    end
    priv.on_mouse_release_action = priv.on_mouse_release:addAction(callback)
end

---@param callback callback
function public:setMouseWheelCallback(callback)
    local priv = private[self]

    if not priv.on_mouse_wheel_trigger then
        priv.on_mouse_wheel_trigger = Trigger.new()
        priv.on_mouse_wheel_trigger:addFrameEvent(self:getWc3Frame(), FRAMEEVENT_MOUSE_UP)
    end

    if priv.on_mouse_wheel_action then
        priv.on_mouse_wheel_trigger:removeAction(priv.on_mouse_wheel_action)
    end
    priv.on_mouse_wheel_action = priv.on_mouse_wheel:addAction(callback)
end

return FrameButton