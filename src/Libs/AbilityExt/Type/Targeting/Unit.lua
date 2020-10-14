--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type BinaryLib
local BinaryLib = lib_dep.Binary or error('')
local BinAbil = BinaryLib.Ability or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Ability = HandleLib.Ability or error('')
local Timer = HandleLib.Timer or error('')
local Trigger = HandleLib.Trigger or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityExtTypeTargeting
local AbilityExtTypeTargeting = require(lib_path..'Type.Targeting')
local AbilityExtTypeTargetingPublic = Class.getPublic(AbilityExtTypeTargeting)

--========
-- Module
--========

local AbilityExtTypeTargetingUnit = AbilityExtTypeTargeting.new()

local function mouseUpCallback()
    local btn = BlzGetTriggerPlayerMouseButton()
    if btn == MOUSE_BUTTON_TYPE_LEFT then
        AbilityExtTypeTargetingUnit:finish()
    else
        AbilityExtTypeTargetingUnit:cancel()
    end
end


local trigger
local mouse_action
if not IsCompiletime() then
    trigger = Trigger.new()
    trigger:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, GetLocalPlayer())
end

---@alias AbilityExtTypeTargetingUnitFinishCallback fun(abil:AbilityExt, target:Unit)

---@param abil AbilityExt
---@param cancel_cb AbilityExtTypeTargetingCancelCallback | nil
---@param finish_cb AbilityExtTypeTargetingUnitFinishCallback | nil
function AbilityExtTypeTargetingUnit:start(abil, cancel_cb, finish_cb)
    AbilityExtTypeTargetingPublic.start(self, abil, cancel_cb, finish_cb)

    -- Disable unit selection
    local selected = GetUnitsSelectedAll(GetLocalPlayer())
    EnableSelect(false, true)
    EnableDragSelect(false, true)

    SelectGroupBJ(selected)
    DestroyGroup(selected)

    mouse_action = trigger:addAction(mouseUpCallback)
end

function AbilityExtTypeTargetingUnit:cancel()
    local cur = AbilityExtTypeTargeting.getCurrent()
    if self ~= cur then
        cur:cancel()
        return
    end

    EnableSelect(true, true)
    EnableDragSelect(true, true)

    trigger:removeAction(mouse_action)

    AbilityExtTypeTargetingPublic.cancel(self)
end

function AbilityExtTypeTargetingUnit:finish()
    local cur = AbilityExtTypeTargeting.getCurrent()
    if self ~= cur then
        return
    end

    EnableSelect(true, true)
    EnableDragSelect(true, true)

    trigger:removeAction(mouse_action)

    local target = Unit.getLinked(BlzGetMouseFocusUnit())
    AbilityExtTypeTargetingPublic.finish(self, target)
end

return AbilityExtTypeTargetingUnit