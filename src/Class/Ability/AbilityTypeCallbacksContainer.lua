--=========
-- Include
--=========

local Class = require('utils.Class.Class')

--=======
-- Class
--=======

local AbilityTypeCallbacksContainer = Class.new('AbilityTypeCallbacksContainer')
---@class AbilityTypeCallbacksContainer
local public = AbilityTypeCallbacksContainer.public
---@class AbilityTypeCallbacksContainerClass
local static = AbilityTypeCallbacksContainer.static
---@type AbilityTypeCallbacksContainerClass
local override = AbilityTypeCallbacksContainer.override
local private = {}

--========
-- Static
--========

---@param child_instance AbilityTypeCallbacksContainer | nil
---@return AbilityTypeCallbacksContainer
function static.new(child_instance)
    local instance = child_instance or Class.allocate(AbilityTypeCallbacksContainer)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Callback have to return true if started successfully
---@param callback Callback
function public:setStart(callback)
    local priv = private[self]
    priv.start = callback
end

--- Returns true by default.
---@return boolean
function public:runStart()
    local priv = private[self]
    return private.runCallbackSavety(priv.start)
end

---@param callback Callback
function public:setCancel(callback)
    local priv = private[self]
    priv.cancel = callback
end

--- Returns true by default.
---@return boolean
function public:runCancel()
    local priv = private[self]
    return private.runCallbackSavety(priv.cancel)
end

--- Callback have to return true if casting period was successfull
---@param callback Callback
function public:setCasting(callback)
    local priv = private[self]
    priv.casting = callback
end

--- Returns true by default.
---@return boolean
function public:runCasting()
    local priv = private[self]
    return private.runCallbackSavety(priv.casting)
end

---@param callback Callback
function public:setFinish(callback)
    local priv = private[self]
    priv.finish = callback
end

--- Returns true by default.
---@return boolean
function public:runFinish()
    local priv = private[self]
    return private.runCallbackSavety(priv.finish)
end

---@param callback Callback
function public:setInterrupt(callback)
    local priv = private[self]
    priv.interrupt = callback
end

--- Returns true by default.
---@return boolean
function public:runInterrupt()
    local priv = private[self]
    return private.runCallbackSavety(priv.interrupt)
end

function public:free()
   private.freeData(self)
   Class.free(self)
end

--=========
-- Private
--=========

---@param instance AbilityTypeCallbacksContainerClass
function private.newData(instance)
    local priv = {
        start = nil,
        cancel = nil,
        casting = nil,
        finish = nil,
        interrupt = nil,
    }
    private[instance] = priv
end

---@param instance AbilityTypeCallbacksContainerClass
function private.freeData(instance)
    private[instance] = nil
end

--- Returns true by default.
---@return boolean
function private.runCallbackSavety(callback)
    if not callback then
        return true
    end

    local success = callback()
    if type(success) == 'boolean' then
        return success
    end

    return true
end

return static