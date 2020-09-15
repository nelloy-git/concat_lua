--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type AbilityCooldownClass
local AbilityCooldown = require(lib_path..'.Cooldown.Base')
---@type AbilityCooldownTypeClass
local AbilityCooldownType = require(lib_path..'.Cooldown.Type')

--=======
-- Class
--=======

local AbilityCooldownCharges = Class.new('AbilityCooldownCharges')
---@class AbilityCooldownCharges
local public = AbilityCooldownCharges.public
---@class AbilityCooldownChargesClass
local static = AbilityCooldownCharges.static
---@type AbilityCooldownChargesClass
local override = AbilityCooldownCharges.override
local private = {}

--========
-- Static
--========

---@alias AbilityCooldownChargesCallback fun(charges:AbilityCooldownCharges)

---@param owner Unit
---@param abil_cooldown_type AbilityCooldownTypeClass
---@param child AbilityCooldownCharges | nil
---@return AbilityCooldownCharges
function override.new(owner, abil_cooldown_type, child)
    isTypeErr(owner, Unit, 'owner')
    isTypeErr(abil_cooldown_type, AbilityCooldownType, 'abil_cooldown_type')
    if child then isTypeErr(child, AbilityCooldownCharges, 'child') end

    local instance = child or Class.allocate(AbilityCooldownCharges)
    private.newData(instance, abil_cooldown_type, owner)

    instance:setChargesLeft(1)

    return instance
end

--========
-- Public
--========

---@param charges number
---@param ignore_max boolean | nil
function public:setChargesLeft(charges, ignore_max)
    local priv = private.data[self]

    local prev_charges = priv.charges
    private.updateData(self, priv)

    if charges >= priv.max_charges then
        priv.charges = ignore_max and charges or priv.max_charges

        priv.cooldown_data:cancel()
    elseif charges <= 0 then
        priv.charges = 0

        if priv.cooldown_data:getTimeLeft() < 0 then
            priv.cooldown_data:start(priv.charge_cooldown)
        end
    else
        priv.charges = charges

        if priv.cooldown_data:getTimeLeft() < 0 then
            priv.cooldown_data:start(priv.charge_cooldown)
        end
    end

    if priv.charges ~= prev_charges and priv.changed_action then
        priv.changed_action:run(self)
    end
end

---@return number
function public:getChargesLeft()
    return private.data[self].charges
end

---@return number
function public:getChargesMax()
    return private.data[self].max_charges
end

---@return number
function public:getChargeCooldownLeft()
    return private.data[self].cooldown_data:getTimeLeft()
end

---@return number
function public:getChargeCooldown()
    return private.data[self].charge_cooldown
end

--===========
-- Callbacks
--===========

---@param callback AbilityCooldownChargesCallback | Action
function public:setChargesChangedAction(callback)
    if type(callback) == 'function' then
        private.data[self].changed_action = Action.new(callback, self)
    elseif callback == nil or Class.type(callback, Action) then
        local action = callback
        private.data[self].changed_action = action
    else
        Log:err('variable \'callback\' is not of type AbilityCooldownChargesCallback | Action', 2)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.cooldown2charges = setmetatable({}, {__mode = 'kv'})

---@param self AbilityCooldownCharges
---@param abil_cooldown_type AbilityCooldownType
---@param owner Unit
function private.newData(self, abil_cooldown_type, owner)
    local priv = {
        charges = 0,
        owner = owner,
        max_charges = abil_cooldown_type:getChargesMax(owner),
        charge_cooldown = abil_cooldown_type:getChargeCooldown(owner),

        abil_cooldown_type = abil_cooldown_type,
        cooldown_data = AbilityCooldown.new(),

        changed_action = nil
    }
    priv.cooldown_data:setFinishAction(private.cooldown_action)

    private.data[self] = priv
    private.cooldown2charges[priv.cooldown_data] = self
end

---@param self AbilityCooldownCharges
---@param priv table
function private.updateData(self, priv)
    -- Update maximum charges
    priv.max_charges = priv.abil_cooldown_type:getChargesMax(priv.owner)
    -- Update charge cooldown
    priv.charge_cooldown = priv.abil_cooldown_type:getChargeCooldown(priv.owner)
end

---@type AbilityCooldownCallback
private.cooldown_callback = function(cooldown_data)
    ---@type AbilityCooldownCharges
    local self = private.cooldown2charges[cooldown_data]
    self:setChargesLeft(self:getChargesLeft() + 1)
end
private.cooldown_action = Action.new(private.cooldown_callback, AbilityCooldown)

return static