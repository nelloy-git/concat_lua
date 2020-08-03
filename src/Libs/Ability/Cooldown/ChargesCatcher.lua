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

---@type AbilityCooldownInstanceClass
local AbilityCooldownInstance = require(lib_modname..'.Cooldown.Instance')
---@type AbilityCooldownCatcherClass
local AbilityCooldownCatcher = require(lib_modname..'.Cooldown.Catcher')
--endregion

--=======
-- Class
--=======

local AbilityCooldownChargesCatcher = Class.new('AbilityCooldownChargesCatcher', AbilityCooldownCatcher)
--region Class
---@class AbilityCooldownChargesCatcher
local public = AbilityCooldownChargesCatcher.public
---@class AbilityCooldownChargesCatcherClass
local static = AbilityCooldownChargesCatcher.static
---@type AbilityCooldownChargesCatcherClass
local override = AbilityCooldownChargesCatcher.override
local private = {}
--endregion

--========
-- Static
--========

---@param child_instance AbilityCooldownChargesCatcher | nil
---@return AbilityCooldownChargesCatcher
function override.new(charge_cooldown, child_instance)
    if child_instance then checkTypeErr(child_instance, AbilityCooldownChargesCatcher, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityCooldownChargesCatcher)
    instance = AbilityCooldownCatcher.new(instance)

    private.newData(instance, charge_cooldown)

    return instance
end

--========
-- Public
--========

---@param charges number
---@param ignore_max boolean
function public:setChargesLeft(charges, ignore_max)
    local priv = private.data[self]

    if priv.max_charges <= charges and not ignore_max then
        priv.charges = priv.max_charges
        if priv.cooldown_data then priv.cooldown_data:finish() end
    else
        priv.charges = charges
        if not priv.cooldown_data then
            priv.cooldown_data = AbilityCooldownInstance.new(self)
            priv.cooldown_data:start(priv.charge_cooldown)
        end
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

function public:onCooldownFinish()
    local priv = private.data[self]

    if priv.charges < priv.max_charges then
        priv.charges = priv.charges + 1
        if priv.charges < priv.max_charges then
            priv.cooldown_data = AbilityCooldownInstance.new(self)
            priv.cooldown_data:start(priv.charge_cooldown)
        end
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityCooldownChargesCatcher
---@param charge_cooldown number
function private.newData(self, charge_cooldown)
    local priv = {
        max_charges = 1,
        charges = 1,
        charge_cooldown = charge_cooldown,

        cooldown_data = nil
    }
    private.data[self] = priv
end

return static