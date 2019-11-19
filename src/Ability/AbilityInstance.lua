--=========
-- Include
--=========

---@type DataBaseClass
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

---@type AbilityInstanceClass
local AbilityInstance = newClass('AbilityInstance')

---@class AbilityInstance
local public = AbilityInstance.public
---@class AbilityInstanceClass
local static = AbilityInstance.static
---@type table
local override = AbilityInstance.override
---@type table(AbilityInstance, table)
local private = {}

private.db = DataBase.new('userdata', getClassName(AbilityInstance))

--=========
-- Methods
--=========

---@param ability_id number
---@param cast_time number
---@param instance_data table | nil
---@return AbilityInstance
function static.new(ability_id, cast_time, instance_data)
    local instance = instance_data or newInstanceData(AbilityInstance)
    local priv = {
        ability_id = ability_id,
        time_left = cast_time,
        
        can_move = true,
        can_attack = true
    }
    private[instance] = priv

    return instance
end

---@return AbilityInstance | nil
function static.getCurrent(caster)
    return private.db:get(caster)
end

function public:start(caster, can_move, can_attack)
    local priv = private[self]
    private.db:set(caster, self)

    if not can_move then
        priv.can_move = false
    end

    if not can_attack then
        priv.can_attack = false

    end
end

function public:stop()

return AbilityInstance