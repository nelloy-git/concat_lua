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

---@return bytes
function public:serialize()
    local priv = private[self]

    if not private.checkNils(self) then
        return nil
    end

    local change_id_bytes = priv.change_id
    local data_type_bytes = WeUtils.type2bytes(priv.data_type)
    local lvl_bytes = priv.lvl_or_variation and WeUtils.int2byte(priv.lvl_or_variation) or ''
    local abil_data_id_bytes = priv.abil_data_id and WeUtils.int2byte(priv.abil_data_id) or ''
    local data_bytes = priv.data and WeUtils.data2byte(priv.data, priv.data_type) or ''

	return change_id_bytes..data_type_bytes..lvl_bytes..abil_data_id_bytes..data_bytes
end

function private.checkNils(self)
    local priv = private[self]

    if not priv.change_id then
        error(string.format("%s error: wrong change_id. Got nil",
                            getClassName(WeField)))
        return false
    end

    if not priv.data_type then
        error(string.format("%s error: wrong data type. Got nil",
                            getClassName(WeField)))
        return false
    end

    if not priv.data then
        error(string.format("%s error: wrong data. Got nil",
                            getClassName(WeField)))
        return false
    end

    return true
end

return WeField