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
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local getEnum = UtilsLib.getEnum or error('')

---@type AbilityDataTypeClass
local AbilityDataType = require(lib_path..'.Data.Type') or error('')
---@type AbilityDummyClass
local AbilityDummy = require(lib_path..'.Dummy.Base') or error('')
---@type AbilityCooldownChargesClass
local AbilityCooldownCharges = require(lib_path..'.Cooldown.Charges') or error('')
---@type AbilityCastingClass
local AbilityCastingController = require(lib_path..'.Casting.Controller') or error('')
---@type AbilityInfoClass
local AbilityInfo = require(lib_path..'.Info.Base') or error('')
local INFO_NAME = AbilityInfo.INFO_NAME

---@type AbilityTargetNoneClass
local AbilityTargetNone = require(lib_path..'.Target.None') or error('')
---@type AbilityTargetUnitClass
local AbilityTargetUnit = require(lib_path..'.Target.Unit') or error('')
---@type AbilityTargetPointClass
local AbilityTargetPoint = require(lib_path..'.Target.Point') or error('')

--=======
-- Class
--=======

local AbilityData = Class.new('AbilityData')
---@class AbilityData
local public = AbilityData.public
---@class AbilityDataClass
local static = AbilityData.static
---@type AbilityDataClass
local override = AbilityData.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param abil_type AbilityDataType
---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param child AbilityData | nil
---@return AbilityData
function override.new(owner, abil_type, hotkey, child)
    isTypeErr(owner, Unit, 'owner')
    isTypeErr(abil_type, AbilityDataType, 'abil_type')
    isTypeErr(hotkey, 'string', 'hotkey')
    if child then isTypeErr(child, AbilityData, 'child') end

    local instance = child or Class.allocate(AbilityData)
    private.newData(instance, owner, abil_type, hotkey)

    return instance
end

--==================
-- Static callbacks
--==================

---@alias AbilityDataEventCallback fun(event: AbilityDataEvent, abil_data:AbilityData)

---@alias AbilityDataEvent string
override.EVENT = {}
---@type AbilityDataEvent
static.EVENT.AlreadyCasting = getEnum()
---@type AbilityDataEvent
static.EVENT.NoCharges = getEnum()
---@type AbilityDataEvent
static.EVENT.OutOfRange = getEnum()
---@type AbilityDataEvent
static.EVENT.NeedsAllyTarget = getEnum()
---@type AbilityDataEvent
static.EVENT.NeedsEnemyTarget = getEnum()
---@type AbilityDataEvent
static.EVENT.CastingStart = getEnum()
---@type AbilityDataEvent
static.EVENT.CastingLoop = getEnum()
---@type AbilityDataEvent
static.EVENT.CastingCancel = getEnum()
---@type AbilityDataEvent
static.EVENT.CastingInterrupt = getEnum()
---@type AbilityDataEvent
static.EVENT.CastingFinish = getEnum()

---@param event AbilityDataEvent
---@param callback AbilityDataEventCallback
---@return Action
function override.addEventAction(event, callback)
    return private.event_actions[event]:add(callback)
end

---@param event AbilityDataEvent
---@param action Action
---@return boolean
function override.removeEventAction(event, action)
    return private.event_actions[event]:remove(action)
end

--========
-- Public
--========

---@return AbilityTarget
function public:getTarget()
    return private.data[self].target
end

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
    local EVENT = static.EVENT

    local mana_cost = priv.abil_info:get(INFO_NAME.ManaCost)

    -- Check casting
    if priv.target ~= nil then
        priv.owner:setMana(priv.owner:getMana() + mana_cost) -- restore mana
        private.event_actions[EVENT.AlreadyCasting]:run(EVENT.AlreadyCasting, self)
        return
    end

    -- Check charges.
    local charges = priv.abil_charges:getChargesLeft()
    local need_charges = priv.abil_type:getChargesForUse()
    if charges < need_charges then
        priv.owner:setMana(priv.owner:getMana() + mana_cost) -- restore mana
        private.event_actions[EVENT.NoCharges]:run(EVENT.NoCharges, self)
        return
    end

    -- Check range.
    local range = target:getDistance(priv.owner)
    local max_range = priv.abil_info:get(INFO_NAME.Range)
    if range > max_range then
        priv.owner:setMana(priv.owner:getMana() + mana_cost) -- restore mana
        private.event_actions[EVENT.OutOfRange]:run(EVENT.OutOfRange, self)
        return
    end

    -- Check allowed target.
    if Class.type(target, AbilityTargetUnit) then
        local target_unit = target:getUnit()
        local allowed = priv.abil_info:get(INFO_NAME.TargetsAllowed)
        --print(allowed)
        if allowed == 'friend' and priv.owner:isEnemy(target_unit) then
            priv.owner:setMana(priv.owner:getMana() + mana_cost) -- restore mana
            private.event_actions[EVENT.NeedsAllyTarget]:run(EVENT.NeedsAllyTarget, self)
            return
        elseif allowed == 'enemy' and priv.owner:isAlly(target_unit) then
            priv.owner:setMana(priv.owner:getMana() + mana_cost) -- restore mana
            private.event_actions[EVENT.NeedsEnemyTarget]:run(EVENT.NeedsEnemyTarget, self)
            return
        end
    end

    -- Consume
    priv.abil_charges:setChargesLeft(charges - need_charges)

    self:start(target)
