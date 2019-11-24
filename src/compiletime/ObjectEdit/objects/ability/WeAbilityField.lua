--=========
-- Include
--=========

---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')

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

---data type = "'bool'"|"'int'"|"'real'"|"'unreal'"|"'string'"
---@param change_id string | number
---@param data_type string
---@param lvl_or_variation integer|nil
---@param abil_data_id integer|nil
---@param data string|boolean|integer|number
---@param instance_data table | nil
---@return WeField
function static.new(change_id, data_type, lvl_or_variation, abil_data_id, data, instance_data)
    local instance = instance_data or newInstanceData(WeField)
    local priv = {
        change_id = ID2str(change_id),
        data_type = data_type,
        lvl_or_variation = lvl_or_variation,
        abil_data_id = abil_data_id,
        data = data
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

---@return string
function public:serialize()
    local priv = private[self]

    local change_id_bytes = priv.change_id
    local data_type_bytes = WeUtils.type2bytes(priv.data_type)
    local lvl_bytes = priv.lvl_or_variation and WeUtils.int2byte(priv.lvl_or_variation) or ''
    local abil_data_id_bytes = priv.abil_data_id and WeUtils.int2byte(priv.abil_data_id) or ''
    local data_bytes = priv.data and WeUtils.data2byte(priv.data, priv.data_type) or ''

	return change_id_bytes..data_type_bytes..lvl_bytes..abil_data_id_bytes..data_bytes
end

return WeAbilityField