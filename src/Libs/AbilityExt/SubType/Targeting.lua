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

local AbilityExtSubTypeTargeting = Class.new('AbilityExtSubTypeTargeting')
---@class AbilityExtSubTypeTargeting
local public = AbilityExtSubTypeTargeting.public
---@class AbilityExtSubTypeTargetingClass
local static = AbilityExtSubTypeTargeting.static
---@type AbilityExtSubTypeTargetingClass
local override = AbilityExtSubTypeTargeting.override
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

---@param child AbilityExtSubTypeTargeting | nil
---@return AbilityExtSubTypeTargeting
function override.new(child)
    if child then isTypeErr(child, AbilityExtSubTypeTargeting, 'child') end

    local instance = child or Class.allocate(AbilityExtSubTypeTargeting)

    return instance
end

--========
-- Public
--========

---@param abil AbilityExt
---@return boolean
function public:start(abil)
    -- Wrong use of system
    if private.data[abil] then
        Log:err(tostring(AbilityExtSubTypeTargeting)..
                ': can not start ability targeting. Already targeting.')
    end

    -- Example
    private.data[abil] = Timer.new()
    private.data[abil]:start(3, false, function()
        private.data[abil]:destroy()
        private.data[abil] = nil

        if private.callback[abil] then
            private.callback[abil]:run(abil, abil:getOwner())
        end
        private.callback[abil] = nil
    end)
end

---@param abil AbilityExt
---@return boolean
function public:isStarted(abil)
    if private.data[abil] then
        return true
    end
    return false
end

---@param abil AbilityExt
function public:cancel(abil)
    if private.data[abil] then
        private.data[abil]:destroy()
    end
    private.data[abil] = nil
end

---@param abil AbilityExt
function public:forceFinish(abil)
    if private.data[abil] then
        private.data[abil]:destroy()
    end
    private.data[abil] = nil

    if private.callback[abil] then
        private.callback[abil]:run(abil, abil:getOwner())
    end
    private.callback[abil] = nil
end

---@alias AbilityExtSubTypeTargetingCallback fun(abil:AbilityExt, target:any)

---@param abil AbilityExt
---@param callback AbilityExtSubTypeTargetingCallback | nil
function public:setFinishAction(abil, callback)
    private.callback[abil] = callback and Action.new(callback) or nil
end

--=========
-- Private
--=========

private.data = {}
private.callback = {}

return static