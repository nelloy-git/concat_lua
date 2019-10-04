local Name = require('Data.UnitParameter.Names')
local ShortName = require('Data.UnitParameter.ShortNames')
local Description = require('Data.UnitParameter.Description')
local Icon = require('Data.UnitParameter.Icon')
local Math = require('baseClasses.Unit.Prameters.MathFunctions')
local Apply = require('baseClasses.Unit.Prameters.ApplyFunctions')

---@class UnitParameterType
local UnitParameterType = newClass("UnitParameterType")
local UnitParameterType_meta = newMeta(UnitParameterType)

function UnitParameterType.init()
    UnitParameterType.P_DMG = UnitParameterType.new(Name.P_DMG, ShortName.P_DMG, Description.P_DMG, Icon.P_DMG, Math.getLinear, Apply.setAttackDamage)
    UnitParameterType.ATKS_PER_SEC = UnitParameterType.new(Name.ATKS_PER_SEC, ShortName.ATKS_PER_SEC, Description.ATKS_PER_SEC, Icon.ATKS_PER_SEC, Math.getLinear, Apply.setAttacksPerSecond)
    UnitParameterType.ARMOR = UnitParameterType.new(Name.ARMOR, ShortName.ARMOR, Description.ARMOR, Icon.ARMOR, Math.getLinear, nil)
    UnitParameterType.P_DMG_REDUC = UnitParameterType.new(Name.P_DMG_REDUC, ShortName.P_DMG_REDUC, Description.P_DMG_REDUC, Icon.P_DMG_REDUC, Math.getPartOfMaximum, nil)
    UnitParameterType.M_DMG = UnitParameterType.new(Name.M_DMG, ShortName.M_DMG, Description.M_DMG, Icon.M_DMG, Math.getLinear, nil)
    UnitParameterType.CAST_TIME_REDUC = UnitParameterType.new(Name.CAST_TIME_REDUC, ShortName.CAST_TIME_REDUC, Description.CAST_TIME_REDUC, Icon.CAST_TIME_REDUC, Math.getPartOfMaximum, nil)
    UnitParameterType.RESIST = UnitParameterType.new(Name.RESIST, ShortName.RESIST, Description.RESIST, Icon.RESIST, Math.getLinear, nil)
    UnitParameterType.M_DMG_REDUC = UnitParameterType.new(Name.M_DMG_REDUC, ShortName.M_DMG_REDUC, Description.M_DMG_REDUC, Icon.M_DMG_REDUC, Math.getPartOfMaximum, nil)
    UnitParameterType.DODGE_CH = UnitParameterType.new(Name.DODGE_CH, ShortName.DODGE_CH, Description.DODGE_CH, Icon.DODGE_CH, Math.getPartOfMaximum, nil)
    UnitParameterType.CRIT_CH = UnitParameterType.new(Name.CRIT_CH, ShortName.CRIT_CH, Description.CRIT_CH, Icon.CRIT_CH, Math.getPartOfMaximum, nil)
    UnitParameterType.CRIT_DMG = UnitParameterType.new(Name.CRIT_DMG, ShortName.CRIT_DMG, Description.CRIT_DMG, Icon.CRIT_DMG, Math.getLinear, nil)
    UnitParameterType.CD_REDUC = UnitParameterType.new(Name.CD_REDUC, ShortName.CD_REDUC, Description.CD_REDUC, Icon.CD_REDUC, Math.getPartOfMaximum, nil)
    UnitParameterType.HP = UnitParameterType.new(Name.HP, ShortName.HP, Description.HP, Icon.HP, Math.getLinear, Apply.setHealth)
    UnitParameterType.REGEN = UnitParameterType.new(Name.REGEN, ShortName.REGEN, Description.REGEN, Icon.REGEN, Math.getLinear, Apply.setRegeneration)
    UnitParameterType.MP = UnitParameterType.new(Name.MP, ShortName.MP, Description.MP, Icon.MP, Math.getLinear, Apply.setMana)
    UnitParameterType.RECOV = UnitParameterType.new(Name.RECOV, ShortName.RECOV, Description.RECOV, Icon.RECOV, Math.getLinear, Apply.setRecovery)
    UnitParameterType.STR = UnitParameterType.new(Name.STR, ShortName.STR, Description.STR, Icon.STR, Math.getLinear, Apply.setStrength)
    UnitParameterType.AGI = UnitParameterType.new(Name.AGI, ShortName.AGI, Description.AGI, Icon.AGI, Math.getLinear, Apply.setAgility)
    UnitParameterType.INT = UnitParameterType.new(Name.INT, ShortName.INT, Description.INT, Icon.INT, Math.getLinear, Apply.setIntelligence)
    UnitParameterType.MS = UnitParameterType.new(Name.MS, ShortName.MS, Description.MS, Icon.MS, Math.getPartOfMaximum, Apply.setMoveSpeed)
end

--- Creates new unit parameter. apply_func:function(unit:unit, value:number). math_func:function(base:number, mult:number, bonus:number, min:number, max:number):number.
---@param name string
---@param short_name string
---@param description string
---@param icon string
---@param math_func fun
---@param apply_func fun|nil
---@return UnitParameterType
function UnitParameterType.new(name, short_name, description, icon, math_func, apply_func)
    local param_type = {
        __name = name,
        __short_name = short_name,
        __description = description,
        __icon = icon,
        __math_func = math_func,
        __apply_func = apply_func
    }
    setmetatable(param_type, UnitParameterType_meta)

    return param_type
end

---@param base number
---@param mult number
---@param bonus number
---@param min number
---@param max number
---@return number
function UnitParameterType:math(base, mult, bonus, min, max)
    return self.__math_func(base, mult, bonus, min, max)
end

---@param unit unit
---@param value number
function UnitParameterType:apply(unit, value)
    if not self.__apply_func then
        return nil
    end
    self.__apply_func(unit, value)
end

return UnitParameterType