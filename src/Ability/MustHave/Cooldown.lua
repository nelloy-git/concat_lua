--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

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

--========
-- Public
--========

---@param charges number
function public:setCharges(charges)
    local priv = private.data[self] or private.newData(self)

    priv.charges = math.max(charges, 0)
    private.checkChargesCooldown(self, priv)
end

---@param charges number
function public:addCharges(charges)
    local priv = private.data[self] or private.newData(self)

    priv.charges = math.max(priv.charges + charges, 0)
    private.checkChargesCooldown(self, priv)
end

---@param max_charges number
function public:setMaxCharges(max_charges)
    local priv = private.data[self] or private.newData(self)

    priv.max_charges = max_charges
    private.checkChargesCooldown(self, priv)
end

---@return number
function public:getCharges()
    local priv = private.data[self] or private.newData(self)

    return priv.charges
end

---@return number
function public:getMaxCharges()
    local priv = private.data[self] or private.newData(self)

    return priv.max_charges
end

---@return number
function public:getCooldownTimeLeft()
    local new_charge_time = private.on_cooldown[self]
    if not new_charge_time then
        return -1
    end
    return new_charge_time - private.cur_time
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.on_cooldown = setmetatable({}, {__mode = 'k'})

private.timer_period = 0.05
private.cur_time = 0
function private.timerLoop()
    local cur_time = private.cur_time + private.timer_period
    private.cur_time = cur_time

    for self, new_charge_time in pairs(private.on_cooldown) do
        if new_charge_time <= cur_time then
            local priv = private.data[self]

            priv.charges = priv.charges + 1
            private.on_cooldown[self] = nil

            private.checkChargesCooldown(self, priv)
        end
    end
end

---@param self Ability
function private.checkChargesCooldown(self, priv)

    if priv.charges < priv.max_charges then
        -- Is on cooldown already?
        if private.on_cooldown[self] then
            return
        end

        -- Adds charge gain delay
        private.on_cooldown[self] = private.cur_time + self:getType():getCooldown(self:getOwner(), self:getLevel())
        return
    end

    -- priv.charges >= priv.max_charges
    -- Stop cooldown
    private.on_cooldown[self] = nil
end

---@param self Ability
function private.newData(self)
    local priv = {
        charges = 1,
        max_charges = 1,
    }
    private.data[self] = priv

    return priv
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.timer_period, true, private.timerLoop)
end