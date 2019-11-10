local ParameterType = require('Class.ParameterType.Main')

local ShortName = {}

ShortName[ParameterType.Id.P_DMG] = 'PDmg'
ShortName[ParameterType.Id.ATKS_PER_SEC] = 'ASpd'
ShortName[ParameterType.Id.ARMOR] = 'PDef'
ShortName[ParameterType.Id.P_DMG_REDUC] = 'PRed'
ShortName[ParameterType.Id.M_DMG] = 'MDmg'
ShortName[ParameterType.Id.CAST_TIME_REDUC] = 'CSpd'
ShortName[ParameterType.Id.RESIST] = 'MDef'
ShortName[ParameterType.Id.M_DMG_REDUC] = 'MRed'
ShortName[ParameterType.Id.DODGE] = 'Dodge'
ShortName[ParameterType.Id.CRIT_CH] = 'CritCh'
ShortName[ParameterType.Id.CRIT_DMG] = 'CritDmg'
ShortName[ParameterType.Id.CD_REDUC] = 'CDRed'
ShortName[ParameterType.Id.HP] = 'HP'
ShortName[ParameterType.Id.REGEN] = 'Regen'
ShortName[ParameterType.Id.MP] = 'MP'
ShortName[ParameterType.Id.RECOV] = 'Recov'
ShortName[ParameterType.Id.STR] = 'Str'
ShortName[ParameterType.Id.AGI] = 'Agi'
ShortName[ParameterType.Id.INT] = 'Int'
ShortName[ParameterType.Id.MS] = 'MS'

---@return string
function ParameterType:getShortName()
    return ShortName[self.__id]
end