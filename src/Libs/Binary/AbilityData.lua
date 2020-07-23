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

---@type BinaryDataAbilityDB
local AbilDB = require(lib_modename..'.AbilityValuesDB')
---@type BinaryFileClass
local BinaryFile = require(lib_modename..'.File')
---@type BinaryDataClass
local BinaryData = require(lib_modename..'.Data')
---@type BinaryUtils
local BinaryUtils = require(lib_modename..'.Utils')

local FourCC = function(id) return string.unpack(">I4", id) end
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

---@param value number
function public:setLevels(value)
    private.setValue(self, AbilDB.Levels, nil, 0, value)
end

---@param value string
function public:setArtCaster(value)
    private.setValue(self, AbilDB.ArtCaster, nil, 0, value)
end

---@param value string
function public:setArtEffect(value)
    private.setValue(self, AbilDB.ArtEffect, nil, 0, value)
end

---@param value string
function public:setArtSpecial(value)
    private.setValue(self, AbilDB.ArtSpecial, nil, 0, value)
end

---@param value string
function public:setArtTarget(value)
    private.setValue(self, AbilDB.ArtTarget, nil, 0, value)
end

-- ANcl

---@param value number
---@param lvl number
function public:setArtDuration(value, lvl)
    private.setValue(self, AbilDB.ANcl.ArtDuration, FourCC('ANcl'), lvl, value)
end

---@param value string
---@param lvl number
function public:setOrderId(value, lvl)
    private.setValue(self, AbilDB.ANcl.OrderId, FourCC('ANcl'), lvl, value)
end

---@param value boolean
---@param lvl number
function public:setDisableOtherAbilities(value, lvl)
    private.setValue(self, AbilDB.ANcl.DisableOtherAbilities, FourCC('ANcl'), lvl, value)
end

---@param value number
---@param lvl number
function public:setFollowThoughTime(value, lvl)
    private.setValue(self, AbilDB.ANcl.FollowThoughTime, FourCC('ANcl'), lvl, value)
end

---@param visible boolean
---@param target_image boolean
---@param physical boolean
---@param universal boolean
---@param uniq boolean
---@param lvl number
function public:setOptions(visible, target_image, physical, universal, uniq, lvl)
    local value = 0
    value = visible and value + 1 or value
    value = target_image and value + 2 or value
    value = physical and value + 4 or value
    value = universal and value + 8 or value
    value = uniq and value + 16 or value
    private.setValue(self, AbilDB.ANcl.Options, FourCC('ANcl'), lvl, value)
end

---@param target string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
---@param lvl any
function public:setTargetType(target, lvl)
    local value = nil
    value = target == 'None' and 0 or value
    value = target == 'Unit' and 1 or value
    value = target == 'Point' and 2 or value
    value = target == 'PointOrUnit' and 3 or value
    if value == nil then
        Log:err('Unavailable target type.', 2)
    end

    private.setValue(self, AbilDB.ANcl.TargetType, FourCC('ANcl'), lvl, value)
end

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

---@param self BinaryDataAbility
---@param db table
---@param avaliable_base_id number | nil
---@param lvl number
---@param value any
function private.setValue(self, db, avaliable_base_id, lvl, value)
    if avaliable_base_id and self:getBaseId() ~= avaliable_base_id then
        Log:err('Function is not available for this basic ability.', 3)
    end
    checkTypeErr(lvl, 'number', 'lvl', 3)
    self:setValue(db.value_id, db.value_type, db.extra_id, lvl, value)
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