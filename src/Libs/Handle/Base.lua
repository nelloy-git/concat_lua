--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class
---@type UtilsLib
local UtilsLib = lib_dep.Utils
local isTypeErr = UtilsLib.isTypeErr
local Log = UtilsLib.Log

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
---@param child Handle | nil
---@return Handle
function override.new(handle, destructor, child)
    if not handle then
        Log:err('variable \'handle\' can not be nil.', 2)
    end
    isTypeErr(destructor, 'function', 'destructor')
    if child then isTypeErr(child, Handle, 'child') end

    -- Errors
    if child and private.data[child] then
        Log:err('Handle instance already has connected handle.', 2)
    end

    if private.db[handle] then
        Log:err('handle data can have only one connected Handle instance. Old: '..tostring(private.db[handle])..' New: '..tostring(child), 2)
    end

    local instance = child or Class.allocate(Handle)
    private.newData(instance, handle, destructor)

    return instance
end

--- Returns Handle instance linked to the handle data.
---@param handle handle
---@return Handle
function static.getLinked(handle)
    return private.db[handle]
end

----- Removes linked instance for handle.
-----@param handle handle
--function static.removeLinked(handle)
--    local linked = private.db[handle]
--    private.data[linked] = nil
--    private.db[handle] = nil
--end

--========
-- Public
--========

--- Returns handle data.
---@return handle
function public:getData()
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