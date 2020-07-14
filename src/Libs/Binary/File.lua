--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

---@type BinaryDataClass
local BinaryData = require(lib_modname..'.Data')

--=======
-- Class
--=======

local BinaryFile = Class.new('BinaryFile')
---@class BinaryFile
local public = BinaryFile.public
---@class BinaryFileClass
local static = BinaryFile.static
---@type BinaryFileClass
local override = BinaryFile.override
local private = {}

--========
-- Static
--========

---@param path string
---@param child_instance BinaryFile | nil
---@return BinaryFile
function override.new(path, child_instance)
    checkTypeErr(path, 'string', 'path')
    if child_instance then checkTypeErr(child_instance, BinaryFile, 'child_instance') end

    local instance = child_instance or Class.allocate(BinaryFile)
    private.newData(instance, path)

    return instance
end

--========
-- Public
--========

---@param data BinaryData
function public:add(data)
    checkTypeErr(data, BinaryData, 'data')
    table.insert(private.data[self].data, data)
end

function public:save()
    local priv = private.data[self]
    local char = string.char

    -- Create header
    local bytes = char(2)..char(0)..char(0)..char(0)..  -- file version
                  char(0)..char(0)..char(0)..char(0)..  -- object tables
                  private.int2bytes(#priv.data)         -- changes count

    for i = 1, #priv.data do
        bytes = bytes..priv.data[i]:serialize()
    end

    local f = assert(io.open(priv.path, "w"))
    f:write(bytes)
    f:close()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self BinaryFile
---@param path string
function private.newData(self, path)
    local priv = {
        path = path,
        data = {}
    }
    private.data[self] = setmetatable(priv, private.metadata)
end

---@param data integer
---@return string
function private.int2bytes(data)
    local bytes = ''
    for i = 0, 3 do
        bytes = bytes..string.char(data >> (8 * i) & 0xFF)
    end
    return bytes
end

return static