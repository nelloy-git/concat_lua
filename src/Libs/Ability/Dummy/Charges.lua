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
local Log = UtilsLib.DefaultLogger

---@type AbilityCooldownCatcherClass
local AbilityCooldownCatcher = require(lib_modname..'.Cooldown.Catcher')
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
---@param child_instance AbilityDummy | nil
---@return AbilityDummyCharges
function override.new(abil_dummy, child_instance)
    checkTypeErr(abil_dummy, AbilityDummy, 'abil_dummy')
    if child_instance then checkTypeErr(child_instance, AbilityDummyCharges, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityDummyCharges)
    instance = AbilityCooldownCatcher.new(instance)

    private.newData(instance, abil_dummy)

    return instance
end

--========
-- Public
--========

function public:onCooldownLoop() end

function public:onCooldownFinish() end

---@param charges number
---@param ignore_max boolean
function public:setChargesLeft(charges, ignore_max)
    local priv = private.data[self]

    if priv.max_charges <= charges and not ignore_max then
    elseif charges == 0 then

    end
end

---@return number
function public:getChargesLeft()
    return private.data[self].charges
end

function public:setMaxCharges(max_charges, ignore_max)
    local priv = private.data[self]

    priv.max_charges = max_charges
    if max_charges <= priv.charges and not ignore_max then
        priv.charges = priv.max_charges
        if priv.cooldown_data then priv.cooldown_data:finish() end
    else
        if not priv.cooldown_data then
            priv.cooldown_data = AbilityCooldownInstance.new(self)
            priv.cooldown_data:start(priv.charge_cooldown)
        end
    end
end

---@return number
function public:getChargesMax()
    return private.data[self].max_charges
end

---@param charge_cooldown number
function public:setChargeCooldown(charge_cooldown)
    private.data[self].charge_cooldown = charge_cooldown
end

---@return number
function public:getChargeCooldown()
    return private.data[self].charge_cooldown
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityDummyCharges
---@param abil_dummy AbilityDummy
function private.newData(self, abil_dummy)
    local priv = {
        max_charges = 1,
        charges = 1,

        abil_dummy = abil_dummy,
        cooldown_data = nil
    }
    private.data[self] = priv
end

return static