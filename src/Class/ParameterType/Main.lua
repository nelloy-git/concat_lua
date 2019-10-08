

local Id = require('Data.UnitParameter.Id')
local Name = require('Data.UnitParameter.Names')
local ShortName = require('Data.UnitParameter.ShortNames')
local Description = require('Data.UnitParameter.Description')
local Icon = require('Data.UnitParameter.Icon')
local Math = require('baseClasses.Unit.Parameters.MathFunctions')
local Apply = require('baseClasses.Unit.Parameters.ApplyFunctions')

---@class UnitParameterType
local ParameterType = newClass("ParameterType")
local ParameterType_meta = newMeta(ParameterType)

function ParameterType.init()
    for _, id in pairs(Id) do
        ParameterType[id] = ParameterType.new(id, Name[id], ShortName[id], Description[id], Icon[id], MathFunc[id], ApplyToUnit[id])


    ParameterType[Id.P_DMG] = ParameterType.new(Name.P_DMG, ShortName.P_DMG, Description.P_DMG, Icon.P_DMG, Math.getLinear, Apply.setAttackDamage)
    ParameterType[Id.ATKS_PER_SEC] = ParameterType.new(Name.ATKS_PER_SEC, ShortName.ATKS_PER_SEC, Description.ATKS_PER_SEC, Icon.ATKS_PER_SEC, Math.getLinear, Apply.setAttacksPerSecond)
    ParameterType[Id.ARMOR] = ParameterType.new(Name.ARMOR, ShortName.ARMOR, Description.ARMOR, Icon.ARMOR, Math.getLinear, nil)
    ParameterType[Id.P_DMG_REDUC] = ParameterType.new(Name.P_DMG_REDUC, ShortName.P_DMG_REDUC, Description.P_DMG_REDUC, Icon.P_DMG_REDUC, Math.getPartOfMaximum, nil)
    ParameterType[Id.M_DMG] = ParameterType.new(Name.M_DMG, ShortName.M_DMG, Description.M_DMG, Icon.M_DMG, Math.getLinear, nil)
    ParameterType[Id.CAST_TIME_REDUC] = ParameterType.new(Name.CAST_TIME_REDUC, ShortName.CAST_TIME_REDUC, Description.CAST_TIME_REDUC, Icon.CAST_TIME_REDUC, Math.getPartOfMaximum, nil)
    ParameterType[Id.RESIST] = ParameterType.new(Name.RESIST, ShortName.RESIST, Description.RESIST, Icon.RESIST, Math.getLinear, nil)
    ParameterType[Id.M_DMG_REDUC] = ParameterType.new(Name.M_DMG_REDUC, ShortName.M_DMG_REDUC, Description.M_DMG_REDUC, Icon.M_DMG_REDUC, Math.getPartOfMaximum, nil)
    ParameterType[Id.DODGE_CH] = ParameterType.new(Name.DODGE_CH, ShortName.DODGE_CH, Description.DODGE_CH, Icon.DODGE_CH, Math.getPartOfMaximum, nil)
    ParameterType[Id.CRIT_CH] = ParameterType.new(Name.CRIT_CH, ShortName.CRIT_CH, Description.CRIT_CH, Icon.CRIT_CH, Math.getPartOfMaximum, nil)
    ParameterType[Id.CRIT_DMG] = ParameterType.new(Name.CRIT_DMG, ShortName.CRIT_DMG, Description.CRIT_DMG, Icon.CRIT_DMG, Math.getLinear, nil)
    ParameterType[Id.CD_REDUC] = ParameterType.new(Name.CD_REDUC, ShortName.CD_REDUC, Description.CD_REDUC, Icon.CD_REDUC, Math.getPartOfMaximum, nil)
    ParameterType[Id.HP] = ParameterType.new(Name.HP, ShortName.HP, Description.HP, Icon.HP, Math.getLinear, Apply.setHealth)
    ParameterType[Id.REGEN] = ParameterType.new(Name.REGEN, ShortName.REGEN, Description.REGEN, Icon.REGEN, Math.getLinear, Apply.setRegeneration)
    ParameterType[Id.MP] = ParameterType.new(Name.MP, ShortName.MP, Description.MP, Icon.MP, Math.getLinear, Apply.setMana)
    ParameterType[Id.RECOV] = ParameterType.new(Name.RECOV, ShortName.RECOV, Description.RECOV, Icon.RECOV, Math.getLinear, Apply.setRecovery)
    ParameterType[Id.STR] = ParameterType.new(Name.STR, ShortName.STR, Description.STR, Icon.STR, Math.getLinear, Apply.setStrength)
    ParameterType[Id.AGI] = ParameterType.new(Name.AGI, ShortName.AGI, Description.AGI, Icon.AGI, Math.getLinear, Apply.setAgility)
    ParameterType[Id.INT] = ParameterType.new(Name.INT, ShortName.INT, Description.INT, Icon.INT, Math.getLinear, Apply.setIntelligence)
    ParameterType[Id.MS] = ParameterType.new(Name.MS, ShortName.MS, Description.MS, Icon.MS, Math.getPartOfMaximum, Apply.setMoveSpeed)
end

--- Creates new unit parameter. apply_func:function(unit:unit, value:number). math_func:function(base:number, mult:number, bonus:number, min:number, max:number):number.
---@param name string
---@param short_name string
---@param description string
---@param icon string
---@param math_func fun
---@param apply_func fun|nil
---@return UnitParameterType
function ParameterType.new(id, name, short_name, description, icon, math_func, apply_func, min_value, max_value)
    local param_type = {
        __id = id,
        __name = name,
        __short_name = short_name,
        __description = description,
        __icon = icon,
        __math_func = math_func,
        __apply_func = apply_func,
        __min_value = min_value,
        __max_value = max_value
    }
    setmetatable(param_type, ParameterType_meta)

    return param_type
end

---@param base number
---@param mult number
---@param bonus number
---@param min number
---@param max number
---@return number
function ParameterType:math(base, mult, bonus, min, max)
    return self.__math_func(base, mult, bonus, self.__min_value, self.__max_value)
end

---@param unit Unit
---@param value number
function ParameterType:apply(unit, value)
    if not self.__apply_func then
        return nil
    end
    self.__apply_func(unit, value)
end

---@type string
function ParameterType:getName()
    return self.__name
end

---@return string
function ParameterType:getIcon()
    return self.__icon
end

---@return string
function ParameterType:getDescription()
    return self.__description
end

return ParameterType