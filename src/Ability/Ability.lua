--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityTypeClass
local AbilityType = require('Ability.Type')
---@type TimerClass
local Timer = require('Timer.Timer')

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
function static.getLastOrdered(unit)
    return private.last_ability[unit]
end

--========
-- Public
--========

---@param target AbilityTarget
---@return boolean
function public:use(target)
    local priv = private.data[self]

    local owner = priv.owner
    local lvl = priv.lvl
    local abil_type = priv.ability_type

    if not private.isInRange(owner, target, abil_type:getRange(owner, lvl)) then
        print('Out of range.')
        return false
    end

    local mana_cost = abil_type:getManaCost(owner, lvl)
    if GetUnitState(owner:getObj(), UNIT_STATE_MANA) < mana_cost then
        print('No mana.')
        return false
    end

    if priv.charges < 1 then
        print('Is on cooldown.')
        return false
    end

    local cur = private.last_ability[owner]
    if cur then
        private.removeAbil(owner:getObj(), private.data[cur].ability_type:getId())
    end

    priv.charges = priv.charges - 1
    if priv.cooldown <= private.timer_cur_time then
        priv.cooldown = private.timer_cur_time + abil_type:getCooldown(owner, lvl)
    end

    UnitAddAbility(owner:getObj(), abil_type:getId())
    local success = target:order(owner, private.spell_order_id)
    if not success then
        UnitRemoveAbility(owner:getObj(), abil_type:getId())
        Log.error(self:getName(), 'order error', 2)
    end
    private.last_ability[owner] = self

    return true
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

---@return number
function public:getCharges()
    return private.data[self].charges
end

---@return number
function public:getMaxCharges()
    return private.data[self].max_charges
end

---@return number
function public:getCooldown()
    return math.max(0, private.data[self].cooldown - private.timer_cur_time)
end

---@return number
function public:getManaCost()
    local priv = private.data[self]
    return priv.ability_type:getManaCost(priv.owner, priv.lvl)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.unit2abil = setmetatable({}, {__mode = 'kv'})
private.last_ability = setmetatable({}, {__mode = 'kv'})

private.spell_order_id = AbilityType.getOrderId()

---@param caster Unit
---@param target AbilityTarget
---@param max_range number
function private.isInRange(caster, target, max_range)
    local range = ((caster:getX() - target:getX())^2 + (caster:getY() - target:getY())^2)^0.5

    if range > max_range then
        return false
    end
    return true
end

---@param unit_obj unit
---@param id number
function private.removeAbil(unit_obj, id)
    if GetUnitAbilityLevel(unit_obj, id) > 0 then
        UnitRemoveAbility(unit_obj, id)
    end
end

function private.timerLoop()
    local time = private.timer_cur_time + private.timer_period
    private.timer_cur_time = time

    for instance, priv in pairs(private.data) do
        if priv.cooldown >= time then
            if priv.charges >= priv.max_charges then
                Log.error(Ability, 'error in charges gaining.', 1)
            end
            priv.charges = private.charges + 1

            if priv.charges < priv.max_charges then
                priv.cooldown = priv.cooldown + priv.ability_type:getCooldown(priv.owner, priv.lvl)
            end
        end
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
        cooldown = 0,
        charges = 1,
        max_charges = 1
    }
    private.data[self] = priv
    private.unit2abil[owner] = self
end

if not IsCompiletime() then
    private.timer_period = 0.05
    private.timer_cur_time = 0
    private.timer = Timer.new()
    private.timer:start(private.timer_period, true, private.timerLoop)
end

return static