---@class UnitParameterValue
local UnitParameterValue = newClass("UnitParameterValue")
local UnitParameterValue_meta = newMeta(UnitParameterValue)

local abs_max = 10^8

---@param owner Unit
---@param parameter_type UnitParameterType
---@param minimum any
---@param maximum any
---@return UnitParameterValue
function UnitParameterValue.new(owner, parameter_type, minimum, maximum)
    ---@type UnitParameterValue
    local value =  {__owner = owner,
                    __parameter = parameter_type,
                    __base = 0,
                    __mult = 1,
                    __bonus = 0,
                    __result = 0,
                    __result_ready = false,
                    __minimum = minimum or -abs_max,
                    __maximum = maximum or  abs_max
    }
    setmetatable(value, UnitParameterValue_meta)

    return value
end

---@param base number
---@param mult number
---@param bonus number
function UnitParameterValue:set(base, mult, bonus)
    if base ~= nil then
        self.__base = base
    end

    if mult ~= nil then
        self.__mult = mult
    end

    if bonus ~= nil then
        self.__bonus = bonus
    end

    self.__result = self.__parameter:math(self.__base, self.__mult, self.__bonus, self.__minimum, self.__maximum)
    self.__parameter:apply(self.__owner, self.__result)
end

---@param base number
---@param mult number
---@param bonus number
function UnitParameterValue:add(base, mult, bonus)
    self.__base = self.__base + base
    self.__mult = self.__mult + mult
    self.__bonus = self.__bonus + bonus
    self.__result = self.__parameter:math(self.__base, self.__mult, self.__bonus, self.__minimum, self.__maximum)
    self.__parameter:apply(self.__owner, self.__result)
end

---@return UnitParameterType
function UnitParameterValue:getType()
    return self.__parameter
end

---@return number
function UnitParameterValue:get()
    return self.__result
end

---@return number
function UnitParameterValue:getBase()
    return self.__base
end

---@return number
function UnitParameterValue:getMult()
    return self.__mult
end

---@return number
function UnitParameterValue:getBonus()
    return self.__bonus
end


return UnitParameterValue