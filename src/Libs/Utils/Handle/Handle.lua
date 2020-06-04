--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type LoggerClass
local Logger = require(lib_modname..'.Logger')
local Log = Logger.getDefault()
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkType = Functions.checkType

--=======
-- Class
--=======

local Handle = Class.new('Handle')
---@class Handle
local public = Handle.public
---@class HandleClass
local static = Handle.static
---@type HandleClass
local override = Handle.override
local private = {}

--=========
-- Static
--=========

--- Creates Handle instance and link it to the handle data.
---@param handle handle
---@param child_instance Handle | nil
---@return Handle
function override.new(handle, destructor, child_instance)
    checkType(handle, 'handle', 'handle')
    checkType(destructor, 'function', 'destructor')
    if child_instance then
        checkType(child_instance, Handle, 'child_instance')
    end

    if private.db[handle] then
        Log:err('handle data can have only one connected Handle instance.', 2)
    end

    local instance = child_instance or Class.allocate(Handle)
    private.newData(instance, handle, destructor)

    return instance
end

--- Returns Handle instance linked to the handle data.
---@param handle handle
---@return Handle
function static.getLinked(handle)
    return private.db[handle]
end

--========
-- Public
--========

--- Returns handle data.
---@return handle
function public:getHandleData()
    return private.data[self].handle
end

--- Destroy handle data.
function public:destroy()
    local priv = private.data[self]

    private.db[priv.handle] = nil
    private.data[self] = nil
    if priv.handle then
        priv.destructor(priv.handle)
    end
    priv.handle = nil
    priv.destructor = nil
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.db = setmetatable({}, {__mode = 'kv'})

---@param self Handle
---@param handle handle
function private.newData(self, handle, destructor)
    local priv = {
        handle = handle,
        destructor = destructor
    }
    private.data[self] = priv
    private.db[Handle] = self
end

return static