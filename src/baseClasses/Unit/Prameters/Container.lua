---@type DataBase
local DataBase = require('utils.DataBase')
---@type UnitParameterType
local UnitParameterType = require('baseClasses.Unit.Prameters.Type')
---@type UnitParameterValue
local UnitParameterValue = require('baseClasses.Unit.Prameters.Value')

---@class UnitParameterContainer
local UnitParameterContainer  = newClass("UnitParameterContainer")
UnitParameterContainer_meta = newMeta(UnitParameterContainer)
UnitParameterContainer.__db = DataBase.new('Unit', 'UnitParameterContainer')

---@param
function UnitParameterContainer.new(owner)
    local container = {}
    container.P_DMG = UnitParameterValue.new(owner, UnitParameterType.P_DMG)
    container.ATKS_PER_SEC = UnitParameterValue.new(owner, UnitParameterType.ATKS_PER_SEC)
    container.ARMOR = UnitParameterValue.new(owner, UnitParameterType.ARMOR)
    container.P_DMG_REDUC = UnitParameterValue.new(owner, UnitParameterType.P_DMG_REDUC)
    container.M_DMG = UnitParameterValue.new(owner, UnitParameterType.M_DMG)
    container.CAST_TIME_REDUC = UnitParameterValue.new(owner, UnitParameterType.CAST_TIME_REDUC)
    container.RESIST = UnitParameterValue.new(owner, UnitParameterType.RESIST)
    container.M_DMG_REDUC = UnitParameterValue.new(owner, UnitParameterType.M_DMG_REDUC)
    container.DODGE_CH = UnitParameterValue.new(owner, UnitParameterType.DODGE_CH)
    container.CRIT_CH = UnitParameterValue.new(owner, UnitParameterType.CRIT_CH)
    container.CRIT_DMG = UnitParameterValue.new(owner, UnitParameterType.CRIT_DMG)
    container.CD_REDUC = UnitParameterValue.new(owner, UnitParameterType.CD_REDUC)
    container.HP = UnitParameterValue.new(owner, UnitParameterType.HP)
    container.REGEN = UnitParameterValue.new(owner, UnitParameterType.REGEN)
    container.MP = UnitParameterValue.new(owner, UnitParameterType.MP)
    container.RECOV = UnitParameterValue.new(owner, UnitParameterType.RECOV)
    container.STR = UnitParameterValue.new(owner, UnitParameterType.STR)
    container.AGI = UnitParameterValue.new(owner, UnitParameterType.AGI)
    container.INT = UnitParameterValue.new(owner, UnitParameterType.INT)
    container.MS = UnitParameterValue.new(owner, UnitParameterType.MS)

end

return UnitParameterContainer