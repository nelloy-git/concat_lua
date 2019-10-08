local Id = require('Data.UnitParameter.Id')

local abs_max = 10^8

local UnitParameterRange = {}
UnitParameterRange[Id.P_DMG] = {min = 1, max = abs_max}
UnitParameterRange[Id.ATKS_PER_SEC] = {min = 0.01, max = abs_max}
UnitParameterRange[Id.ARMOR] = {min = -abs_max, max = abs_max}
UnitParameterRange[Id.P_DMG_REDUC] = {min = -0.75, max = 0.75}
UnitParameterRange[Id.M_DMG] = {min = 0, max = abs_max}
UnitParameterRange[Id.CAST_TIME_REDUC] = {min = -0.75, max = 0.75}
UnitParameterRange[Id.RESIST] = {min = -abs_max, max = abs_max}
UnitParameterRange[Id.M_DMG_REDUC] = {min = -0.75, max = 0.75}
UnitParameterRange[Id.DODGE_CH] = {min = 0, max = 0.75}
UnitParameterRange[Id.CRIT_CH] = {min = 0, max = 0.75}
UnitParameterRange[Id.CRIT_DMG] = {min = 1.2, max = abs_max}
UnitParameterRange[Id.CD_REDUC] = {min = -0.75, max = 0.75}
UnitParameterRange[Id.HP] = {min = 10, max = abs_max}
UnitParameterRange[Id.REGEN] = {min = -abs_max, max = abs_max}
UnitParameterRange[Id.MP] = {min = 0, max = abs_max}
UnitParameterRange[Id.RECOV] = {min = -abs_max, max = abs_max}
UnitParameterRange[Id.STR] = {min = 0, max = abs_max}
UnitParameterRange[Id.AGI] = {min = 0, max = abs_max}
UnitParameterRange[Id.INT] = {min = 0, max = abs_max}
UnitParameterRange[Id.MS] = {min = 1, max = 512}

return UnitParameterRange