--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type ParameterValueListClass
local ValueList = require(lib_path..'ValueList') or error('')
local ValueListPublic = Class.getPublic(ValueList) or error('')
---@type ParameterDefines
local Defines = require(lib_path..'Defines') or error('')

--=======
-- Class
--=======

local ParameterContainerUnit = Class.new('ParameterContainerUnit', ValueList)
---@class ParameterContainerUnit : ParameterValueList
local public = ParameterContainerUnit.public
---@class ParameterContainerUnitClass : ParameterValueListClass
local static = ParameterContainerUnit.static
---@type ParameterContainerUnitClass
local override = ParameterContainerUnit.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child ParameterContainerUnit | nil
---@return ParameterContainerUnit
function override.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    if child then isTypeErr(child, ParameterContainerUnit, 'child') end

    if private.owners[owner] then
        Log:wnr('Parameter container for unit already exists.')
        return private.owners[owner]
    end

    local instance = child or Class.allocate(ParameterContainerUnit)
    instance = ValueList.new(instance)
    private.newData(instance, owner)

    return instance
end

---@param owner Unit
---@return ParameterContainerUnit | nil
function static.get(owner)
    return private.owners[owner]
end

--========
-- Public
--========

---@param param Parameter
---@param value number
---@return number
function public:addBase(param, value)
    local res = ValueListPublic.addBase(self, param, value)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getData(), res)
    end
    return res
end

---@param param Parameter
---@param value number
---@return number
function public:addMult(param, value)
    local res = ValueListPublic.addMult(self, param, value)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getData(), res)
    end
    return res
end

---@param param Parameter
---@param value number
---@return number
function public:addAddit(param, value)
    local res = ValueListPublic.addAddit(self, param, value)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getData(), res)
    end
    return res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'k'})

---@param self ParameterContainerUnit
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner

    }
    private.data[self] = priv
    private.owners[owner] = self

    for i = 1, #Defines.AllParameters do
        self:addBase(Defines.AllParameters[i], 0)
    end
end

---@param self ParameterContainerUnit
---@param param Parameter
---@return number
function private.getResult(self, param)
    local res = self:getResult(param)
    if res > param:getMax() then res = param:getMax() end
    if res < param:getMin() then res = param:getMin() end
    return res
end

return static