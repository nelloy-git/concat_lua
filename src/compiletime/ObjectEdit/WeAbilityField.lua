--=========
-- Include
--=========

---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeUtils
local WeUtils = require('compiletime.ObjectEdit.WeUtils')

--=======
-- Class
--=======

---@type WeAbilityFieldClass
local WeAbilityField = newClass('WeAbilityField', WeField)

---@class WeAbilityField : WeField
local public = WeAbilityField.public
---@class WeAbilityFieldClass : WeFieldClass
local static = WeAbilityField.static
---@type table
local override = WeAbilityField.override
---@type table(WeAbilityField, table)
local private = {}

--=========
-- Methods
--=========


---@param change_id string | number
---@param data_type string|"'bool'"|"'int'"|"'real'"|"'unreal'"|"'string'"
---@param abil_data_id integer
---@param name string
---@param instance_data table | nil
---@return WeField
function override.new(change_id, data_type, abil_data_id, name, check_data_func, instance_data)
    local instance = instance_data or newInstanceData(WeAbilityField)
    instance = WeField.new(change_id, data_type, name, check_data_func, instance)

    local priv = {
        abil_data_id = abil_data_id
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   WeField.public.free(self)
end

---@return string
function public:serialize(lvl, data)
    local priv = private[self]

    local change_id_bytes = self:getChangeId()
    local data_type_bytes = WeUtils.type2bytes(self:getDataType())
    local lvl_bytes = WeUtils.int2byte(lvl)
    local abil_data_id_bytes = WeUtils.int2byte(priv.abil_data_id)
    local data_bytes = WeUtils.data2byte(data, self:getDataType())

	return change_id_bytes..data_type_bytes..lvl_bytes..abil_data_id_bytes..data_bytes
end

return WeAbilityField