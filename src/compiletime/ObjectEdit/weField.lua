--=========
-- Include
--=========

require('utils.Globals')
---@type WeUtils
local WeUtils = require('compiletime.ObjectEdit.WeUtils')

--=======
-- Class
--=======

---@type WeFieldClass
local WeField = newClass('WeField')

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
---@param instance_data table | nil
---@return WeField
function static.new(change_id, data_type, name, instance_data)

    if not WeUtils.isDataType(data_type) then
        Debug("%s error: wrong data type. Got: %s", getClassName(WeField), data_type)
        Debug(WeUtils.getErrorPos())
        return nil
    end

    local instance = instance_data or newInstanceData(WeField)
    local priv = {
        change_id = ID2str(change_id),
        data_type = data_type,
        name = name
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
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
function public:serialize()
    local priv = private[self]

    local change_id_bytes = priv.change_id
    local data_type_bytes = WeUtils.type2bytes(priv.data_type)

    return change_id_bytes..data_type_bytes
end

return WeField