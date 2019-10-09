local ParameterType = require('Class.ParameterType.Main')
require('Class.ParameterType.ValueRange')

---@return number
local function getLinear(base, mult, bonus, min, max)
    local res = base * mult + bonus
    res = torange(res, min, max)
    return res
end

---@return number
local function getPartOfMaximum(base, mult, bonus, min, max)
    local res
    local a = base * mult
    if a >= 0 then
        local k = (base * mult) / (100 + (base * mult))
        res = max * k + bonus
    else
        a = -a
        local k = (base * mult) / (100 + (base * mult))
        res = min * k + bonus
    end

    return res
end

local MathFunction = {}
MathFunction[ParameterType.Id.P_DMG] = getLinear
MathFunction[ParameterType.Id.ATKS_PER_SEC] = getLinear
MathFunction[ParameterType.Id.ARMOR] = getLinear
MathFunction[ParameterType.Id.P_DMG_REDUC] =getPartOfMaximum
MathFunction[ParameterType.Id.M_DMG] = getLinear
MathFunction[ParameterType.Id.CAST_TIME_REDUC] = getPartOfMaximum
MathFunction[ParameterType.Id.RESIST] = getLinear
MathFunction[ParameterType.Id.M_DMG_REDUC] = getPartOfMaximum
MathFunction[ParameterType.Id.DODGE_CH] = getPartOfMaximum
MathFunction[ParameterType.Id.CRIT_CH] = getPartOfMaximum
MathFunction[ParameterType.Id.CRIT_DMG] = getLinear
MathFunction[ParameterType.Id.CD_REDUC] = getPartOfMaximum
MathFunction[ParameterType.Id.HP] = getLinear
MathFunction[ParameterType.Id.REGEN] = getLinear
MathFunction[ParameterType.Id.MP] = getLinear
MathFunction[ParameterType.Id.RECOV] = getLinear
MathFunction[ParameterType.Id.STR] = getLinear
MathFunction[ParameterType.Id.AGI] = getLinear
MathFunction[ParameterType.Id.INT] = getLinear
MathFunction[ParameterType.Id.MS] = getLinear

---@param base number
---@param mult number
---@param bonus number
---@return number
function ParameterType:math(base, mult, bonus)
    local func = MathFunction[self.__id]
    local min = self:getMinValue()
    local max = self:getMaxValue()
    return func(base, mult, bonus, min, max)
end