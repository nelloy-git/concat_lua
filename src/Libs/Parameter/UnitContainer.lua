--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger
local Unit = UtilsLib.Handle.Unit
---@type DamageLib
local DamageLib = depencies.DamageLib

---@type ParameterValueListClass
local ValueList = require(lib_modname..'.ValueList')
local ValueListPublic = Class.getPublic(ValueList)
---@type ParameterDefines
local Defines = require(lib_modname..'.Defines')
--endregion

--=======
-- Class
--=======

local UnitParameterContainer = Class.new('UnitParameterContainer', ValueList)
--region Class
---@class UnitParameterContainer : ParameterValueList
local public = UnitParameterContainer.public
---@class UnitParameterContainerClass : ParameterValueListClass
local static = UnitParameterContainer.static
---@type UnitParameterContainerClass
local override = UnitParameterContainer.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param owner Unit
---@param child_instance UnitParameterContainer | nil
---@return UnitParameterContainer
function override.new(owner, child_instance)
    checkType(owner, Unit, 'owner')
    if child_instance then
        checkType(child_instance, UnitParameterContainer, 'child_instance')
    end

    if private.owners[owner] then
        Log:msg(tostring(UnitParameterContainer)..' container exists.')
        return private.owners[owner]
    end

    local instance = child_instance or Class.allocate(UnitParameterContainer)
    instance = ValueList.new(instance)
    private.newData(instance, owner)

    return instance
end

---@param owner Unit
---@return UnitParameterContainer | nil
function static.get(owner)
    return private.owners[owner]
end

--=================
-- Damage callback
--=================

local Def = Defines.Defence
local PReduc = Defines.PhysicalDamageReduction
local Res = Defines.Resistance
local MReduc = Defines.MagicalDamageReduction

---@type DamageEventCallback
static.DamageCallback = function(dmg, dmg_type, target, damager)
    local target_params = static.get(target)
    if not target_params then return dmg end

    if dmg_type == DamageLib.DamageType.Physical then
        return dmg * (1 - target_params:getResult(PReduc)) - target_params:getResult(Def)
    elseif dmg_type == DamageLib.DamageType.Magical then
        return dmg * (1 - target_params:getResult(MReduc)) - target_params:getResult(Res)
    end
    return dmg
end

--========
-- Public
--========

---@param param Parameter
---@param value number
function public:addBase(param, value)
    ValueListPublic.addBase(self, param, value)
    local result = self:getResult(param)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getHandleData(), result)
    end
end

---@param param Parameter
---@param value number
function public:addMult(param, value)
    ValueListPublic.addMult(self, param, value)
    local result = self:getResult(param)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getHandleData(), result)
    end
end

---@param param Parameter
---@param value number
function public:addAddit(param, value)
    ValueListPublic.addAddit(self, param, value)
    local result = self:getResult(param)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getHandleData(), result)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'k'})

---@param self UnitParameterContainer
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

return static