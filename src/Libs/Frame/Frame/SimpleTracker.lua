--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Action
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local HandlePublic = Class.getPublic(UtilsLib.Handle.Base)
local Timer = UtilsLib.Handle.Timer

---@type SimpleBaseFrameClass
local SimpleBaseFrame = require(lib_modname..'.Frame.SimpleBase')
---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.FdfEdit.Frame')

--=======
-- Class
--=======

local SimpleTracker = Class.new('SimpleTracker')
---@class SimpleTracker : SimpleBaseFrame
local public = SimpleTracker.public
---@class SimpleTrackerClass : SimpleBaseFrameClass
local static = SimpleTracker.static
---@type SimpleTrackerClass
local override = SimpleTracker.override
local private = {}

--=========
-- Static
--=========

local inited = false
---@param mouse_check_period number
function override.Init(mouse_check_period)
    if IsCompiletime() or inited then
        return
    end

    local timer = Timer.new()
    timer:start(mouse_check_period, true, private.detectMouseLoop)
    inited = true
end

---@param frame SimpleBaseFrame
---@param child_instance SimpleTracker | nil
---@return SimpleTracker
function override.new(frame, child_instance)
    checkTypeErr(frame, SimpleBaseFrame, 'fdf_simpleframe')
    if child_instance then
        checkTypeErr(child_instance, SimpleTracker, 'child_instance')
    end

    local instance = child_instance or Class.allocate(SimpleTracker)
    private.newData(instance, frame)

    return instance
end

--========
-- Public
--========

function public:isMouseOver()
    local priv = private.data[self]

    local tooltip = priv.original_get_tooltip(priv.frame)
    return tooltip:getVisible()
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseEnterAction(callback)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.mouse_enter_actions, action)

    return action
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseLeaveAction(callback)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.mouse_leave_actions, action)

    return action
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for i = 1, #priv.mouse_enter_actions do
        if action == priv.mouse_enter_actions[i] then
            table.remove(priv.mouse_enter_actions, i)
            return true
        end
    end

    for i = 1, #priv.mouse_leave_actions do
        if action == priv.mouse_leave_actions[i] then
            table.remove(priv.mouse_leave_actions, i)
            return true
        end
    end

    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.frame2tracker = setmetatable({}, {__mode = 'v'})

private.local_player = GetLocalPlayer and GetLocalPlayer() or nil
private.FdfMouseDetector = FdfFrame.new('DefaultMouseDetector', 'SIMPLEFRAME')

---@param self SimpleTracker
---@param frame SimpleBaseFrame
function private.newData(self, frame)
    local priv = {
        frame = frame,
        tracker = frame:getTooltip() or SimpleBaseFrame.new(private.FdfMouseDetector),
        original_set_tooltip = frame.setTooltip,
        original_get_tooltip = frame.getTooltip,

        mouse_is_inside = false,

        mouse_enter_actions = {},
        mouse_leave_actions = {}
    }
    private.data[self] = priv
    private.frame2tracker[frame] = self

    if not frame:getTooltip() then
        frame:setTooltip(priv.tracker)
    end
    frame.setTooltip = private.setFrameTooltip
    frame.getTooltip = private.getFrameTooltip
end

---@param frame SimpleBaseFrame
---@param tooltip SimpleBaseFrame
function private.setFrameTooltip(frame, tooltip)
    local self = private.frame2tracker[frame]
    local priv = private.data[self]

    -- Get real tooltip
    local cur_tooltip = priv.original_get_tooltip(frame)
    local cur_tooltip_fdf = cur_tooltip:getFdf()

    if cur_tooltip_fdf == private.FdfMouseDetector then
        cur_tooltip:destroy()
    end

    if not tooltip then
        tooltip = SimpleBaseFrame.new(private.FdfMouseDetector)
    end

    priv.tracker = tooltip
    private.data[self].original_set_tooltip(frame, tooltip)
end

---@param frame SimpleBaseFrame
---@return SimpleBaseFrame | nil
function private.getFrameTooltip(frame)
    local tracker = private.frame2tracker[frame]

    -- Get real tooltip
    local cur_tooltip = private.data[tracker].original_get_tooltip(frame)
    local cur_tooltip_fdf = cur_tooltip:getFdf()
    -- FdfMouseDetector is hidden.
    if cur_tooltip_fdf == private.FdfMouseDetector then
        return nil
    end
    return cur_tooltip
end

function private.detectMouseLoop()
    for tracker, priv in pairs(private.data) do
        local inside = tracker:isMouseOver()
        -- Mouse was not inside in previous loop and entered.
        if inside and not priv.mouse_is_inside then
            for i = 1, #priv.mouse_enter_actions do
                priv.mouse_enter_actions[i]:run(tracker)
            end
        end
        -- Mouse was inside in previous loop and left.
        if not inside and priv.mouse_is_inside then
            for i = 1, #priv.mouse_leave_actions do
                priv.mouse_leave_actions[i]:run(tracker)
            end
        end
        priv.mouse_is_inside = inside
    end
end

return static