--=========
-- Include
--=========

local Class = require('Utils.Class')

require('utils.Globals')
local Log = require('utils.Log')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeField = Class.newClass('WeField')

---@class WeField
local public = WeField.public
---@class WeFieldClass
local static = WeField.static
---@type table
local override = WeField.override
---@type table(WeField, table)
local private = {}

--=========
-- Methods
--=========

---@param change_id string | number
---@param data_type string|"'bool'"|"'int'"|"'real'"|"'unreal'"|"'string'"
---@param name string
---@param check_data_func fun(self:WeField, vararg:any):boolean
---@param instance_data table | nil
---@return WeField
function static.new(change_id, data_type, name, check_data_func, instance_data)

    if not WeUtils.isDataType(data_type) then
        local err = string.format("wrong data type. Got: %s. Available: bool, int, real, unreal, string\n%s",
                                   data_type, WeUtils.getErrorPos())
        Log(Log.Err, getClassName(WeField), err)
        return nil
    end

    local instance = instance_data or Class.newInstanceData(WeField)
    local priv = {
        change_id = ID2str(change_id),
        data_type = data_type,
        name = name,
        check_data_func = check_data_func
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

---@return string
function public:getChangeId()
    local priv = private[self]
    return priv.change_id
end

---@return string|"'bool'"|"'int'"|"'real'"|"'unreal'"|"'string'"
function public:getDataType()
    local priv = private[self]
    return priv.data_type
end

function public:getName()
    local priv = private[self]
    return priv.name
end

---@return string
function public:serialize(data)
    local priv = private[self]

    local change_id_bytes = priv.change_id
    local data_type_bytes = WeUtils.type2bytes(priv.data_type)
    local data_bytes = WeUtils.data2byte(data, priv.data_type)

    return change_id_bytes..data_type_bytes..data_bytes
end

---@return boolean
function public:checkData(...)
    local priv = private[self]
    return priv.check_data_func(self, ...)
end


return WeField