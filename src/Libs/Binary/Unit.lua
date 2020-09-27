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

---@type BinaryFileClass
local BinaryFile = require(lib_path..'File') or error('')
---@type BinaryDataClass
local BinaryData = require(lib_path..'Data') or error('')
---@type BinaryUtils
local BinaryUtils = require(lib_path..'Utils') or error('')
---@type BinaryUnitDB
local UnitDB = {}
AssetLoader.load(lib_path..'UnitDB', UnitDB)

--=======
-- Class
--=======

local BinaryUnit = Class.new('BinaryUnit', BinaryData)
---@class BinaryUnit : BinaryData
local public = BinaryUnit.public
---@class BinaryUnitClass : BinaryDataClass
local static = BinaryUnit.static
---@type BinaryUnitClass
local override = BinaryUnit.override
local private = {}

--=========
-- Static
--=========

---@param new_id number
---@param base_id number
---@param name string | nil
---@param child BinaryUnit | nil
---@return BinaryUnit
function override.new(new_id, base_id, name, child)
    isTypeErr(new_id, 'number', 'new_id')
    isTypeErr(base_id, 'number', 'base_id')
    if name then isTypeErr(name, 'string', 'name') end
    if child then isTypeErr(child, BinaryUnit, 'child') end

    local instance = child or Class.allocate(BinaryUnit)
    instance = BinaryData.new(new_id, base_id, name, instance)

    private.file:add(instance)

    return instance
end

--========
-- Public
--========

local db_atk = {
    [1] = UnitDB.Attack1,
    [2] = UnitDB.Attack2
}

---------------
-- Abilities --
---------------

---@param time number
function public:setAnimationCastBackswing(time)
    local db = UnitDB.AnimationCastBackswing
    self:setValue(db.value_id, db.value_type, time)
end

---@param id_list table<number, string>
function public:setNormalAbilities(id_list)
    local abil_list = ''
    for i = 1, #id_list do
        abil_list = abil_list..id_list[i]..','
    end
    if #id_list > 0 then
        abil_list = abil_list:sub(1, abil_list:len() - 1)
    end

    local db = UnitDB.NormalAbilities
    self:setValue(db.value_id, db.value_type, abil_list)
end

---@param value number
function public:setMana(value)
    local db = UnitDB.ManaMaximum
    self:setValue(db.value_id, db.value_type, value)
end

---@param value number
function public:setManaRegeneration(value)
    local db = UnitDB.ManaRegeneration
    self:setValue(db.value_id, db.value_type, value)
end

---------------
-- Animation --
---------------

---@param time number
function public:setAnimationBlendTime(time)
    local db = UnitDB.AnimationBlendTimeseconds
    self:setValue(db.value_id, db.value_type, time)
end

---@param atk number
---@param value number
function public:setAttackAnimationBackswingPoint(atk, value)
    local db = db_atk[atk].AnimationBackswingPoint
    self:setValue(db.value_id, db.value_type, value)
end

---@param atk number
---@param value number
function public:setAttackAnimationDamagePoint(atk, value)
    local db = db_atk[atk].AnimationDamagePoint
    self:setValue(db.value_id, db.value_type, value)
end

------------
-- Attack --
------------

-- TODO AreaAttacks

---@param atk number
---@param value attacktype
function public:setAttackType(atk, value)
    local db = db_atk[atk].AttackType
    local str_type = BinaryUtils.attackTypeToData(value)
    self:setValue(db.value_id, db.value_type, str_type)
end

---@param atk number
---@param value number
function public:setAttackProjectileArc(atk, value)
    local db = db_atk[atk].ProjectileArc
    self:setValue(db.value_id, db.value_type, value)
end

---@param atk number
---@param model string
function public:setAttackProjectileArt(atk, model)
    local db = db_atk[atk].ProjectileArt
    self:setValue(db.value_id, db.value_type, model)
end

---@param atk number
---@param flag boolean
function public:setAttackProjectileHomingEnabled(atk, flag)
    local db = db_atk[atk].ProjectileHomingEnabled
    self:setValue(db.value_id, db.value_type, flag)
end

---@param atk number
---@param value number
function public:setAttackProjectileSpeed(atk, value)
    local db = db_atk[atk].ProjectileSpeed
    self:setValue(db.value_id, db.value_type, value)
end

---@param atk number
---@param value number
function public:setAttackRange(atk, value)
    local db = db_atk[atk].Range
    self:setValue(db.value_id, db.value_type, value)
end

---@param atk number
---@param list table<number, targettype>
function public:setAttackTargetsAllowed(atk, list)
    local val = ''
    for i = 1, #list do
        val = val..BinaryUtils.targetTypeToData(list[i])
        if i < #list then val = val..',' end
    end

    local db = db_atk[atk].TargetsAllowed
    self:setValue(db.value_id, db.value_type, val)
end

---------------
-- Interface --
---------------

---@param name string
function public:setName(name)
    local db = UnitDB.Name
    self:setValue(db.value_id, db.value_type, name)
end

---@param icon string
function public:setIconGameInterface(icon)
    local db = UnitDB.IconGameInterface
    self:setValue(db.value_id, db.value_type, icon)
end

---@param model string
function public:setModelFile(model)
    local db = UnitDB.ModelFile
    self:setValue(db.value_id, db.value_type, model)
end

---@param size number
function public:setModelSize(size)
    local db = UnitDB.ModelScale
    self:setValue(db.value_id, db.value_type, size)
end

---@param speed number
function public:setMoveSpeed(speed)
    local db = UnitDB.MovementSpeedBase
    self:setValue(db.value_id, db.value_type, speed)
end

------------
-- Sounds --
------------



--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
local sep = Compiletime(package.config:sub(1,1))
private.file = BinaryFile.new((GetDstDir and GetDstDir() or '')..sep..'war3map.w3u')
CompileFinal(function() private.file:save() end)

return static