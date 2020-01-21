--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

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
function static.new(unique_name)
    if type(unique_name) ~= 'string' then
        unique_name = tostring(unique_name)
    end
    if IsCompiletime() then
        if private.instances[unique_name] then
            Log.error(CompiletimeData, 'name must be unique,', 2)
            return
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

---@param key string | number | table
---@param value string | number | table
function public:set(key, value)
    local key_type = type(key)
    local val_type = type(value)
    if key_type ~= 'string' and key_type ~= 'number' and key_type ~= 'table' then
        Log.error(CompiletimeData, 'key must be string, number or table.', 2)
    end
    if not (val_type == 'string' or val_type == 'number' or val_type == 'table') then
        Log.error(CompiletimeData, 'value must be string, number or table.', 2)
    end
    private[self].data[key] = value
end

---@param key string | number | table
---@return string | number | table
function public:get(key)
    local key_type = type(key)
    if key_type ~= 'string' and key_type ~= 'number' and key_type ~= 'table' then
        Log.error(CompiletimeData, 'key must be string, number or table.', 2)
    end
    return private[self].data[key]
end

--=========
-- Private
--=========

private.instances = {}
CompiletimeFinalToRuntime(function()
    --for k, v in pairs(private.instances) do
    --    print(k, v)
    --end
    --print(private.instances)
    private.instances = Compiletime(private.instances)
end)

---@param instance CompiletimeData
---@param unitque_name string
function private.newData(instance, unitque_name)
    local priv = {
        name = unitque_name,
        data = private.instances[unitque_name]
    }
    private[instance] = priv
end

return static