--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local Class = Lib.current().depencies.Class

---@type LoggerClass
local Logger = require(lib_modname..'.Logger')
local Log = Logger.getDefault()
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkType = Functions.checkType

--=======
-- Class
--=======

local CompiletimeData = Class.new('CompiletimeData')
---@class CompiletimeData
local public = CompiletimeData.public
---@class CompiletimeDataClass
local static = CompiletimeData.static
---@type CompiletimeDataClass
local override = CompiletimeData.override
local private = {}

--========
-- Static
--========

---@param unique_name string
---@return CompiletimeData
function override.new(unique_name)
    checkType(unique_name, 'string', 'unique_name')

    if IsCompiletime() then
        if private.instances[unique_name] then
            Log:err('Name must be unique.', 2)
        end
        private.instances[unique_name] = {}
    end

    local instance = Class.allocate(CompiletimeData)
    private.newData(instance, unique_name)

    return instance
end

--========
-- Public
--========

---@param key string
---@param value string
function public:set(key, value)
    checkType(key, 'string', 'key')
    checkType(value, 'string', 'value')

    private[self].data[key] = value
end

---@param key string
---@return string
function public:get(key)
    checkType(key, 'string', 'key')

    return private[self].data[key]
end

--=========
-- Private
--=========

private.instances = {}
CompiletimeFinalToRuntime(function()
    private.instances = Compiletime(private.instances)
end)

---@param instance CompiletimeData
---@param uniq_name string
function private.newData(instance, uniq_name)
    local priv = {
        name = uniq_name,
        data = private.instances[uniq_name]
    }
    private[instance] = priv
end

return static