end

--- Start casting ignoring conditions.
---@param target AbilityTarget
function public:start(target)
    local priv = private.data[self]

    priv.abil_casting:start(target)
    priv.target = target
    private.event_actions[static.EVENT.CastingStart]:run(static.EVENT.CastingStart, self)
end

function public:cancel()
    local priv = private.data[self]

    if priv.target ~= nil then
        priv.abil_casting:cancel()
        private.event_actions[static.EVENT.CastingCancel]:run(static.EVENT.CastingCancel, self)
        priv.target = nil
    end
end

function public:interrupt()
    local priv = private.data[self]

    if priv.target ~= nil then
        priv.abil_casting:interrupt()
        private.event_actions[static.EVENT.CastingInterrupt]:run(static.EVENT.CastingInterrupt, self)
        priv.target = nil
    end
end

function public:finish()
    local priv = private.data[self]

    if priv.target ~= nil then
        priv.abil_casting:finish()
        private.event_actions[static.EVENT.CastingFinish]:run(static.EVENT.CastingFinish, self)
        priv.target = nil
    end
end

function public:destroy()
    local priv = private.data[self]
    priv.abil_dummy:destroy()
end

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
        target = nil,
        owner = owner,
        abil_type = abil_type,
        hotkey = hotkey,

        abil_dummy = AbilityDummy.new(owner, hotkey),
        abil_charges = AbilityCooldownCharges.new(owner, abil_type),
        abil_casting = AbilityCastingController.new(owner, abil_type),
        abil_info = AbilityInfo.new(owner, abil_type),
    }
    private.data[self] = priv

    -- Init dummy
    priv.abil_dummy:setEffectAction(private.used_dummy_action)
    private.dummy2instance[priv.abil_dummy] = self
    -- Init charges
    priv.abil_charges:setChargesChangedAction(private.charges_changed_action)
    private.charges2instance[priv.abil_charges] = self
    -- Init casting
    priv.abil_casting:setCastingAction(private.casting_action)
    priv.abil_casting:setFinishAction(private.casting_finish_action)
    private.casting2instance[priv.abil_casting] = self
    -- Init info
    priv.abil_info:setInfoChangedAction(private.info_changed_action)
    priv.abil_info:autoUpdate(true)
    private.info2instance[priv.abil_info] = self
    priv.abil_info:update()

end

------------
-- Events --
------------

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

    local target
    local target_unit = Unit.getLinked(GetSpellTargetUnit())
    if target_unit then
        target = AbilityTargetUnit.new(target_unit)
    else
        target = AbilityTargetPoint(GetSpellTargetX(), GetSpellTargetY())
    end
    self:use(target)
end
private.used_dummy_action = Action.new(private.used_dummy_callback, AbilityData)

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
---@type AbilityCastingCallback
private.casting_callback = function(abil_casting)
    ---@type AbilityData
    local self = private.casting2instance[abil_casting]
    private.event_actions[static.EVENT.CastingLoop]:run(static.EVENT.CastingLoop, self)
end
private.casting_action = Action.new(private.casting_callback, AbilityData)

private.casting_finish_callback = function(abil_casting)
    ---@type AbilityData
    local self = private.casting2instance[abil_casting]
    private.event_actions[static.EVENT.CastingFinish]:run(static.EVENT.CastingFinish, self)
    private.data[self].target = nil
end
private.casting_finish_action = Action.new(private.casting_finish_callback, AbilityData)

----------
-- Info --
----------

private.info2instance = setmetatable({}, {__mode = 'kv'})

-- INFO_NAME -> dummy func name
private.info_update = {
    [INFO_NAME.Name] = 'setName',
    [INFO_NAME.Range] = 'setRange',
    [INFO_NAME.Area] = 'setArea',
    [INFO_NAME.TargetingType] = 'setTargetingType',
    [INFO_NAME.TargetsAllowed] = nil,
    [INFO_NAME.ManaCost] = 'setManaCost',
    [INFO_NAME.HealthCost] = nil, -- TODO
    [INFO_NAME.Icon] = 'setIcon',
    [INFO_NAME.Tooltip] = 'setTooltip',
}
---@type AbilityInfoCallback
private.info_changed_callback = function(abil_info, info_name)
    ---@type AbilityData
    local self = private.info2instance[abil_info]
    ---@type AbilityDummy
    local abil_dummy = private.data[self].abil_dummy
    local value = abil_info:get(info_name)

    local func_name = private.info_update[info_name]
    if func_name then abil_dummy[func_name](abil_dummy, value) end
end
private.info_changed_action = Action.new(private.info_changed_callback, AbilityData)


return static