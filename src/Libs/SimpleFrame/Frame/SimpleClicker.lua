--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Action
local checkType = UtilsLib.Functions.checkType
local Trigger = UtilsLib.Handle.Trigger

---@type SimpleTrackerClass
local SimpleTracker = require(lib_modname..'.Frame.SimpleTracker')
---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.FdfEdit.Frame')

--=======
-- Class
--=======

local SimpleClicker = Class.new('SimpleClicker', SimpleTracker)
---@class SimpleClicker : SimpleTracker
local public = SimpleClicker.public
---@class SimpleClickerClass : SimpleTrackerClass
local static = SimpleClicker.static
---@type SimpleClickerClass
local override = SimpleClicker.override
local private = {}

--=========
-- Static
--=========

local inited = false
function override.Init()
    if IsCompiletime() or inited then
        return
    end

    local trigger_up = Trigger.new()
    trigger_up:addPlayerEvent(EVENT_PLAYER_MOUSE_DOWN, private.local_player)
    trigger_up:addAction(function() private.mouseCallback(true) end)

    local trigger_down = Trigger.new()
    trigger_down:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, private.local_player)
    trigger_down:addAction(function() private.mouseCallback(false) end)

    inited = true
end

---@param fdf_simplebutton FdfFrame
---@param child_instance SimpleClicker | nil
---@return SimpleClicker
function override.new(fdf_simplebutton, child_instance)
    checkType(fdf_simplebutton, FdfFrame, 'fdf_simplebutton')
    if child_instance then
        checkType(child_instance, SimpleClicker, 'child_instance')
    end

    local instance = child_instance or Class.allocate(SimpleClicker)
    instance = SimpleTracker.new(fdf_simplebutton, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseDownAction(mouse_btn, callback)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.actions_down[mouse_btn], action)

    return action
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseUpAction(mouse_btn, callback)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.actions_up[mouse_btn], action)

    return action
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseClickAction(mouse_btn, callback)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.actions_click[mouse_btn], action)

    return action
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    if private.removeAction(priv, action, MOUSE_BUTTON_TYPE_LEFT) then
        return true
    elseif private.removeAction(priv, action, MOUSE_BUTTON_TYPE_RIGHT) then
        return true
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.local_player = GetLocalPlayer and GetLocalPlayer() or nil

---@param self SimpleClicker
function private.newData(self)
    local priv = {
        is_left_down = false,
        is_right_down = false,

        actions_up = {
            [MOUSE_BUTTON_TYPE_LEFT] = {},
            [MOUSE_BUTTON_TYPE_RIGHT] = {},
        },
        actions_down = {
            [MOUSE_BUTTON_TYPE_LEFT] = {},
            [MOUSE_BUTTON_TYPE_RIGHT] = {},
        },
        actions_click = {
            [MOUSE_BUTTON_TYPE_LEFT] = {},
            [MOUSE_BUTTON_TYPE_RIGHT] = {},
        },
    }
    private.data[self] = priv
end

---@param is_down boolean
function private.mouseCallback(is_down)
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for clicker, priv in pairs(private.data) do
        private.runActions(clicker, priv, mouse_btn, is_left, is_right, is_down)
    end
end

---@param self SimpleClicker
---@param priv table
---@param mouse_btn mousebuttontype
---@param is_left boolean
---@param is_right boolean
---@param is_down boolean
function private.runActions(self, priv, mouse_btn, is_left, is_right, is_down)
    if self:isMouseOver() then
        if is_down then
            private.runActionsList(self, priv.actions_down[mouse_btn])

            priv.is_left_down = priv.is_left_down or is_left
            priv.is_right_down = priv.is_right_down or is_right
        else
            private.runActionsList(self, priv.actions_up[mouse_btn])

            if (priv.is_left_down and is_left) or (priv.is_right_down and is_right) then
                private.runActionsList(self, priv.actions_click[mouse_btn])
            end
        end
    end

    if not is_down then
        priv.is_left_down = not is_left and priv.is_left_down
        priv.is_right_down = not is_right and priv.is_right_down
    end
end

---@param self SimpleClicker
function private.runActionsList(self, list)
    for i = 1, #list do
        list[i]:run(self)
    end
end

---@param action Action
---@param mouse_btn mousebuttontype
---@return boolean
function private.removeAction(priv, action, mouse_btn)
    for i = 1, #priv.actions_up[mouse_btn] do
        if action == priv.actions_up[mouse_btn][i] then
            table.remove(priv.actions_up, i)
            return true
        end
    end

    for i = 1, #priv.actions_down[mouse_btn] do
        if action == priv.actions_up[mouse_btn][i] then
            table.remove(priv.actions_up, i)
            return true
        end
    end

    for i = 1, #priv.actions_click[mouse_btn] do
        if action == priv.actions_up[mouse_btn][i] then
            table.remove(priv.actions_up, i)
            return true
        end
    end

    return false
end

return static