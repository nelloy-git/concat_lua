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
local checkTypeErr = Functions.checkTypeErr

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
    checkTypeErr(destructor, 'function', 'destructor')
    if child_instance then
        checkTypeErr(child_instance, Handle, 'child_instance')
    end

    if child_instance and private.data[child_instance] then
        Log:err('Handle instance already has connected handle.', 2)
    end

    if private.db[handle] then
        Log:err('handle data can have only one connected Handle instance. Old: '..tostring(private.db[handle])..' New: '..tostring(child_instance), 2)
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

--- Removes linked instance for handle.
---@param handle handle
function static.removeLinked(handle)
    local linked = private.db[handle]
    private.data[linked] = nil
    private.db[handle] = nil
end

--========
-- Public
--========

--- Returns handle data.
---@return handle
function public:getHandleData()
    return private.data[self] and private.data[self].handle or nil
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

private.data = {}
private.db = setmetatable({}, {__mode = 'v'})

private.priv_meta = {
    __gc = function(priv)
        private.db[priv.handle] = nil
        if priv.handle then
            priv.destructor(priv.handle)
        end
        priv.handle = nil
        priv.destructor = nil
    end
}

---@param self Handle
---@param handle handle
function private.newData(self, handle, destructor)
    local priv = {
        handle = handle,
        destructor = destructor
    }
    private.data[self] = priv
    private.db[handle] = self
end

return static