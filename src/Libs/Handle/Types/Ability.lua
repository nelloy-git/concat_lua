--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

--=======
-- Class
--=======

local Ability = Class.new('Ability', Handle)
---@class Ability : Handle
local public = Ability.public
---@class AbilityClass : HandleClass
local static = Ability.static
---@type AbilityClass
local override = Ability.override
local private = {}

--=========
-- Static
--=========

---@param owner unit
---@param abil_id number
---@param child Ability | nil
---@return Ability
function override.new(owner, abil_id, child)
    isTypeErr(owner, 'unit', 'owner')
    isTypeErr(abil_id, 'number', 'abil_id')
    if child then isTypeErr(child, Ability, 'child') end

    local handle = BlzGetUnitAbility(owner, abil_id)
    if handle ~= nil then
        Log:err('Can not add second ability with the same ID to unit.', 2)
    end

    local instance = child or Class.allocate(Ability)
    UnitAddAbility(owner, abil_id)
    handle = BlzGetUnitAbility(owner, abil_id)
    if handle == nil then
        Log:err('Can not create handle for Ability.', 2)
    end

    instance = Handle.new(handle, private.destroyAbilityHandle, instance)

    private.newData(instance, owner, abil_id)

    return instance
end

--========
-- Public
--========

---@return unit
function public:getOwner()
    return private.data[self].owner
end

---@return number
function public:getId()
    return private.data[self].abil_id
end

----- Does not work.
-----@param icon string
--function public:setIconNormal(icon)
--    BlzSetAbilityStringField(self:getData(), ABILITY_SF_ICON_ACTIVATED, icon)
--end

---@param tooltip string
---@param lvl number
function public:setTooltipNormal(tooltip, lvl)
    BlzSetAbilityStringLevelField(self:getData(), ABILITY_SLF_TOOLTIP_NORMAL, lvl - 1, tooltip)
end

---@param tooltip string
---@param lvl number
function public:setTooltipNormalExtended(tooltip, lvl)
    BlzSetAbilityStringLevelField(self:getData(), ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, lvl - 1, tooltip)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Ability
---@param owner unit
---@param abil_id number
function private.newData(self, owner, abil_id)
    local priv = {
        owner = owner,
        abil_id = abil_id
    }
    private.data[self] = priv
end

---@param handle ability
function private.destroyAbilityHandle(handle)
    local abil = static.getLinked(handle)
    local owner = abil:getOwner()
    local abil_id = abil:getId()
    UnitRemoveAbility(owner, abil_id)
end

return static