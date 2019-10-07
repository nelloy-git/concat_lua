---@type Settings
local Settings = require('utils.Settings')

local UnitParameterMathFunction = {}

---@return number
function UnitParameterMathFunction.getLinear(base, mult, bonus, min, max)
    local res = base * mult + bonus
    res = torange(res, min, max)
    return res
end

---@return number
function UnitParameterMathFunction.getPartOfMaximum(base, mult, bonus, min, max)
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


return UnitParameterMathFunction