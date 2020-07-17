--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Handle.Action
local checkType = UtilsLib.Functions.checkType
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
local Trigger = UtilsLib.Handle.Trigger

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_modname..'.Normal.Base')
local FrameNormalBasePublic = Class.getPublic(FrameNormalBase)
---@type FrameNormalImageClass
local FrameNormalImage = require(lib_modname..'.Normal.Image')

---@type FdfNormalBackdropClass
local FdfNormalBackdrop = require(lib_modname..'.Fdf.Frame.NormalBackdrop')
---@type FdfNormalHighlightClass
local FdfNormalHighlight = require(lib_modname..'.Fdf.Frame.NormalHighlight')
---@type FdfNormalGlueTextButtonClass
local FdfNormalGlueTextButton = require(lib_modname..'.Fdf.Frame.NormalGlueTextButton')
---@type FdfNormalTextClass
local FdfNormalText = require(lib_modname..'.Fdf.Frame.NormalText')

--=======
-- Class
--=======

local FrameNormalButton = Class.new('FrameNormalButton', FrameNormalBase)
---@class FrameNormalButton : FrameNormalBase
local public = FrameNormalButton.public
---@class FrameNormalButtonClass : FrameNormalBaseClass
local static = FrameNormalButton.static
---@type FrameNormalButtonClass
local override = FrameNormalButton.override
local private = {}

--=========
-- Static
--=========

---@alias FrameNormalButtonCallback fun(frame:FrameNormalButton, player:player, event:frameeventtype)

---@param fdf_or_handle FdfNormalGlueTextButton | framehandle
---@param child_instance FrameNormalButton | nil
---@return FrameNormalButton
function override.new(fdf_or_handle, child_instance)
    if not (checkType(fdf_or_handle, 'framehandle') or checkType(fdf_or_handle, FdfNormalGlueTextButton)) then
        Log:err('variable \'fdf_frame\'('..tostring(fdf_or_handle)..') is not of type framehandle or '..tostring(FdfNormalGlueTextButton), 2)
    end
    if child_instance then checkTypeErr(child_instance, FrameNormalBase, 'child_instance') end

    local instance = child_instance or Class.allocate(FrameNormalButton)
    instance = FrameNormalBase.new(fdf_or_handle, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param event frameeventtype
---@param callback FrameNormalButtonCallback
---@return Action
function public:addAction(event, callback)
    private.isEventAvailable(event)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.actions[event], action)

    return action
end

---@param action Action
---@return boolean
function public:removeAction(action)
    checkTypeErr(action, Action, 'action')

    local priv = private.data[self]

    for event, list in pairs(priv.actions) do
        for i = 1, #list do
            if list[i] == action then
                table.remove(list, i)
                return true
            end
        end
    end

    return false
end

function public:destroy()
    private.data[self].trigger:destroy()
    FrameNormalBasePublic.destroy(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.available_events = {
    [FRAMEEVENT_CONTROL_CLICK or 1] = true,
    [FRAMEEVENT_MOUSE_ENTER or 2] = true,
    [FRAMEEVENT_MOUSE_LEAVE or 3] = true,
    [FRAMEEVENT_MOUSE_UP or 4] = true,
    [FRAMEEVENT_MOUSE_DOWN or 5] = true,
    [FRAMEEVENT_MOUSE_WHEEL or 6] = true,
}

---@param self FrameNormalButton
function private.newData(self)
    local priv = {
        trigger = Trigger.new(),

        actions = {},
    }
    private.data[self] = priv

    priv.trigger:addAction(private.runActions)
    for event, _ in pairs(private.available_events) do
        priv.actions[event] = {}
        priv.trigger:addFrameEvent(self:getHandleData(), event)
    end
end

function private.runActions()
    local button = static.getLinked(BlzGetTriggerFrame())
    local player = GetTriggerPlayer()
    local event = BlzGetTriggerFrameEvent()

    local actions_list = private.data[button].actions[event]

    for i = 1, #actions_list do
        actions_list[i]:run(button, player, event)
    end
end

---@param event frameeventtype
function private.isEventAvailable(event)
    if not private.available_events[event] then
        Log:err('Event is not available for '..tostring(FrameNormalButton), 2)
    end
end

return static