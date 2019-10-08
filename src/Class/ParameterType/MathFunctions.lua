local Id = require('Class.ParameterType.Id')

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

local UnitParameterMathFunction = {}
UnitParameterMathFunction[Id.P_DMG] = getLinear
UnitParameterMathFunction[Id.ATKS_PER_SEC] = getLinear
UnitParameterMathFunction[Id.ARMOR] = getLinear
UnitParameterMathFunction[Id.P_DMG_REDUC] =getPartOfMaximum
UnitParameterMathFunction[Id.M_DMG] = getLinear
UnitParameterMathFunction[Id.CAST_TIME_REDUC] = getPartOfMaximum
UnitParameterMathFunction[Id.RESIST] = getLinear
UnitParameterMathFunction[Id.M_DMG_REDUC] = getPartOfMaximum
UnitParameterMathFunction[Id.DODGE_CH] = getPartOfMaximum
UnitParameterMathFunction[Id.CRIT_CH] = getPartOfMaximum
UnitParameterMathFunction[Id.CRIT_DMG] = getLinear
UnitParameterMathFunction[Id.CD_REDUC] = getPartOfMaximum
UnitParameterMathFunction[Id.HP] = getLinear
UnitParameterMathFunction[Id.REGEN] = getLinear
UnitParameterMathFunction[Id.MP] = getLinear
UnitParameterMathFunction[Id.RECOV] = getLinear
UnitParameterMathFunction[Id.STR] = getLinear
UnitParameterMathFunction[Id.AGI] = getLinear
UnitParameterMathFunction[Id.INT] = getLinear
UnitParameterMathFunction[Id.MS] = getLinear

return UnitParameterMathFunction