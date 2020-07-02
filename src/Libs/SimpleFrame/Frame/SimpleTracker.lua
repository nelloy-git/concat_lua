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
local HandlePublic = Class.getPublic(UtilsLib.Handle.Base)
local Log = UtilsLib.DefaultLogger
local Timer = UtilsLib.Handle.Timer

---@type SimpleBaseFrameClass
local SimpleBaseFrame = require(lib_modname..'.Frame.SimpleBase')
local SimpleBaseFramePublic = Class.getPublic(SimpleBaseFrame)
---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.FdfEdit.Frame')

--=======
-- Class
--=======

local SimpleTracker = Class.new('SimpleTracker', SimpleBaseFrame)
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

---@param fdf_simpleframe FdfFrame
---@param child_instance SimpleTracker | nil
---@return SimpleTracker
function override.new(fdf_simpleframe, child_instance)
    checkType(fdf_simpleframe, FdfFrame, 'fdf_simpleframe')
    if child_instance then
        checkType(child_instance, SimpleTracker, 'child_instance')
    end

    if #fdf_simpleframe:getTextures() ~= 1 then
        Log:err('fdf_frame must have one texture subframe.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleTracker)
    instance = SimpleBaseFrame.new(fdf_simpleframe, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param tooltip SimpleBaseFrame
function public:setTooltip(tooltip)
    -- Get real tooltip
    local cur_tooltip = SimpleBaseFramePublic.getTooltip(self)
    local cur_tooltip_fdf = cur_tooltip:getFdf()
    if cur_tooltip_fdf == private.FdfMouseDetector then
        cur_tooltip:destroy()
    end

    if not tooltip then
        tooltip = SimpleBaseFrame.new(private.FdfMouseDetector)
    end

    SimpleBaseFramePublic.setTooltip(self, tooltip)
end

---@return SimpleBaseFrame | nil
function public:getTooltip()
    -- Get real tooltip
    local cur_tooltip = SimpleBaseFramePublic.getTooltip(self)
    local cur_tooltip_fdf = cur_tooltip:getFdf()
    -- FdfMouseDetector is hidden.
    if cur_tooltip_fdf == private.FdfMouseDetector then
        return nil
    end
    return cur_tooltip
end

function public:isMouseOver()
    local tooltip = SimpleBaseFramePublic.getTooltip(self)
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

function public:destroy()
    local tooltip = self:getTooltip()
    local tooltip_fdf = tooltip:getFdf()
    if tooltip_fdf == private.FdfMouseDetector then
        tooltip:destroy()
    end
    HandlePublic.destroy(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.local_player = GetLocalPlayer and GetLocalPlayer() or nil
private.FdfMouseDetector = FdfFrame.new('DefaultMouseDetector', 'SIMPLEFRAME')

---@param self SimpleTracker
function private.newData(self)
    local priv = {
        mouse_is_inside = false,

        mouse_enter_actions = {},
        mouse_leave_actions = {}
    }
    private.data[self] = priv
    SimpleBaseFramePublic.setTooltip(self, SimpleBaseFrame.new(private.FdfMouseDetector))
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