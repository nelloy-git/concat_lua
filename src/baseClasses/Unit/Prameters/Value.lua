---@class UnitParameterValue
local UnitParameterValue, UnitParameterValue_meta = newClass("UnitParameterValue")

local abs_max = 10^8

---@param parameter_type UnitParameterType
---@return UnitParameterValue
function UnitParameterValue.new(parameter_type, minimum, maximum)
    local value = {__parameter = parameter_type,
                    __base = 0,
                    __mult = 1,
                    __bonus = 0,
                    __result = 0,
                    __result_ready = false,
                    __minimum = minimum or -abs_max,
                    __maximum = maximum or  abs_max
    }
    return value
end

---@param base number
---@param mult number
---@param bonus number
function UnitParameterValue:add(base, mult, bonus)
    self.__base = self.__base + base
    self.__mult = self.__mult + mult
    self.__bonus = self.__bonus + bonus
    self.__result_ready = false
end

---@return number
function UnitParameterValue:getLinear()
    if not self.__result_ready then
        self.__result = self.__base * self.__mult + self.__bonus
        self.__result = torange(self.__result, self.__minimum, self.__maximum)
        self.__result_ready = true
    end
    return self.__result
end

---@return number
function UnitParameterValue:getPartOfMaximum()
    if not self.__result_ready then
        local a = self.__base * self.__mult
        if a >= 0 then 
            local k = (self.__base * self.__mult) / (100 + (self.__base * self.__mult))
            self.__result = self.__maximum * k + self.__bonus
        else
            a = -a
            local k = (self.__base * self.__mult) / (100 + (self.__base * self.__mult))
            self.__result = self.__minimum * k + self.__bonus
        end
        self.__result_ready = true
    end
    return self.__result
end


return UnitParameterValue