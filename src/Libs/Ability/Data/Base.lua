--=========
-- Include
--=========

--region Include
local lib_modename = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Action
local ActionList = UtilsLib.ActionList
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Unit = UtilsLib.Handle.Unit

---@type AbilityDataTypeClass
local AbilityDataType = require(lib_modename..'.Data.Type')
---@type AbilityDummyClass
local AbilityDummy = require(lib_modename..'.Dummy.Base')
---@type AbilityCooldownChargesClass
local AbilityCooldownCharges = require(lib_modename..'.Cooldown.Charges')
---@type AbilityCastingClass
local AbilityCastingController = require(lib_modename..'.Casting.Controller')
--endregion

--=======
-- Class
--=======

local AbilityData = Class.new('AbilityData')
--region Class
---@class AbilityData
local public = AbilityData.public
---@class AbilityDataClass
local static = AbilityData.static
---@type AbilityDataClass
local override = AbilityData.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param owner Unit
---@param abil_type AbilityDataType
---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param child_instance AbilityData | nil
---@return AbilityData
function override.new(owner, abil_type, hotkey, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    checkTypeErr(abil_type, AbilityDataType, 'abil_type')
    checkTypeErr(hotkey, 'string', 'hotkey')
    if child_instance then checkTypeErr(child_instance, AbilityData, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityData)
    private.newData(instance, owner, abil_type, hotkey)

    return instance
end

--==================
-- Static callbacks
--==================

---@alias AbilityDataEventCallback fun(abil_data:AbilityData)

---@alias AbilityDataEvent number
override.EVENT = {}
---@type AbilityDataEvent
static.EVENT.NoCharges = 1

---@param event AbilityDataEvent
---@param callback AbilityDataEventCallback
---@return Action
function override.addEventAction(event, callback)
    return private.event_actions[event]:addAction(callback)
end

---@param event AbilityDataEvent
---@param action Action
---@return boolean
function override.removeEventAction(event, action)
    return private.event_actions[event]:removeAction(action)
end

--========
-- Public
--========

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@return AbilityDataType
function public:getType()
    return private.data[self].abil_type
end

---@return string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
function public:getHotkey()
    return private.data[self].hotkey
end

---@param target AbilityTarget
function public:use(target)
    local priv = private.data[self]

    -- Check charges
    local charges = priv.abil_charges:getChargesLeft()
    local need_charges = priv.abil_type:getChargesForUse()
    if charges < need_charges then
        private.event_actions[static.EVENT.NoCharges]:run(self)
        return
    end


    -- TODO other conditions


    -- Consume
    priv.abil_charges:setChargesLeft(charges - need_charges)

    -- Start casting
    priv.abil_casting:start(target)
end

--function public:cancel()
--end

--function public:interrupt()
--end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityData
---@param owner Unit
---@param abil_type AbilityDataType
---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
function private.newData(self, owner, abil_type, hotkey)
    local priv = {
        owner = owner,
        abil_type = abil_type,
        hotkey = hotkey,

        abil_dummy = AbilityDummy.new(owner, hotkey),
        abil_charges = AbilityCooldownCharges.new(owner, abil_type),
        abil_casting = AbilityCastingController.new(owner, abil_type)
    }
    private.data[self] = priv

    -- Init dummy
    priv.abil_dummy:setEffectAction(private.used_dummy_action)
    private.dummy2instance[priv.abil_dummy] = self
    -- Init charges
    priv.abil_charges:setChargesChangedAction(private.charges_changed_action)
    private.charges2instance[priv.abil_charges] = self
    -- Init casting
    private.casting2instance[priv.abil_casting] = self
end

-----------
-- Events
-----------

private.event_actions = {}
for _, event in pairs(static.EVENT) do
    private.event_actions[event] = ActionList.new(AbilityData)
end

-----------
-- Dummy --
-----------

private.dummy2instance = setmetatable({}, {__mode = 'kv'})

---@type AbilityDummyCallback
private.used_dummy_callback = function(abil_dummy)
    ---@type AbilityData
    local self = private.dummy2instance[abil_dummy]
    self:use()
    -- TODO AbilityTarget
end
private.used_dummy_action = Action.new(private.used_dummy_callback, AbilityData)

---@param self AbilityData
---@param priv table
---@return boolean
function private.checkCharges(self, priv)
    -- Check charges
    local charges = priv.abil_charges:getChargesLeft()
    local need_charges = priv.abil_type:getChargesForUse()
    if charges < need_charges then
        return false
    end
    return true
end

-------------
-- Charges --
-------------

private.charges2instance = setmetatable({}, {__mode = 'kv'})

---@type AbilityCooldownChargesCallback
private.charges_changed_callback = function(abil_charges)
    ---@type AbilityData
    local self = private.charges2instance[abil_charges]
    local abil_dummy = private.data[self].abil_dummy

    -- Update cooldown of dummy
    local charges = abil_charges:getChargesLeft()
    if charges <= 0 then
        abil_dummy:setCooldown(abil_charges:getChargeCooldown())
        abil_dummy:setCooldownRemaining(abil_charges:getChargeCooldownLeft())
    else
        abil_dummy:setCooldown(0)
        abil_dummy:setCooldownRemaining(0)
    end
end
private.charges_changed_action = Action.new(private.charges_changed_callback, AbilityData)

-------------
-- Casting --
-------------

private.casting2instance = setmetatable({}, {__mode = 'kv'})



return static