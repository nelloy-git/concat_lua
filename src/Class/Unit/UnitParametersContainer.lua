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

--=======
-- Class
--=======

local UnitParametersContainer = Class.new('UnitParametersContainer')
---@class UnitParametersContainer
local public = UnitParametersContainer.public
---@class UnitParametersContainerClass
local static = UnitParametersContainer.static
local override = UnitParametersContainer.override
local private = {}

private.DB = DataBase.new('userdata', Class.getClassName(UnitParametersContainer))

--========
-- Static
--========

---@param owner unit
---@param child_data table | nil
---@return UnitParametersContainer
function static.new(owner, child_data)
    local instance = child_data or Class.allocate(UnitParametersContainer, child_data)
    private.newData(instance, owner)

    local params = ParameterType.getList()
    for i = 1, #params do
        private.update(instance, params[i])
    end
    instance:setBase(ParameterType.MS, 250)

    return instance
end

---@param owner unit
---@return UnitParametersContainer
function static.get(owner)
    return private.DB:get(owner)
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

function public:free()
    private.freeData(self)
    Class.freeInstanceData(self)
end

--=========
-- Private
--=========

private.params_list = ParameterType.getList()
private.params_count = #private.params_list

---@param self UnitParametersContainer
---@param param ParameterType
function private.update(self, param)
    local priv = private[self]

    local values = priv.values[param]
    local old_val = priv.results[param]
    local new_val = param:math(values:getBase(), values:getMult(), values:getAdditive())

    priv.results[param] = new_val
    param:apply(priv.owner, old_val, new_val)
end

---@param self UnitParametersContainer
---@param owner unit
---@return table
function private.newData(self, owner)
    local priv = {
        owner = owner,
        values = {},
        result = {}
    }
    for i = 1, #private.params_count do
        priv.result[private.params_list[i]] = 0
        priv.values[private.params_list[i]] = ParameterValue.new()
    end
    private[self] = priv
    private.DB:set(owner, self)
end

---@param self UnitParametersContainer
function private.freeData(self)
    private.DB:remove(private[self].owner)
    private[self] = nil
end

return UnitParametersContainer