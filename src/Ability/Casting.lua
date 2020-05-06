local AbilityCasting = {}

---@param ability Ability
---@return boolean
local function isCasting(ability)
    return ability.casting_time_left > 0
end

---@param ability Ability
---@param target AbilityTarget
---@return boolean
local function inRange(ability, target)
    return ability:getRange() > target:getDistance(ability:getOwner())
end

---@param ability Ability
---@return boolean
local function hasCharges(ability)
    return ability.charges_left > ability:getChargesCost()
end

---@param ability Ability
---@return boolean
local function hasMana(ability)
    local cur_mana = GetUnitState(ability:getOwner(), UNIT_STATE_MANA)
    return cur_mana > ability:getManaCost()
end

---@param ability Ability
---@param target AbilityTarget
function AbilityCasting.cb_AlreadyCasting(ability, target)
    print('Unit is casting another ability.')
end

---@param ability Ability
---@param target AbilityTarget
function AbilityCasting.cb_OutOfRange(ability, target)
    print('Caster is out of range.')
end

---@param ability Ability
---@param target AbilityTarget
function AbilityCasting.cb_NoCharges(ability, target)
    print('Caster has not enought charges.')
end

---@param ability Ability
---@param target AbilityTarget
function AbilityCasting.cb_NoMana(ability, target)
    print('Caster has no mana.')
end

---@param ability Ability
---@param target AbilityTarget
---@return boolean
function AbilityCasting.use(ability, target)
    if isCasting(ability) then
        AbilityCasting.cb_AlreadyCasting(ability, target)
        return false
    end

    if not inRange(ability, target) then
        AbilityCasting.cb_OutOfRange(ability, target)
        return false
    end

    if not hasCharges(ability) then
        AbilityCasting.cb_NoCharges(ability, target)
        return false
    end

    if not hasMana(ability) then
        AbilityCasting.cb_NoMana(ability, target)
        return false
    end
end

return AbilityCasting