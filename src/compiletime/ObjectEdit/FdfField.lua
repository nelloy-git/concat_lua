--=========
-- Include
--=========

--=======
-- Class
--=======

---@type FdfFieldClass
local FdfField = newClass('FdfField')

---@class FdfField
local public = FdfField.public
---@class FdfFieldClass
local static = FdfField.static
---@type table
local override = FdfField.override
---@type table(FdfField, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfField
function static.new(name, val_type, instance_data)
    local instance = instance_data or newInstanceData(FdfField)
    local priv = private.new(instance, name, val_type)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

---@return string
function public:getName()
    return private.get(self).name
end

---@param value string
---@return boolean
function public:checkType(value)
    return type(value) == private.get(self).val_type
end

--=========
-- Private
--=========

local private_data = {}
---@param self FdfField
---@return FdfFieldPrivate
function private.new(self, name, val_type)
    ---@class FdfFieldPrivate
    local priv = {
        name = name,
        val_type = val_type
    }
    private_data[self] = priv
    return priv
end

---@param self FdfField
---@return FdfFieldPrivate
function private.get(self)
    return private_data[self]
end

---@param self FdfField
function private.free(self)
    private_data[self] = nil
end

return FdfField