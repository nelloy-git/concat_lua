--==========
-- Includes
--==========

local ParameterType = require('Include.ParameterType')

--=======
-- Class
--=======

---@class ParameterValues
local ParameterValue = newClass("ParameterValue")
local ParameterValue_meta = newMeta(ParameterValue)

---@param parameter_type ParameterType
---@return ParameterValues
function ParameterValue.new(parameter_type, base, mult, bonus)
    ---@type ParameterValues
    local value =  {__parameter_type = parameter_type,
                    __base = base,
                    __mult = mult,
                    __bonus = bonus,
                    __result = parameter_type:math(base, mult, bonus)
    }
    setmetatable(value, ParameterValue_meta)

    return value
end

---@param base number
---@param mult number
---@param bonus number
function ParameterValue:addAll(base, mult, bonus)
    self.__base = self.__base + base
    self.__mult = self.__mult + mult
    self.__bonus = self.__bonus + bonus
    self.__result = self.__parameter_type:math(self.__base, self.__mult, self.__bonus)
end

---@param value number
function ParameterValue:addBase(value)
    self.__base = self.__base + value
    self.__result = self.__parameter_type:math(self.__base, self.__mult, self.__bonus)
end

---@param value number
function ParameterValue:addMult(value)
    self.__mult = self.__mult + value
    self.__result = self.__parameter_type:math(self.__base, self.__mult, self.__bonus)
end

---@param value number
function ParameterValue:addBonus(value)
    self.__bonus = self.__bonus + value
    self.__result = self.__parameter_type:math(self.__base, self.__mult, self.__bonus)
end

---@return ParameterType
function ParameterValue:getType()
    return self.__parameter
end

---@return number
function ParameterValue:getBase()
    return self.__base
end

---@return number
function ParameterValue:getMult()
    return self.__mult
end

---@return number
function ParameterValue:getBonus()
    return self.__bonus
end

---@return number
function ParameterValue:getResult()
    return self.__result
end


return ParameterValue