--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type AssetLib
local AssetLib = lib_dep.Asset or error('')
local AssetLoader = AssetLib.Loader or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type BinaryAbilityDB
local AbilDB = {}
AssetLoader.load(lib_path..'AbilityDB', AbilDB)
---@type BinaryFileClass
local BinaryFile = require(lib_path..'File') or error('')
---@type BinaryDataClass
local BinaryData = require(lib_path..'Data') or error('')
---@type BinaryUtils
local BinaryUtils = require(lib_path..'Utils') or error('')

local FourCC = function(id) return string.unpack(">I4", id) end

--=======
-- Class
--=======

local BinaryAbility = Class.new('BinaryAbility', BinaryData)
---@class BinaryAbility : BinaryData
local public = BinaryAbility.public
---@class BinaryAbilityClass : BinaryDataClass
local static = BinaryAbility.static
---@type BinaryAbilityClass
local override = BinaryAbility.override
local private = {}

--=========
-- Static
--=========

---@param new_id number
---@param base_id number
---@param name string | nil
---@param child BinaryAbility | nil
---@return BinaryAbility
function override.new(new_id, base_id, name, child)
    isTypeErr(new_id, 'number', 'new_id')
    isTypeErr(base_id, 'number', 'base_id')
    if name then isTypeErr(name, 'string', 'name') end
    if child then isTypeErr(child, BinaryAbility, 'child') end

    local instance = child or Class.allocate(BinaryAbility)
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

---@param value boolean
function public:setHero(value)
    private.setValue(self, AbilDB.HeroAbility, nil, 0, value)
end

---@param value string
function public:setHotkey(value)
    isTypeErr(value, 'string', 'value')
    if string.len(value) > 1 then
        Log:err('value length > 1.', 2)
    end
    private.setValue(self, AbilDB.HotkeyNormal, nil, 0, value)
end

function public:setButtonPositionNormal(x, y)
    private.setValue(self, AbilDB.ButtonPositionNormalX, nil, 0, x)
    private.setValue(self, AbilDB.ButtonPositionNormalY, nil, 0, y)
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
    private.setValue(self, AbilDB.ANcl.BaseOrderID, FourCC('ANcl'), lvl, value)
end

---@param value boolean
---@param lvl number
function public:setDisableOtherAbilities(value, lvl)
    private.setValue(self, AbilDB.ANcl.DisableOtherAbilities, FourCC('ANcl'), lvl, value)
end

---@param value number
---@param lvl number
function public:setFollowThoughTime(value, lvl)
    private.setValue(self, AbilDB.ANcl.FollowThroughTime, FourCC('ANcl'), lvl, value)
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
function public:setTargeting(target, lvl)
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

---@param list table<number, targettype>
---@param lvl number
function public:setTargetsAllowed(list, lvl)
    local val = ''
    for i = 1, #list do
        val = val..BinaryUtils.targetTypeToData(list[i])
        if i < #list then val = val..',' end
    end

    private.setValue(self, AbilDB.TargetsAllowed, nil, lvl, val)
end

---@param value_id string
---@param value_type string | "'bool'" | "'int'" | "'real'" | "'unreal'" | "'string'"
---@param extra_id number
---@param lvl number
---@param value any
function public:setValue(value_id, value_type, extra_id, lvl, value)
    isTypeErr(value_id, 'string', 'value_id')
    if not (value_type == 'bool' or
       value_type == 'int' or
       value_type == 'real' or
       value_type == 'unreal' or
       value_type == 'string') then
        Log:err('Unavailable \'value_type\'. Got '..value_type, 2)
    end
    isTypeErr(extra_id, 'number', 'extra_id')
    isTypeErr(lvl, 'number', 'lvl')
    isTypeErr(value, private.real_value_type[value_type], 'value')

    if value_type == 'bool' then
        value = value and 1 or 0
    end

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

---@param self BinaryAbility
---@param lvls number
function private.newData(self, lvls)
    local priv = {
        values = {},
    }
    private.data[self] = priv
end

---@param self BinaryAbility
---@param db table
---@param avaliable_base_id number | nil
---@param lvl number
---@param value any
function private.setValue(self, db, avaliable_base_id, lvl, value)
    if db == nil then
        Log:err('db == nil', 2)
    end
    if avaliable_base_id and self:getBaseId() ~= avaliable_base_id then
        Log:err('Function is not available for this basic ability.', 3)
    end
    isTypeErr(lvl, 'number', 'lvl', 3)
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

private.real_value_type = {
    bool = 'boolean',
    int = 'number',
    real = 'number',
    unreal = 'number',
    string = 'string',
}

local sep = Compiletime(package.config:sub(1,1))
private.file = BinaryFile.new((GetDstDir and GetDstDir() or '')..sep..'war3map.w3a')
CompileFinal(function() private.file:save() end)

return static