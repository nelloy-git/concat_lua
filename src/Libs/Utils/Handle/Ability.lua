--=========
-- Include
--=========

local lib_modename = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type LoggerClass
local Logger = require(lib_modename..'.Logger')
local Log = Logger.getDefault()
---@type HandleClass
local Handle = require(lib_modename..'.Handle.Handle')
---@type UtilsFunctions
local Functions = require(lib_modename..'.Functions')
local checkTypeErr = Functions.checkTypeErr
---@type ActionClass
local Action = require(lib_modename..'.Action')

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
---@param child_instance Ability | nil
---@return Ability
function override.new(owner, abil_id, child_instance)
    checkTypeErr(owner, 'unit', 'owner')
    checkTypeErr(abil_id, 'number', 'abil_id')
    if child_instance then checkTypeErr(child_instance, Ability, 'child_instance') end

    local handle = BlzGetUnitAbility(owner, abil_id)
    if handle ~= nil then
        Log:err('Can not add second ability with the same ID to unit.', 2)
    end

    local instance = child_instance or Class.allocate(Ability)
    UnitAddAbility(owner, abil_id)
    handle = BlzGetUnitAbility(owner, abil_id)
    if handle == nil then
        Log:err('Can not create handle for Ability.', 2)
    end

    print('Handle: '..tostring(handle))
    print('Name: '..BlzGetAbilityStringLevelField(handle, ABILITY_SLF_TOOLTIP_NORMAL, 0))
    
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
--    BlzSetAbilityStringField(self:getHandleData(), ABILITY_SF_ICON_ACTIVATED, icon)
--end

---@param tooltip string
---@param lvl number
function public:setTooltipNormal(tooltip, lvl)
    BlzSetAbilityStringLevelField(self:getHandleData(), ABILITY_SLF_TOOLTIP_NORMAL, lvl - 1, tooltip)
end

---@param tooltip string
---@param lvl number
function public:setTooltipNormalExtended(tooltip, lvl)
    BlzSetAbilityStringLevelField(self:getHandleData(), ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, lvl - 1, tooltip)
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