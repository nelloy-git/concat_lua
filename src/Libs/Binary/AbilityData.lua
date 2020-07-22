--=========
-- Include
--=========

--region Include
local lib_modename = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

---@type BinaryFileClass
local BinaryFile = require(lib_modename..'.File')
---@type BinaryDataClass
local BinaryData = require(lib_modename..'.Data')
---@type BinaryUtils
local BinaryUtils = require(lib_modename..'.Utils')
--endregion

--=======
-- Class
--=======

local BinaryDataAbility = Class.new('BinaryDataAbility', BinaryData)
--region Class
---@class BinaryDataAbility : BinaryData
local public = BinaryDataAbility.public
---@class BinaryDataAbilityClass : BinaryDataClass
local static = BinaryDataAbility.static
---@type BinaryDataAbilityClass
local override = BinaryDataAbility.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param new_id number
---@param base_id number
---@param name string | nil
---@param child_instance BinaryDataAbility | nil
---@return BinaryDataAbility
function override.new(new_id, base_id, name, child_instance)
    checkTypeErr(new_id, 'number', 'new_id')
    checkTypeErr(base_id, 'number', 'base_id')
    if name then checkTypeErr(name, 'string', 'name') end
    if child_instance then checkTypeErr(child_instance, BinaryDataAbility, 'child_instance') end

    local instance = child_instance or Class.allocate(BinaryDataAbility)
    instance = BinaryData.new(new_id, base_id, name, instance)
    private.newData(instance)

    private.file:add(instance)

    return instance
end

--========
-- Public
--========

---@param value_id string
---@param value_type string | "'bool'" | "'int'" | "'real'" | "'unreal'" | "'string'"
---@param extra_id number
---@param lvl number
---@param value any
function public:setValue(value_id, value_type, extra_id, lvl, value)
    checkTypeErr(value_id, 'string', 'value_id')
    if not (value_type == 'bool' or
       value_type == 'int' or
       value_type == 'real' or
       value_type == 'unreal' or
       value_type == 'string') then
        Log:err('Unavailable \'value_type\'. Got '..value_type, 2)
    end
    checkTypeErr(extra_id, 'number', 'extra_id')
    checkTypeErr(lvl, 'number', 'lvl')
    checkTypeErr(value, value_type, 'value')

    local priv = private.data[self]
    local value_data = priv.values[value_id] or {}
    value_data.value_type = value_type
    value_data.extra_id = extra_id
    value_data.values = value_data.values or {}
    value_data.values[lvl] = value
    priv.values[value_id] = value_data
end

---@return string
function public:serialize()
    local priv = private.data[self]

    -- Header
    local head = BinaryUtils.id2byte(self:getBaseId())..   -- Base (parent's) id
                 BinaryUtils.id2byte(self:getId())         -- New id
    local changes_count = 0

    local bytes = ''
    for value_id, value_data in pairs(priv.values) do
        local value_type = value_data.value_type
        local extra_id = value_data.extra_id
        local values = value_data.values

        for lvl, value in pairs(values) do
            bytes = bytes..
                    value_id..
                    private.type_to_bytes[value_type]..
                    BinaryUtils.int2byte(lvl)..
                    BinaryUtils.int2byte(extra_id)..
                    private.value_to_bytes[value_type](value)..
                    '\0\0\0\0'
            changes_count = changes_count + 1
        end
    end

    bytes = head..
            BinaryUtils.int2byte(changes_count)..   -- Changes count
            bytes

    return bytes
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self BinaryDataAbility
---@param lvls number
function private.newData(self, lvls)
    local priv = {
        values = {},
    }
    private.data[self] = priv
end

private.type_to_bytes = {
    bool = BinaryUtils.int2byte(0),
    int = BinaryUtils.int2byte(0),
    real = BinaryUtils.int2byte(1),
    unreal = BinaryUtils.int2byte(2),
    string = BinaryUtils.int2byte(3),
}

private.value_to_bytes = {
    bool = BinaryUtils.int2byte,
    int = BinaryUtils.int2byte,
    real = BinaryUtils.float2byte,
    unreal = BinaryUtils.float2byte,
    string = BinaryUtils.str2byte,
}

local sep = Compiletime(package.config:sub(1,1))
private.file = BinaryFile.new((GetDstDir and GetDstDir() or '')..sep..'war3map.w3a')
CompileFinal(function() private.file:save() end)

return static