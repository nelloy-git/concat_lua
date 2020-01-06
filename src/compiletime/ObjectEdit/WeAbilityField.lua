--=========
-- Include
--=========

local Class = require('Utils.Class')
local WeField = require('compiletime.ObjectEdit.WeField')

---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeAbilityField = Class.newClass('WeAbilityField', WeField)
---@class WeAbilityField : WeField
local public = WeAbilityField.public
---@class WeAbilityFieldClass : WeFieldClass
local static = WeAbilityField.static
local override = WeAbilityField.override
local private = {}

--========
-- Static
--========

---@param field_id string | number
---@param data_type WeFieldDataType
---@param abil_data_id integer
---@param name string
---@param require_level boolean
---@param test_data_func WeFieldTestDataFunc | nil
---@param child_data WeAbilityField | nil
---@return WeField
function override.new(field_id, data_type, abil_data_id, name, require_level, test_data_func, child_data)
    local instance = Class.newInstanceData(WeAbilityField, child_data)
    instance = WeField.new(field_id, data_type, name, test_data_func, instance)
    private.newData(instance, abil_data_id, require_level, test_data_func)

    return instance
end

--========
-- Public
--========

---@return string
function public:serialize(lvl, data)
    local priv = private[self]

    local change_id_bytes = self:getId()
    local data_type_bytes = WeField.type2bytes(self:getDataType())
    local lvl_bytes = WeUtils.int2byte(lvl)
    local abil_data_id_bytes = WeUtils.int2byte(priv.abil_data_id)
    local data_bytes = WeField.data2bytes(data, self:getDataType())

	return change_id_bytes..data_type_bytes..lvl_bytes..abil_data_id_bytes..data_bytes
end

---@return boolean
function public:isValid(data, lvl)
    local priv = private[self]
    if priv.test_data_func then
        return private.checkType(self, data, lvl) and priv.test_data_func(self, data)
    else
        return private.checkType(self, data, lvl)
    end
end

function public:free()
   private.freeData(self)
   WeField.public.free(self)
end

--=========
-- Private
--=========

---@param self WeAbilityField
---@param data any
---@param lvl number
---@return boolean
function private.checkType(self, data, lvl)
    local priv = private[self]
    local data_type = self:getDataType()

    local res = false
    if data_type == 'string' and type(data) == 'string' then
        res = true
    end
    if data_type == 'int' and type(data) == 'number' and data % 1 == 0 then
        res = true
    end
    if data_type == 'bool' and type(data) == 'boolean' then
        res = true
    end
    if (data_type == 'real' or data_type == 'unreal') and type(data) == 'number' then
        res = true
    end

    if not res then
        local msg = string.format('wrong data type. Got %s. Need %s.\n%s',
                                   type(data), data_type, WeUtils.getErrorPos())
        Log(Log.Warn, self:getName(), msg)
        return false
    end

    if lvl == 0 and priv.require_level then
        local msg = string.format('requires level.\n%s', WeUtils.getErrorPos())
        Log(Log.Warn, self:getName(), msg)
        return false
    end

    if lvl ~= 0 and not priv.require_level then
        local msg = string.format('does not require level.\n%s', WeUtils.getErrorPos())
        Log(Log.Warn, self:getName(), msg)
        return false
    end

    return true
end

---@param self WeAbilityField
---@param abil_data_id integer
function private.newData(self, abil_data_id, require_level, test_data_func)
    local priv = {
        abil_data_id = abil_data_id,
        require_level = require_level,
        test_data_func = test_data_func,
    }
    private[self] = priv
end

---@param self WeAbilityField
function private.freeData(self)
    private[self] = nil
end

return WeAbilityField