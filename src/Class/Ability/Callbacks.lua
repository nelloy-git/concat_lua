--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log') 

--=======
-- Class
--=======

local AbilityCallbacks = Class.new('AbilityCallbacksContainer')
---@class AbilityCallbacksContainer
local public = AbilityCallbacks.public
---@class AbilityCallbacksContainerClass
local static = AbilityCallbacks.static
---@type AbilityCallbacksContainerClass
local override = AbilityCallbacks.override
local private = {}

--========
-- Static
--========

---@alias AbilityCallback fun(cast_data:AbilityCastInstance):boolean
---@alias AbilityCastingTimeCallback fun(cast_data:AbilityCastInstance):number

---@param child_instance AbilityCallbacksContainer | nil
---@return AbilityCallbacksContainer
function static.new(child_instance)
    local instance = child_instance or Class.allocate(AbilityCallbacks)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Callback have to return true if started successfully
---@param callback AbilityCallback
function public:setStart(callback)
    if type(callback) == 'function' or type(callback) == nil then
        private[self].start = callback
        return
    end
    Log.error(AbilityCallbacks, 'callback must be function type or nil', 2)
end

---@param callback AbilityCallback
function public:setCancel(callback)
    if type(callback) == 'function' or type(callback) == nil then
        private[self].cancel = callback
        return
    end
    Log.error(AbilityCallbacks, 'callback must be function type or nil', 2)
end

--- Callback have to return true if casting period was successfull
---@param callback AbilityCallback
function public:setCasting(callback)
    if type(callback) == 'function' or type(callback) == nil then
        private[self].casting = callback
        return
    end
    Log.error(AbilityCallbacks, 'callback must be function type or nil', 2)
end

---@param callback AbilityCallback
function public:setFinish(callback)
    if type(callback) == 'function' or type(callback) == nil then
        private[self].finish = callback
        return
    end
    Log.error(AbilityCallbacks, 'callback must be function type or nil', 2)
end

---@param callback AbilityCallback
function public:setInterrupt(callback)
    if type(callback) == 'function' or type(callback) == nil then
        private[self].interrupt = callback
        return
    end
    Log.error(AbilityCallbacks, 'callback must be function type or nil', 2)
end

---@param callback AbilityCastingTimeCallback | number
function public:setCastingTime(callback)
    if type(callback) == 'function' or type(callback) == 'number' then
        private[self].casting_time = callback
        return
    end
    Log.error(AbilityCallbacks, 'callback must be function type or number', 2)
end

--- Returns true by default.
---@param cast_data AbilityCastInstance
---@return boolean
function public:runStart(cast_data)
    return private.runCallbackSavety(private[self].start, cast_data)
end

--- Returns true by default.
---@param cast_data AbilityCastInstance
---@return boolean
function public:runCancel(cast_data)
    return private.runCallbackSavety(private[self].cancel, cast_data)
end

--- Returns true by default.
---@param cast_data AbilityCastInstance
---@return boolean
function public:runCasting(cast_data)
    return private.runCallbackSavety(private[self].casting, cast_data)
end

--- Returns true by default.
---@param cast_data AbilityCastInstance
---@return boolean
function public:runFinish(cast_data)
    return private.runCallbackSavety(private[self].finish, cast_data)
end

--- Returns true by default.
---@param cast_data AbilityCastInstance
---@return boolean
function public:runInterrupt(cast_data)
    return private.runCallbackSavety(private[self].interrupt, cast_data)
end

--- Returns true by default.
---@param cast_data AbilityCastInstance
---@return number
function public:getCastingTime(cast_data)
    if type(private[self].casting_time) == 'function' then
        return private[self].casting_time(cast_data)
    else
        return private[self].casting_time
    end
end

function public:free()
   private.freeData(self)
   Class.free(self)
end

--=========
-- Private
--=========

---@param instance AbilityCallbacksContainerClass
function private.newData(instance)
    local priv = {
        start = nil,
        cancel = nil,
        casting = nil,
        finish = nil,
        interrupt = nil,
        casting_time = nil
    }
    private[instance] = priv
end

---@param instance AbilityCallbacksContainerClass
function private.freeData(instance)
    private[instance] = nil
end

--- Returns true by default.
---@param callback AbilityCallback
---@param cast_data AbilityCastInstance
---@return boolean
function private.runCallbackSavety(callback, cast_data)
    if not callback then
        return true
    end

    local success = callback(cast_data)
    if type(success) == 'boolean' then
        return success
    end

    return true
end

return static