--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type ParameterContainerClass
local Container = require(lib_path..'Container') or error('')
local ContainerPublic = Class.getPublic(Container) or error('')
---@type ParameterSettings
local Settings = require(lib_path..'Settings') or error('')
---@type ParameterTypeModule
local ParameterTypeModule = require(lib_path..'Type') or error('')
local isParameterType = ParameterTypeModule.isParameterType or error('')
local ParameterType = ParameterTypeModule.Enum or error('')
---@type ParameterValueTypeModule
local ValueTypeModule = require(lib_path..'ValueType') or error('')
local isValueType = ValueTypeModule.isValueType or error('')

--=======
-- Class
--=======

local ParameterContainerUnit = Class.new('ParameterContainerUnit', Container)
---@class ParameterContainerUnit : ParameterContainer
local public = ParameterContainerUnit.public
---@class ParameterContainerUnitClass : ParameterContainerClass
local static = ParameterContainerUnit.static
---@type ParameterContainerUnitClass
local override = ParameterContainerUnit.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child ParameterContainerUnit | nil
---@return ParameterContainerUnit
function override.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    if child then isTypeErr(child, ParameterContainerUnit, 'child') end

    if private.owner2container[owner] then
        Log:wrn('Parameter container for unit already exists.')
        return private.owner2container[owner]
    end

    local instance = child or Class.allocate(ParameterContainerUnit)
    instance = Container.new(instance)
    private.newData(instance, owner)

    return instance
end

---@param owner Unit
---@return ParameterContainerUnit | nil
function static.get(owner)
    return private.owner2container[owner]
end

--========
-- Public
--========

---@param param ParameterType
---@param val_type ParameterValueType
---@param value number
---@return number
function public:add(param, val_type, value)
    if not isParameterType(param) then Log:err('variable \'param\' is not of type ParameterType.', 2) end
    if not isValueType(val_type) then Log:err('variable \'val_type\' is not of type ValueType.', 2) end

    local res = ContainerPublic.add(self, param, val_type, value)
    local priv = private.data[self]

    local apply = private.apply[param]
    if apply then
        apply(priv.owner:getData(), res)
    end

    return res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owner2container = setmetatable({}, {__mode = 'k'})

---@param self ParameterContainerUnit
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner
    }
    private.data[self] = priv
    private.owner2container[owner] = self
end

private.apply = {
    [ParameterType.PATK] = function(unit, value)
        BlzSetUnitBaseDamage(unit, math.floor((1 - 0.5 * Settings.PAtkDispersion) * value), 0)
        BlzSetUnitDiceNumber(unit, 1, 0)
        BlzSetUnitDiceSides(unit, math.floor(Settings.PAtkDispersion * value + 1), 0)
    end,

    [ParameterType.PSPD] = function(unit, value)
        BlzSetUnitAttackCooldown(unit, 1 / value, 0)
    end,

    [ParameterType.LIFE] = function(unit, value)
        local percent_hp = GetUnitLifePercent(unit)
        BlzSetUnitMaxHP(unit, math.floor(value))
        SetUnitState(unit, UNIT_STATE_LIFE, GetUnitState(unit, UNIT_STATE_MAX_LIFE) * percent_hp * 0.01)
    end,

    [ParameterType.REGE] = function(unit, value)
        BlzSetUnitRealField(unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
    end,

    [ParameterType.MANA] = function(unit, value)
        local percent_mana = GetUnitManaPercent(unit)
        BlzSetUnitMaxMana(unit, math.floor(value))
        SetUnitState(unit, UNIT_STATE_MANA, GetUnitState(unit, UNIT_STATE_MAX_MANA) * percent_mana * 0.01)
    end,

    [ParameterType.RECO] = function(unit, value)
        BlzSetUnitRealField(unit, UNIT_RF_MANA_REGENERATION, value)
    end,

    [ParameterType.MOVE] = function(unit, value)
        if value <= 1 then
            SetUnitTurnSpeed(unit, 0)
        else
            SetUnitTurnSpeed(unit, GetUnitDefaultTurnSpeed(unit))
        end
        SetUnitMoveSpeed(unit, value)
    end,
}

return static