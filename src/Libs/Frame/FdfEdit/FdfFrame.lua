--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class

--=======
-- Class
--=======

local FdfFrame = Class.new('FdfFrame')
---@class FdfFrame
local public = FdfFrame.public
---@class FdfFrameClass
local static = FdfFrame.static
---@type FdfFrameClass
local override = FdfFrame.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_type string
---@param child_instance FdfFrame | nil
---@return FdfFrame
function override.new(name, base_type, child_instance)
    local instance = child_instance or Class.allocate(FdfFrame)
    private.newData(instance, name, base_type)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].name
end

---@return string
function public:getBaseType()
    return private.data[self].base_type
end

---@param field FdfField
---@param value any
function public:setField(field, value)
    local priv = private.data[self]

    if not field then
        Log.error(self, 'unknown field', 2)
    end

    if not field:checkType(value) then
        local msg = string.format("check data failed. Field change ignored. Got: %s need: %s.\n%s",
                                  type(value), field:getType(), WeUtils.getErrorPos())
        Log.error(FdfFrame, msg, 2)
    end

    priv.field[field] = value
end

---@return any
function public:getField(field)
    return private.data[self].field[field]
end

function public:getAllFields()
    return private.data[self].field
end

---@return string
function public:serialize()
    local priv = private.data[self]

    local res = string.format("Frame \"%s\" \"%s\" {\n", priv.base_type, priv.name)
    for field, value in pairs(priv.field) do
        local field_serial = '    '..string.gsub(field:serialize(value), '\n', '\n    ')
        res = res..field_serial..'\n'
    end
    return res.."}"
end

---@return table
function public:toRuntime()
    local priv = private.data[self]

    local res = {
        name = priv.name,
        base_type = priv.base_type,
        field = {},
    }

    for field, value in pairs(priv.field) do
        if value == nil then
            res.field[field:getName()] = 'nil'

        elseif Class.type(value, FdfFrame) then
            res.field[field:getName()] = value:toRuntime()

        elseif Class.type(value, 'table') then
            local list = {}
            res.field[field:getName()] = list
            for j = 1, #value do
                if type(value[j]) == 'number' then
                    list[j] = value[j]
                else
                    list[value[j]:getName()] = value[j]:toRuntime()
                end
            end

        else
            res.field[field:getName()] = value
        end
    end

    return res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FdfFrame
---@return FdfFramePrivate
function private.newData(self, name, base_type)
    ---@class FdfFramePrivate
    local priv = {
        base_type = base_type,
        name = name,
        field = {}
    }
    private.data[self] = priv
end

return static