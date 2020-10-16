--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Trigger = HandleLib.Trigger or error('')
local Unit = HandleLib.Unit or error('')

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
    local selected = GetUnitsSelectedAll(GetLocalPlayer())
    EnableSelect(false, true)
    EnableDragSelect(false, true)

    SelectGroupBJ(selected)
    DestroyGroup(selected)

    private.mouse_action = private.trigger:addAction(private.mouseUpCallback)
    ForceUIKey(Settings.dummy_hotkey)
end

---@param abil AbilityExt
function override.cancel(abil)
    if abil ~= AbilityExtTypeTargeting.getCurrent() then
        return
    end

    EnableSelect(true, true)
    EnableDragSelect(true, true)

    private.trigger:removeAction(private.mouse_action)
    ForceUIKey('S')

    AbilityExtTypeTargeting.cancel(abil)
end

---@param abil AbilityExt
function override.finish(abil)
    if abil ~= AbilityExtTypeTargeting.getCurrent() then
        return
    end

    EnableSelect(true, true)
    EnableDragSelect(true, true)

    private.trigger:removeAction(private.mouse_action)
    ForceUIKey('S')

    local target = Unit.getLinked(BlzGetMouseFocusUnit())
    AbilityExtTypeTargeting.finish(abil, target)
end

--=========
-- Private
--=========

function private.mouseUpCallback()
    local btn = BlzGetTriggerPlayerMouseButton()
    if btn == MOUSE_BUTTON_TYPE_LEFT then
        AbilityExtTypeTargetingUnit:finish()
    else
        AbilityExtTypeTargetingUnit:cancel()
    end
end

if not IsCompiletime() then
    private.trigger = Trigger.new()
    private.trigger:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, GetLocalPlayer())
    private.mouse_action = nil
end

return AbilityExtTypeTargetingUnit