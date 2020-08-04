--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Timer = UtilsLib.Handle.Timer

---@type AbilityCooldownCatcherClass
local AbilityCooldownCatcher = require(lib_modname..'.Cooldown.Catcher')
---@type AbilityCooldownInstanceClass
local AbilityCooldownInstance = require(lib_modname..'.Cooldown.Instance')
---@type AbilityDummyClass
local AbilityDummy = require(lib_modname..'.Dummy.Base')
--endregion

--=======
-- Class
--=======

local AbilityDummyCharges = Class.new('AbilityDummyCharges', AbilityCooldownCatcher)
--region Class
---@class AbilityDummyCharges
local public = AbilityDummyCharges.public
---@class AbilityDummyChargesClass
local static = AbilityDummyCharges.static
---@type AbilityDummyChargesClass
local override = AbilityDummyCharges.override
local private = {}
--endregion

--========
-- Static
--========

---@param abil_dummy AbilityDummy
---@param abil_type_cooldown AbilityDataTypeCooldownClass
---@param child_instance AbilityDummy | nil
---@return AbilityDummyCharges
function override.new(abil_dummy, abil_type_cooldown, child_instance)
    checkTypeErr(abil_dummy, AbilityDummy, 'abil_dummy')
    if child_instance then checkTypeErr(child_instance, AbilityDummyCharges, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityDummyCharges)
    instance = AbilityCooldownCatcher.new(instance)

    private.newData(instance, abil_dummy, abil_type_cooldown)

    return instance
end

--========
-- Public
--========

---@param charges number
---@param ignore_max boolean
function public:setChargesLeft(charges, ignore_max)
    local priv = private.data[self]

    private.updateData(self)

    if charges >= priv.max_charges then
        priv.charges = ignore_max and charges or priv.max_charges

        priv.cooldown_data:cancel()

        priv.abil_dummy:setCooldown(0)
        priv.abil_dummy:setCooldownRemaining(0)
    elseif charges <= 0 then
        priv.charges = 0

        if priv.cooldown_data:getTimeLeft() < 0 then
            priv.cooldown_data:start(priv.charge_cooldown)
        end

        priv.abil_dummy:setCooldown(priv.charge_cooldown)
        local timer = Timer.new()
        timer:start(0, false, function() priv.abil_dummy:setCooldownRemaining(priv.cooldown_data:getTimeLeft()) timer:destroy() end)
    else
        priv.charges = charges

        if priv.cooldown_data:getTimeLeft() < 0 then
            priv.cooldown_data:start(priv.charge_cooldown)
        end
        priv.abil_dummy:setCooldown(0)
        priv.abil_dummy:setCooldownRemaining(0)
    end
end

---@return number
function public:getChargesLeft()
    return private.data[self].charges
end

---@return number
function public:getChargesMax()
    private.updateData(self)
    return private.data[self].max_charges
end

---@return number
function public:getChargeCooldown()
    private.updateData(self)
    return private.data[self].charge_cooldown
end

function public:onCooldownFinish()
    self:setChargesLeft(self:getChargesLeft() + 1)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityDummyCharges
---@param abil_dummy AbilityDummy
---@param abil_type_cooldown AbilityDataTypeCooldown
function private.newData(self, abil_dummy, abil_type_cooldown)
    local owner = abil_dummy:getOwner()
    local priv = {
        charges = 1,
        max_charges = abil_type_cooldown:getChargesMax(owner),
        charge_cooldown = abil_type_cooldown:getChargeCooldown(owner),

        abil_dummy = abil_dummy,
        abil_type_cooldown = abil_type_cooldown,
        cooldown_data = AbilityCooldownInstance.new(self)
    }
    private.data[self] = priv
end

function private.updateData(self)
    local priv = private.data[self]

    local owner = priv.abil_dummy:getOwner()
    -- Update maximum charges
    priv.max_charges = priv.abil_type_cooldown:getChargesMax(owner)
    -- Update charge cooldown
    priv.charge_cooldown = priv.abil_type_cooldown:getChargeCooldown(owner)
end

return static