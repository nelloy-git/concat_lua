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

function override.new()
    return Class.allocate(AbilityExtTypeTargeting)
end

---@return AbilityExtTypeTargeting | nil
function override.getCurrent()
    return private.cur_targeting
end

--========
-- Public
--========

---@alias AbilityExtTypeTargetingCancelCallback fun(abil:AbilityExt)
---@alias AbilityExtTypeTargetingFinishCallback fun(abil:AbilityExt, target:any)

---@param abil AbilityExt
---@param cancel_cb AbilityExtTypeTargetingCancelCallback | nil
---@param finish_cb AbilityExtTypeTargetingFinishCallback | nil
function public:start(abil, cancel_cb, finish_cb)
    if private.cur_targeting then
        private.cur_targeting:cancel()
    end

    private.cur_targeting = self
    private.abil = abil
    private.cancel_action = cancel_cb and Action.new(cancel_cb) or nil
    private.finish_action = finish_cb and Action.new(finish_cb) or nil
end

---@return boolean
--function public:isTargeting()
--    return private.cur_targeting and true or false
--end

function public:cancel()
    if not private.cur_targeting then
        return
    end

    local abil = private.abil
    local cancel = private.cancel_action

    private.cur_targeting = nil
    private.abil = nil
    private.cancel_action = nil
    private.finish_action = nil

    if cancel then
        cancel:run(abil)
    end
end

---@param target any
function public:finish(target)
    if not private.cur_targeting then
        return
    end

    local abil = private.abil
    local finish = private.finish_action

    private.cur_targeting = nil
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

private.cur_targeting = nil
private.abil = nil
private.cancel_action = nil
private.finish_action = nil

return static