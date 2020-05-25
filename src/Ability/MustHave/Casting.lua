--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type AbilityClass
local Ability = require('Ability.Ability')
---@type TimerClass
local Timer = require('Timer.Timer')

--=======
-- Class
--=======

---@type Ability
local public = Class.getPublic(Ability)
---@type AbilityClass
local static = Ability
---@type AbilityClass
local override = Class.getOverride(Ability)
local private = {}

--=========
-- Static
--=========

---@return number
function static.getCastingPeriod()
    return private.timer_period
end

---@param caster Unit
---@return Ability | nil
function static.getCastingAbility(caster)
    if not private.is_casting[caster] then
        return nil
    end
    return private.is_casting[caster].ability
end

---@param caster Unit
---@return AbilityTarget | nil
function static.getCastingTarget(caster)
    if not private.is_casting[caster] then
        return nil
    end
    return private.is_casting[caster].target
end

---@param caster Unit
---@return number
function static.getCastingTimeLeft(caster)
    if not private.is_casting[caster] then
        return -1
    end

    return private.is_casting[caster].end_time - private.cur_time
end

---@param caster Unit
---@return number
function static.getCastingTimeFull(caster)
    if not private.is_casting[caster] then
        return -1
    end
    return private.is_casting[caster].full_time
end

---@param caster Unit
---@return boolean
function static.cancelCastingAbility(caster)
    local data = private.is_casting[caster]
    if data then
        data.ability:getType():cancel(caster, data.target, data.ability:getLevel())
        private.is_casting[caster] = nil
        return true
    end
    return false
end

---@param caster Unit
---@return boolean
function static.interruptCastingAbility(caster)
    local data = private.is_casting[caster]
    if data then
        data.ability:getType():interrupt(caster, data.target, data.ability:getLevel())
        private.is_casting[caster] = nil
        return true
    end
    return false
end

---@param caster Unit
---@return boolean
function static.finishCastingAbility(caster)
    local data = private.is_casting[caster]
    if data then
        data.ability:getType():finish(caster, data.target, data.ability:getLevel())
        private.is_casting[caster] = nil
        return true
    end
    return false
end

---@param caster Unit
---@return boolean
function static.extraPeriodForCastingAbility(caster)
    local data = private.is_casting[caster]
    if data then
        data.ability:getType():casting(caster, data.target, data.ability:getLevel())
        data.end_time = data.end_time - private.timer_period
        return true
    end
    return false
end

--========
-- Public
--========

---@param target AbilityTarget
---@return boolean
function public:use(target)
    local caster = self:getOwner()
    local abil_type = self:getType()
    local lvl = self:getLevel()

    if private.is_casting[caster] then
        -- TODO callback
        print('Unit is casting another ability.')
        return false
    end

    if abil_type:getRange(caster, lvl) < target:getDistance(caster) then
        -- TODO callback
        print('Out of range')
        return false
    end

    local mana_cost = abil_type:getManaCost(caster, lvl)
    local cur_mana = caster:getCurrentMana()
    if mana_cost > cur_mana then
        -- TODO callback
        print('Out of mana.')
        return false
    end

    local charges_cost = abil_type:getChargesCost(caster, lvl)
    print(charges_cost, self:getCharges())
    if charges_cost > self:getCharges() then
        -- TODO callback
        print('Out of charges.')
        return false
    end

    if not abil_type:start(caster, target, lvl) then
        -- TODO callback
        print('Ability has not started.')
        return false
    end

    self:addCharges(-charges_cost)
    caster:setCurrentMana(cur_mana - mana_cost)
    private.newData(self, target, abil_type:getCastingTime(caster, lvl))

    return true
end

--=========
-- Private
--=========

private.is_casting = setmetatable({}, {__mode = 'kv'})

private.timer_period = 0.1
private.cur_time = 0

function private.timerLoop()
    local cur_time = private.cur_time + private.timer_period
    private.cur_time = cur_time

    for caster, data in pairs(private.is_casting) do
        if data.end_time <= cur_time then
            data.ability:getType():finish(caster, data.target, data.ability:getLevel())
            private.is_casting[caster] = nil
        else
            data.ability:getType():casting(caster, data.target, data.ability:getLevel())
        end
    end
end

---@param self Ability
function private.newData(self, target, casting_time)
    local data = {
        ability = self,
        target = target,
        end_time = private.cur_time + casting_time,
        full_time = casting_time
    }
    private.is_casting[self:getOwner()] = data
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.timer_period, true, private.timerLoop)
end