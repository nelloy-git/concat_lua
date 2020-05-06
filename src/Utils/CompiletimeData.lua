--=========
-- Include
--=========


local Class = require('Utils.Class.API')

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
    if type(unique_name) ~= 'string' then
        unique_name = tostring(unique_name)
    end

    if IsCompiletime() then
        if private.instances[unique_name] then
            Log.error(CompiletimeData, 'name must be unique.', 2)
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
        Log.error(self, 'key must be string, number or table.', 2)
    end
    if not (val_type == 'string' or val_type == 'number' or val_type == 'table') then
        Log.error(self, 'value must be string, number or table.', 2)
    end
    private[self].data[key] = value
end

---@param key string | number | table
---@return string | number | table
function public:get(key)
    local key_type = type(key)
    if key_type ~= 'string' and key_type ~= 'number' and key_type ~= 'table' then
        Log.error(self, 'key must be string, number or table.', 2)
    end
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