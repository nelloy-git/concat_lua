--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')

--=======
-- Class
--=======

local AbilityExtTypeTargeting = Class.new('AbilityExtTypeTargeting')
---@class AbilityExtTypeTargetingClass
local static = AbilityExtTypeTargeting.static
---@type AbilityExtTypeTargetingClass
local override = AbilityExtTypeTargeting.override
local private = {}

--========
-- Static
--========

---@return AbilityExt | nil
function override.getCurrent()
    return private.abil
end

---@alias AbilityExtTypeTargetingCancelCallback fun(abil:AbilityExt)
---@alias AbilityExtTypeTargetingFinishCallback fun(abil:AbilityExt, target:any)

---@param abil AbilityExt
---@param cancel_cb AbilityExtTypeTargetingCancelCallback | nil
---@param finish_cb AbilityExtTypeTargetingFinishCallback | nil
function static.start(abil, cancel_cb, finish_cb)
    if private.abil then
        private.abil:targetingCancel(private.abil)
    end

    private.abil = abil
    private.abil_cancel_action = cancel_cb and Action.new(cancel_cb) or nil
    private.abil_finish_action = finish_cb and Action.new(finish_cb) or nil
end

---@param abil AbilityExt
function static.cancel(abil)
    if abil ~= private.abil then
        return
    end

    local cancel = private.abil_cancel_action

    private.abil = nil
    private.abil_cancel_action = nil
    private.abil_finish_action = nil

    if cancel then
        cancel:run(abil)
    end
end

---@param abil AbilityExt
---@param target any
function static.finish(abil, target)
    if abil ~= private.abil then
        return
    end

    local finish = private.abil_finish_action

    private.abil = nil
    private.abil_cancel_action = nil
    private.abil_finish_action = nil

    if finish then
        finish:run(abil, target)
    end
end

--=========
-- Private
--=========

private.abil = nil
private.abil_cancel_action = nil
private.abil_finish_action = nil

return static