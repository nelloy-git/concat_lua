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

--=======
-- Class
--=======

local AbilityExtTypeTargetingUnit = Class.new('AbilityExtTypeTargetingUnit', AbilityExtTypeTargeting)
---@class AbilityExtTypeTargetingUnit
local public = AbilityExtTypeTargetingUnit.public
---@class AbilityExtTypeTargetingUnitClass
local static = AbilityExtTypeTargetingUnit.static
---@type AbilityExtTypeTargetingUnitClass
local override = AbilityExtTypeTargetingUnit.override
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

---@alias AbilityExtTypeTargetingUnitFinishCallback fun(abil:AbilityExt, target:Unit)

---@param abil AbilityExt
---@param cancel_cb AbilityExtTypeTargetingCancelCallback | nil
---@param finish_cb AbilityExtTypeTargetingUnitFinishCallback | nil
---@return boolean
function override.start(abil, cancel_cb, finish_cb)
    AbilityExtTypeTargeting.start(abil, cancel_cb, finish_cb)
    private.abil = abil
    
end

---@return boolean
function static.isTargeting()
    return private.abil and true or false
end

function override.cancel()
    private.abil = nil
    AbilityExtTypeTargeting.cancel()
end

function override.finish()
    private.abil = nil

    local target = Unit.getLinked(BlzGetMouseFocusUnit())
    AbilityExtTypeTargeting.finish(target)
end

--=========
-- Private
--=========

private.abil = nil

function private.mouseUpCallback()
    if not static.isTargeting() then
        return
    end

    local btn = BlzGetTriggerPlayerMouseButton()
    if btn == MOUSE_BUTTON_TYPE_LEFT then
        static.finish()
    else
        static.cancel()
    end
end

if IsCompiletime() then
    private.trigger = Trigger.new()
    private.trigger:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, GetLocalPlayer())
    private.trigger:addAction(private.mouseUpCallback)
end

return static