--=========
-- Include
--=========

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')
---@type UnitParametersContainerClass
local UnitParameterContainer = require('Class.Unit.UnitParametersContainer')

--=======
-- Class
--=======

---@type AbilityInstanceClass
local AbilityInstance = newClass('AbilityInstance')

---@class AbilityInstance
local public = AbilityInstance.public

public.time_left = 0

---@class AbilityInstanceClass
local static = AbilityInstance.static
---@type table
local override = AbilityInstance.override
---@type table(AbilityInstance, table)
local private = {}

private.DB = DataBase.new('userdata', getClassName(AbilityInstance))
private.ms_const = 10^10
private.disable_attack_id = ID('Abun')

--=========
-- Methods
--=========

---@param ability_id number | string
---@param cast_time number
---@param instance_data table | nil
---@return AbilityInstance
function static.new(ability_id, cast_time, instance_data)
    local instance = instance_data or newInstanceData(AbilityInstance)
    instance.time_left = cast_time
    local priv = {
        is_running = false,

        caster = nil,
        ability_id = ID(ability_id),
        
        can_move = true,
        can_attack = true
    }
    private[instance] = priv

    return instance
end

---@return AbilityInstance | nil
function static.getCurrent(caster)
    return private.DB:get(caster)
end

---@param caster unit
---@param can_move boolean
---@param can_attack boolean
function public:start(caster, can_move, can_attack)
    local priv = private[self]

    priv.caster = caster
    private.DB:set(caster, self)

    if priv.is_running then
        Debug(string.format("%s error: can not run. Already running.", getClassName(AbilityInstance)))
        return nil
    end

    priv.is_running = true

    if not can_move then
        local params = UnitParameterContainer.get(caster)
        params:addMult(ParameterType.MS, -private.ms_const)
        priv.can_move = false
    end

    if not can_attack then
        UnitAddAbility(caster, private.disable_attack_id)
        priv.can_attack = false
    end
end

function public:free()
    private.stop(self)
    private[self] = nil
    freeInstanceData(self)
end

---@return number
function public:getId()
    local priv = private[self]
    return priv.ability_id
end

---@param self AbilityInstance
function private.stop(self)
    local priv = private[self]
    if not priv.is_running then
        Debug(string.format("%s error: can not stop. Is not running.", getClassName(AbilityInstance)))
        return nil
    end

    if not priv.can_move then
        local params = UnitParameterContainer.get(priv.caster)
        params:addMult(ParameterType.MS, private.ms_const)
    end

    if not priv.can_attack then
        UnitRemoveAbility(priv.caster, private.disable_attack_id)
    end
end

return AbilityInstance