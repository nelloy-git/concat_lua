--=========
-- Include
--=========

---@type AbilityTypeCallbacksContainerClass
local AbilityTypeCallbacksContainer = require('Class.Ability.AbilityTypeCallbacksContainer')
---@type AbilityTypeFlagsClass
local AbilityTypeFlagsContainer = require('Class.Ability.AbilityTypeFlagsContainer')
---@type DataBaseClass
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

---@type AbilityTypeClass
local AbilityType = newClass('AbilityType')

---@class AbilityType
local public = AbilityType.public
---@class AbilityTypeClass
local static = AbilityType.static
---@type table
local override = AbilityType.override
---@type table(Ability, table)
local private = {}


---@type AbilityTypeCallbacksContainer
public.callbacks = "AbilityTypeCallbacksContainer"
---@type AbilityTypeFlagsClass
public.flags = "AbilityTypeFlags"

private.DB = DataBase.new('number', getClassName(AbilityType))
--=========
-- Methods
--=========

---@param instance_data table | nil
---@return AbilityType
function static.new(id, instance_data)
    local instance = instance_data or newInstanceData(AbilityType)

    instance.callbacks = AbilityTypeCallbacksContainer.new()
    instance.flags = AbilityTypeFlagsContainer.new()

    local priv = {
        id = ID(id),
        casting_time = nil,
    }
    private[instance] = priv
    private.DB:set(ID(id), instance)

    return instance
end

---@return AbilityType
function static.get(id)
    return private.DB:get(id)
end

---@return number
function public:getId()
    local priv = private[self]
    return priv.id
end

---@param caster unit
---@return number
function public:getCastingTime(caster)
    local priv = private[self]

    if type(priv.casting_time) == 'function' then
        return priv.casting_time(caster)
    elseif type(priv.casting_time) == 'number' then
        return priv.casting_time
    end
    return 0
end

---@param func fun(caster:unit):number | number
function public:setCastingTime(func)
    local priv = private[self]
    priv.casting_time = func
end

return AbilityType