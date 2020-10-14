--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Timer = HandleLib.Timer
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local AbilityExtTypeTargeting = Class.new('AbilityExtTypeTargeting')
---@class AbilityExtTypeTargeting
local public = AbilityExtTypeTargeting.public
---@class AbilityExtTypeTargetingClass
local static = AbilityExtTypeTargeting.static
---@type AbilityExtTypeTargetingClass
local override = AbilityExtTypeTargeting.override
local virtual = {}
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

---@alias AbilityExtTypeTargetingCancelCallback fun(abil:AbilityExt)
---@alias AbilityExtTypeTargetingFinishCallback fun(abil:AbilityExt, target:any)

---@param abil AbilityExt
---@param cancel_cb AbilityExtTypeTargetingCancelCallback | nil
---@param finish_cb AbilityExtTypeTargetingFinishCallback | nil
---@return boolean
function static.start(abil, cancel_cb, finish_cb)
    if private.abil then
        Log:err(tostring(AbilityExtTypeTargeting)..
                ': can not start ability targeting. Already targeting.')
    end

    private.abil = abil
    private.cancel_action = cancel_cb and Action.new(cancel_cb) or nil
    private.finish_action = finish_cb and Action.new(finish_cb) or nil
end

---@return boolean
function static.isTargeting()
    return private.abil and true or false
end

function static.cancel()
    if private.abil == nil then
        Log:err(tostring(AbilityExtTypeTargeting)..
                ': can not cancel targeting. Is not targeting.')
    end

    local abil = private.abil
    local cancel = private.cancel_action

    private.abil = nil
    private.cancel_action = nil
    private.finish_action = nil

    if cancel then
        cancel:run(abil)
    end
end

---@param target any
function static.finish(target)
    if private.abil == nil then
        Log:err(tostring(AbilityExtTypeTargeting)..
                ': can not finish targeting. Is not targeting.')
    end

    local abil = private.abil
    local finish = private.data[abil].finish

    private.abil = nil
    private.cancel_action = nil
    private.finish_action = nil

    if finish then
        finish:run(abil, target)
    end
end

--=========
-- Private
--=========

private.abil = nil
private.cancel_action = nil
private.finish_action = nil

return static