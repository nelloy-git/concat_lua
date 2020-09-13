--=========
-- Include
--=========

--region Include
local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class
---@type UtilsLib
local UtilsLib = lib_dep.UtilsLib
local isTypeErr = UtilsLib.isTypeErr
local Log = UtilsLib.Log
local Unit = UtilsLib.Handle.Unit
---@type DamageLib
local DamageLib = lib_dep.DamageLib
local DamageType = DamageLib.DamageType

---@type ParameterValueListClass
local ValueList = require(lib_path..'.ValueList')
local ValueListPublic = Class.getPublic(ValueList)
---@type ParameterDefines
local Defines = require(lib_path..'.Defines')
--endregion

--=======
-- Class
--=======

local ParameterContainerUnit = Class.new('ParameterContainerUnit', ValueList)
--region Class
---@class ParameterContainerUnit : ParameterValueList
local public = ParameterContainerUnit.public
---@class ParameterContainerUnitClass : ParameterValueListClass
local static = ParameterContainerUnit.static
---@type ParameterContainerUnitClass
local override = ParameterContainerUnit.override
local private = {}
--endregion

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
        Log:err('Parameter container already exists.', 2)
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

--=================
-- Damage callback
--=================

local MDmg = Defines.MagicalDamage
local Def = Defines.Defence
local PReduc = Defines.PhysicalDamageReduction
local Res = Defines.Resistance
local MReduc = Defines.MagicalDamageReduction

---@type DamageEventCallback
static.DamageCallback = function(dmg, dmg_type, target, damager)
    local damager_params = static.get(damager)
    local target_params = static.get(target)
    if not target_params then return dmg end

    -- Add magic damage to attacks
    if dmg_type == DamageType.PhysicalAttack then
        local m_atk = damager_params:getResult(MDmg)
        local m_dmg = m_atk * (0.85 + 0.3 * math.random())
        DamageLib.damageUnit(m_dmg, DamageType.MagicalAttack, target, damager, WEAPON_TYPE_WHOKNOWS)
    end

    if dmg_type == DamageType.PhysicalAttack or dmg_type == DamageType.PhysicalSpell then
        dmg = dmg * (1 - target_params:getResult(PReduc)) - target_params:getResult(Def)
    elseif dmg_type == DamageType.MagicalAttack or dmg_type == DamageType.MagicalSpell then
        dmg = dmg * (1 - target_params:getResult(MReduc)) - target_params:getResult(Res)
    end

    dmg = dmg > 0 and dmg or 0
    return dmg
end

--========
-- Public
--========

---@param param Parameter
---@param value number
function public:addBase(param, value)
    ValueListPublic.addBase(self, param, value)
    local result = private.getResult(self, param)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getData(), result)
    end
end

---@param param Parameter
---@param value number
function public:addMult(param, value)
    ValueListPublic.addMult(self, param, value)
    local result = private.getResult(self, param)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getData(), result)
    end
end

---@param param Parameter
---@param value number
function public:addAddit(param, value)
    ValueListPublic.addAddit(self, param, value)
    local result = private.getResult(self, param)
    if Defines.ApplyToUnit[param] then
        Defines.ApplyToUnit[param](private.data[self].owner:getData(), result)
    end
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