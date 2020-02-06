--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')
---@type ParameterValueClass
local ParameterValue = require('Class.ParameterValue')
---@type Trigger
local Trigger = require('Class.Trigger')

--- Recursive include
---@type UnitApplyParameterClass
local UnitApplyParameter = require('Class.Unit.Parameters.Apply')

--=======
-- Class
--=======

local ParameterUnit = Class.new('ParameterUnit')
---@class ParameterUnit
local public = ParameterUnit.public
---@class ParametersContUnit
local static = ParameterUnit.static
---@type ParametersContUnit
local override = ParameterUnit.override
local private = {}

private.DB = DataBase.new('userdata', ParameterUnit)

--========
-- Static
--========

---@param owner unit
---@return ParameterUnit
function static.new(owner)
    local instance = Class.allocate(ParameterUnit)
    private.newData(instance, owner)

    for i = 1, private.params_count do
        private.update(instance, private.params_list[i])
    end
    instance:setBase(ParameterType.MS, 250)

    return instance
end

---@param owner unit
---@return ParameterUnit
function static.get(owner)
    return private.DB:get(owner)
end

---@return Unit
function static.GetUnitWithChangedParameters()
    Log(Log.Err, ParameterUnit, 'GetUnitWithChangedParameters called outside of \'UnitChangesParameter\' event.')
end

---@return ParameterType
function static.GetChangedParameterType()
    Log(Log.Err, ParameterUnit, 'GetChangedParameterType called outside of \'UnitChangesParameter\' event.')
end

---@return number
function static.GetChangedParameterOldValue()
    Log(Log.Err, ParameterUnit, 'GetChangedParameterOldValue called outside of \'UnitChangesParameter\' event.')
end

---@return number
function static.GetChangedParameterNewValue()
    Log(Log.Err, ParameterUnit, 'GetChangedParameterNewValue called outside of \'UnitChangesParameter\' event.')
end

--========
-- Public
--========

---@param param ParameterType
---@return number
function public:getResult(param)
    return private[self].results[param]
end

---@return number
function public:getBase(param)
    return private[self].values[param]:getBase()
end

---@param param ParameterType
---@param value number
function public:setBase(param, value)
    private[self].values[param]:setBase(value)
    private.update(self, param)
end

function public:addBase(param, value)
    local priv = private[self]
    local cur = priv.values[param]:getBase()
    priv.values[param]:setBase(cur + value)
    private.update(self, param)
end

---@return number
function public:getMult(param)
    return private[self].values[param]:getMult()
end

---@param param ParameterType
---@param value number
function public:setMult(param, value)
    private[self].values[param]:setMult(value)
    private.update(self, param)
end

function public:addMult(param, value)
    local priv = private[self]
    local cur = priv.values[param]:getMult()
    priv.values[param]:setMult(cur + value)
    private.update(self, param)
end

---@param param ParameterType
---@return number
function public:getAdditive(param)
    return private[self].values[param]:getAdditive()
end

---@param param ParameterType
---@param value number
function public:setAdditive(param, value)
    private[self].values[param]:setAdditive(value)
    private.update(self, param)
end

---@param param ParameterType
---@param value number
function public:addAdditive(param, value)
    local priv = private[self]
    local cur = priv.values[param]:getAdditive()
    priv.values[param]:setAdditive(cur + value)
    private.update(self, param)
end

--=========
-- Private
--=========

if not IsCompiletime() then
    private.UnitParameterChangedTrigger = Trigger.new()
end

private.params_list = ParameterType.getList()
private.params_count = #private.params_list

---@param self ParameterUnit
---@param param ParameterType
function private.update(self, param)
    local priv = private[self]
    local values = priv.values[param]

    local old_val = priv.results[param]
    local new_val = param:math(values:getBase(), values:getMult(), values:getAdditive())

    local prev_unit = static.GetUnitWithChangedParameters
    local prev_param = static.GetChangedParameterType
    local prev_old = static.GetChangedParameterOldValue
    local prev_new = static.GetChangedParameterNewValue

    static.GetUnitWithChangedParameters = function() return priv.owner end
    static.GetChangedParameterType = function() return self end
    static.GetChangedParameterOldValue = function() return old_val end
    static.GetChangedParameterNewValue = function() return new_val end

    UnitApplyParameter = UnitApplyParameter or require('Class.Unit.Parameters.Apply')
    UnitApplyParameter.apply(priv.owner, new_val, param)
    priv.results[param] = new_val
    if private.UnitParameterChangedTrigger then
        private.UnitParameterChangedTrigger:execute()
    end

    static.GetUnitWithChangedParameters = prev_unit
    static.GetChangedParameterType = prev_param
    static.GetChangedParameterOldValue = prev_old
    static.GetChangedParameterNewValue = prev_new
end

---@param self ParameterUnit
---@param owner unit
---@return table
function private.newData(self, owner)
    local priv = {
        owner = owner,
        values = {},
        results = {}
    }
    for i = 1, private.params_count do
        priv.results[private.params_list[i]] = 0
        priv.values[private.params_list[i]] = ParameterValue.new()
    end
    private[self] = priv
    private.DB:set(owner, self)
end

---@param self ParameterUnit
function private.freeData(self)
    private.DB:remove(private[self].owner)
    private[self] = nil
end

return static