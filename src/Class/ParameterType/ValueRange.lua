local ParameterType = require('Class.ParameterType.Main')

local abs_max = 10^8

local Range = {}
Range[ParameterType.Id.P_DMG] = {min = 1, max = abs_max}
Range[ParameterType.Id.ATKS_PER_SEC] = {min = 0.01, max = abs_max}
Range[ParameterType.Id.ARMOR] = {min = -abs_max, max = abs_max}
Range[ParameterType.Id.P_DMG_REDUC] = {min = -0.75, max = 0.75}
Range[ParameterType.Id.M_DMG] = {min = 0, max = abs_max}
Range[ParameterType.Id.CAST_TIME_REDUC] = {min = -0.75, max = 0.75}
Range[ParameterType.Id.RESIST] = {min = -abs_max, max = abs_max}
Range[ParameterType.Id.M_DMG_REDUC] = {min = -0.75, max = 0.75}
Range[ParameterType.Id.DODGE_CH] = {min = 0, max = 0.75}
Range[ParameterType.Id.CRIT_CH] = {min = 0, max = 0.75}
Range[ParameterType.Id.CRIT_DMG] = {min = 1.2, max = abs_max}
Range[ParameterType.Id.CD_REDUC] = {min = -0.75, max = 0.75}
Range[ParameterType.Id.HP] = {min = 10, max = abs_max}
Range[ParameterType.Id.REGEN] = {min = -abs_max, max = abs_max}
Range[ParameterType.Id.MP] = {min = 0, max = abs_max}
Range[ParameterType.Id.RECOV] = {min = -abs_max, max = abs_max}
Range[ParameterType.Id.STR] = {min = 0, max = abs_max}
Range[ParameterType.Id.AGI] = {min = 0, max = abs_max}
Range[ParameterType.Id.INT] = {min = 0, max = abs_max}
Range[ParameterType.Id.MS] = {min = 1, max = 512}

---@return number
function ParameterType:getMinValue()
    return Range[self.__id].min
end

---@return number
function ParameterType:getMaxValue()
    return Range[self.__id].max
end