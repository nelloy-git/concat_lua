--=========
-- Include
--=========

--=======
-- Class
--=======

---@type AbilityTypeCallbacksContainerClass
local AbilityTypeCallbacksContainer = newClass('AbilityTypeCallbacksContainer')

---@class AbilityTypeCallbacksContainer
local public = AbilityTypeCallbacksContainer.public
---@class AbilityTypeCallbacksContainerClass
local static = AbilityTypeCallbacksContainer.static
---@type table
local override = AbilityTypeCallbacksContainer.override
---@type table(AbilityTypeCallbacksContainer, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return AbilityTypeCallbacksContainer
function static.new(instance_data)
    local instance = instance_data or newInstanceData(AbilityTypeCallbacksContainer)
    local priv = {
        start = nil,
        cancel = nil,
        casting = nil,
        finish = nil,
        interrupt = nil,
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

--- Callback have to return true if started successfully
---@param callback callback
function public:setStart(callback)
    local priv = private[self]
    priv.start = callback
end

--- Returns true by default.
---@return boolean
function public:runStart()
    local priv = private[self]
    return private.runcallbackSavety(priv.start)
end

---@param callback callback
function public:setCancel(callback)
    local priv = private[self]
    priv.cancel = callback
end

--- Returns true by default.
---@return boolean
function public:runCancel()
    local priv = private[self]
    return private.runcallbackSavety(priv.cancel)
end

--- Callback have to return true if casting period was successfull
---@param callback callback
function public:setCasting(callback)
    local priv = private[self]
    priv.casting = callback
end

--- Returns true by default.
---@return boolean
function public:runCasting()
    local priv = private[self]
    return private.runcallbackSavety(priv.casting)
end

---@param callback callback
function public:setFinish(callback)
    local priv = private[self]
    priv.finish = callback
end

--- Returns true by default.
---@return boolean
function public:runFinish()
    local priv = private[self]
    return private.runcallbackSavety(priv.finish)
end

---@param callback callback
function public:setInterrupt(callback)
    local priv = private[self]
    priv.interrupt = callback
end

--- Returns true by default.
---@return boolean
function public:runInterrupt()
    local priv = private[self]
    return private.runcallbackSavety(priv.interrupt)
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

return AbilityTypeCallbacksContainer