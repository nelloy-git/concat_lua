local ParameterType = require('Class.ParameterType.Main')

local ShortName = {}

ShortName[ParameterType.Id.P_DMG] = 'PDmg'
ShortName[ParameterType.Id.ATKS_PER_SEC] = 'Atk/sec'
ShortName[ParameterType.Id.ARMOR] = 'PDef'
ShortName[ParameterType.Id.P_DMG_REDUC] = 'PDmgReduc'
ShortName[ParameterType.Id.M_DMG] = 'MDmg'
ShortName[ParameterType.Id.CAST_TIME_REDUC] = 'CastTimeReduc'
ShortName[ParameterType.Id.RESIST] = 'MDef'
ShortName[ParameterType.Id.M_DMG_REDUC] = 'MDmgReduc'
ShortName[ParameterType.Id.DODGE] = 'DodgeChance'
ShortName[ParameterType.Id.CRIT_CH] = 'CritChance'
ShortName[ParameterType.Id.CRIT_DMG] = 'CritDmg'
ShortName[ParameterType.Id.CD_REDUC] = 'CdReduc'
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