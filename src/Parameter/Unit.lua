--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type ParameterData
local Data = require('Parameter.Data')
local Param = Data.Type
local ParamMath = Data.Math
local ParamDefault = Data.DefaultValue
---@type ParameterValueListClass
local ValueList = require('Parameter.ValueList')
local ValueListPublic = Class.getPublic(ValueList)
---@type ParameterValueClass
local ParamValue = require('Parameter.Value')
local ValueType = ParamValue.ValueType
---@type fun(unit:unit, param:ParameterTypeEnum, value:number)
local ParameterUnitApply = require('Parameter.UnitApply')

--=======
-- Class
--=======

local ParameterUnit = Class.new('ParameterUnit', ValueList)
---@class ParameterUnit : ParameterValueList
local public = ParameterUnit.public
---@class ParameterUnitClass : ParameterValueListClass
local static = ParameterUnit.static
---@type ParameterUnitClass
local override = ParameterUnit.override
local private = {}

--========
-- Static
--========

---@param owner unit
---@return ParameterUnit
function override.new(owner)
    local instance = Class.allocate(ParameterUnit)
    instance = ValueList.new(instance)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@param param ParameterTypeEnum
---@param value_type ParameterValueTypeEnum
---@param value number
function public:set(param, value_type, value)
    ValueListPublic.set(self, param, value_type, value)
    private.update(self, param)
end

---@param param ParameterTypeEnum
---@param value_type ParameterValueTypeEnum
---@param value number
function public:add(param, value_type, value)
    ValueListPublic.add(self, param, value_type, value)
    private.update(self, param)
end

---@param param ParameterTypeEnum
---@return number
function public:getResult(param)
    return private.data[self].result[param]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ParameterUnit
---@param param_type ParameterTypeEnum
function private.update(self, param_type)
    local priv = private.data[self]

    priv.result[param_type] = ParamMath[param_type](self:get(param_type, ValueType.BASE),
                                                    self:get(param_type, ValueType.MULT),
                                                    self:get(param_type, ValueType.ADDIT))

    ParameterUnitApply(priv.owner, param_type, priv.result[param_type])
end

---@param self ParameterUnit
---@param owner unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        result = {}
    }
    private.data[self] = priv

    for _, param_type in pairs(Param) do
        self:set(param_type, ValueType.BASE, ParamDefault[param_type])
        self:set(param_type, ValueType.MULT, 1)
        private.update(self, param_type)
    end
end

return static