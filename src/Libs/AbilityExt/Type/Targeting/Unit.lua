--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Arc = HandleLib.Figure.Arc or error('')
local Timer = HandleLib.Timer or error('')
local Trigger = HandleLib.Trigger or error('')
local Unit = HandleLib.Unit or error('')
---@type InputLib
local Input = lib_dep.Input or error('')

---@type AbilityExtTypeTargetingClass
local AbilityExtTypeTargeting = require(lib_path..'Type.Targeting')
---@type AbilityExtSettings
local Settings = require(lib_path..'Settings')

--=======
-- Class
--=======

local AbilityExtTypeTargetingUnit = Class.new('AbilityExtTypeTargetingUnit')
---@class AbilityExtTypeTargetingUnitClass
local static = AbilityExtTypeTargetingUnit.static
---@type AbilityExtTypeTargetingUnitClass
local override = AbilityExtTypeTargetingUnit.override
local private = {}

--========
-- Static
--========

---@alias AbilityExtTypeTargetingUnitFinishCallback fun(abil:AbilityExt, target:Unit)

---@param abil AbilityExt
---@param cancel_cb AbilityExtTypeTargetingCancelCallback | nil
---@param finish_cb AbilityExtTypeTargetingUnitFinishCallback | nil
function override.start(abil, cancel_cb, finish_cb)
    AbilityExtTypeTargeting.start(abil, cancel_cb, finish_cb)

    -- Disable unit selection
    Input.lockSelection(true)

    private.mouse_action = private.trigger:addAction(function() private.mouseUpCallback(abil) end)
    private.tracking = true
    private.circle:setVisible(true)

    if private.previous then
        private.previous:setColor(1, 1, 1, 1)
    end
end

---@param abil AbilityExt
function override.cancel(abil)
    if abil ~= AbilityExtTypeTargeting.getCurrent() then
        return
    end

    Input.lockSelection(false)

    private.trigger:removeAction(private.mouse_action)
    private.tracking = false
    private.circle:setVisible(false)

    AbilityExtTypeTargeting.cancel(abil)

    if private.previous then
        private.previous:setColor(1, 1, 1, 1)
    end
end

---@param abil AbilityExt
function override.finish(abil)
    if abil ~= AbilityExtTypeTargeting.getCurrent() then
        return
    end

    Input.lockSelection(false)

    private.trigger:removeAction(private.mouse_action)
    private.tracking = false
    private.circle:setVisible(false)

    local target = Unit.getLinked(BlzGetMouseFocusUnit())
    AbilityExtTypeTargeting.finish(abil, target)

    if private.previous then
        private.previous:setColor(1, 1, 1, 1)
    end
end

--=========
-- Private
--=========

function private.mouseUpCallback(abil)
    if GetTriggerPlayer() ~= GetLocalPlayer() then
        return
    end

    local btn = BlzGetTriggerPlayerMouseButton()
    if btn == MOUSE_BUTTON_TYPE_LEFT then
        static.finish(abil)
    else
        static.cancel(abil)
    end
end

private.tracking = false
private.previous = nil
private.circle = nil
function private.mouseTrack()
    if not private.tracking then
        return
    end

    local hovered_unit = Unit.getLinked(BlzGetMouseFocusUnit())
    --if hovered_unit == private.previous then
    --    return
    --end

    if private.previous then
        private.previous:setColor(1, 1, 1, 1)
    end

    local tx
    local ty
    if hovered_unit then
        hovered_unit:setColor(1, 0.3, 0.3, 1)

        tx = hovered_unit:getX()
        ty = hovered_unit:getY()
    else
        tx = Input.getMouseX()
        ty = Input.getMouseY()
    end
    
    private.circle:setPosPolar(tx, ty, 25, 0, 2 * math.pi)
    private.previous = hovered_unit
end

if not IsCompiletime() then
    private.trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local pl = Player(i)
        if GetPlayerController(pl) == MAP_CONTROL_USER and
           GetPlayerSlotState(pl) == PLAYER_SLOT_STATE_PLAYING then
            private.trigger:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, pl)
        end
    end
    private.mouse_action = nil

    private.timer = Timer.new()
    private.timer:start(0.03125, true, private.mouseTrack)

    private.circle = Arc.new(18)
end

return static