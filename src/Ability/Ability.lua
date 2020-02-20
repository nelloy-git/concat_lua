--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityTypeClass
local AbilityType = require('Ability.Type')
---@type SmartTimerClass
local SmartTimer = require('Timer.SmartTimer')
local glTimer = SmartTimer.getGlobalTimer()

--=======
-- Class
--=======

local Ability = Class.new('Ability')
---@class Ability
local public = Ability.public
---@class AbilityClass
local static = Ability.static
---@type AbilityClass
local override = Ability.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param ability_type AbilityType
---@param child_instance Ability | nil
---@return Ability
function static.new(owner, ability_type, child_instance)
    local instance = child_instance or Class.allocate(Ability)
    private.newData(instance, owner, ability_type)

    return instance
end

---@param unit Unit
---@return Ability
function static.getOrdered(unit)
    return private.ordered_ability[unit]
end

--========
-- Public
--========

---@param target AbilityTarget
function public:use(target)
    local priv = private.data[self]
    local caster_x = priv.owner:getX()
    local caster_y = priv.owner:getY()
    local target_x = target:getX()
    local target_y = target:getY()
    local range = (caster_x - target_x)^2 + (caster_y - target_y)^2
    local max_range = priv.ability_type:getRange(priv.owner, priv.lvl)^2

    if range > max_range then
        print('Out of range')
        return
    end

    if private.ordered_ability[priv.owner]  then
        private.removeAbil(priv.owner:getObj(), priv.ability_type:getId())
    end

    UnitAddAbility(priv.owner:getObj(), priv.ability_type:getId())
    local success = target:order(priv.owner, private.spell_order_id)
    if not success then
        UnitRemoveAbility(priv.owner:getObj(), priv.ability_type:getId())
        Log.error(self:getName(), 'order error', 2)
        return
    end
    private.ordered_ability[priv.owner] = self
    glTimer:addAction(1, function() private.removeAbil(priv.owner:getObj(), priv.ability_type:getId()) end)
end

---@return AbilityTarget
function public:getEventTarget()
    return private.data[self].ability_type:getEventTarget()
end

---@param lvl number
function public:setLevel(lvl)
    private.data[self].lvl = lvl
end

---@return string
function public:getName()
    local priv = private.data[self]
    return priv.ability_type:getName(priv.owner, priv.lvl)
end

---@return string
function public:getDescription()
    local priv = private.data[self]
    return priv.ability_type:getDescription(priv.owner, priv.lvl)
end

---@return number
function public:getLevel()
    return private.data[self].lvl
end

---@return AbilityType
function public:getType()
    return private.data[self].ability_type
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.unit2abil = setmetatable({}, {__mode = 'kv'})
private.ordered_ability = setmetatable({}, {__mode = 'kv'})

private.spell_order_id = AbilityType.getOrder()

function private.removeAbil(unit_obj, id)
    if GetUnitAbilityLevel(unit_obj, id) > 0 then
        UnitRemoveAbility(unit_obj, id)
    end
end

---@param owner Unit
---@param self Ability
---@param ability_type AbilityType
function private.newData(self, owner, ability_type)
    local priv = {
        owner = owner,
        ability_type = ability_type,

        lvl = 1,
    }
    private.data[self] = priv
    private.unit2abil[owner] = self
end

return static