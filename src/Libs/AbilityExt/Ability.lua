--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local DummyAbility = HandleLib.DummyAbility or error('')
local DummyAbilityPublic = Class.getPublic(DummyAbility)
local TimedObj = HandleLib.TimedObj or error('')
local Timer = HandleLib.Timer or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type AbilityExtChargesClass
local AbilityExtCharges = require(lib_path..'Charges') or error('')
---@type AbilityExtEventModule
local AbilityExtEventModule = require(lib_path..'Event') or error('')
local TargetingEvent = AbilityExtEventModule.TargetingEnum
local CastingEvent = AbilityExtEventModule.CastingEnum
---@type AbilityExtTypeClass
local AbilityExtType = require(lib_path..'Type') or error('')

--=======
-- Class
--=======

local AbilityExt = Class.new('AbilityExt')
---@class AbilityExt
local public = AbilityExt.public
---@class AbilityExtClass
local static = AbilityExt.static
---@type AbilityExtClass
local override = AbilityExt.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param abil_type AbilityExtType
---@param child AbilityExt | nil
---@return AbilityExt
function override.new(owner, abil_type, child)
    isTypeErr(owner, Unit, 'owner')
    isTypeErr(abil_type, AbilityExtType, 'abil_type')
    if child then isTypeErr(child, AbilityExt, 'child') end

    local instance = child or Class.allocate(AbilityExt)
    private.newData(instance, owner, abil_type)

    return instance
end


--========
-- Public
--========

---@alias AbilityExtCallback fun(abil:AbilityExt)

---@return AbilityExtType
function public:getType()
    return private.data[self].abil_type
end

-------------
-- Targeting
-------------

---@param event AbilityExtTargetingEvent
---@param callback AbilityExtCallback
---@return Action
function public:addTargetingAction(event, callback)
    local actions = private.data[self].targeting_actions[event]
    if not actions then
        Log:err('variable \'event\' is not of type AbilityExtTargetingEvent.')
    end
    return actions:add(callback)
end

---@param action Action
---@return boolean
function public:removeTargetingAction(action)
    local priv = private.data[self]
    for _, event in pairs(TargetingEvent) do
        if priv.targeting_actions[event]:remove(action) then
            return true
        end
    end
    return false
end

---@return boolean
function public:targetingStart()
    local priv = private.data[self]

    priv.target = nil
    if priv.abil_type:targetingStart(self) then
        priv.targeting_actions[TargetingEvent.START]:run(self)
    end
end

function public:targetingCancel()
    local priv = private.data[self]

    priv.abil_type:targetingCancel(self)
    private.data[self].targeting_actions[TargetingEvent.CANCEL]:run(self)
end

---@param target any
function public:targetingFinish(target)
    local priv = private.data[self]
    
    private.data[self].targeting_actions[TargetingEvent.CANCEL]:run(self)
end

---@alias AbilityExtTargetingFinishCallback fun(abil:AbilityExt, targ:any)

---@param callback AbilityExtTargetingFinishCallback
---@return Action
function public:addTargetingFinishAction(callback)
    return private.data[self].targeting_finish_actions:add(callback)
end

---@param action Action
---@return boolean
function public:removeTargetingFinishAction(action)
    return private.data[self].targeting_finish_actions:remove(action)
end

-----------
-- Casting
-----------

---@return any
function public:getTarget()
    return private.data[self].target
end

---@param target any
---@return boolean
function public:castingStart(target)
    local priv = private.data[self]
    local atype = priv.abil_type

    priv.target = target
    if atype:isEnabled(self) then
        priv.casting:start(atype:getCastingTime(self))
        return true
    end
    priv.target = nil
    return false
end

function public:castingCancel()
    local priv = private.data[self]

    -- Stop casting timer
    priv.casting:cancel()
    priv.abil_type:castingCancel(self)
    priv.target = nil
end

function public:castingInterrupt()
    local priv = private.data[self]

    -- Stop casting timer
    priv.casting:cancel()
    priv.abil_type:castingInterrupt(self)
    priv.target = nil
end

function public:castingFinish()
    local priv = private.data[self]

    priv.casting:finish()
    priv.target = nil
end

--------------
-- Self data
--------------

function public:updateData()
    local priv = private.data[self]

    priv.charges:setMax(priv.abil_type:getMaxCharges(self))
    priv.charges:setCooldown(priv.abil_type:getCooldown(self))
end

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@return number
function public:getCurrentCastingTimeLeft()
    return private.data[self].casting:getTimeLeft()
end

---@param time number
function public:setCurrentCastingTimerLeft(time)
    private.data[self].casting:setTimeLeft(time)
end

---@return number
function public:getCurrentCastingFullTime()
    return private.data[self].casting:getFullTime()
end

---@return number
function public:getCurrentChargesLeft()
    return private.data[self].charges:get()
end

---@return number
function public:getCurrentChargesMax()
    return private.data[self].charges:getMax()
end

---@return number
function public:getCurrentCooldownLeft()
    return private.data[self].charges:getTimeLeft()
end

---@return number
function public:getCurrentCooldownFull()
    return private.data[self].charges:getCooldown()
end

------------------------
-- AbilityExtType hooks
------------------------

---@return string
function public:getName()
    return private.data[self].abil_type:getName(self)
end

---@return string
function public:getIcon()
    return private.data[self].abil_type:getIcon(self)
end

---@return string
function public:getTooltip()
    return private.data[self].abil_type:getTooltip(self)
end

---@return number
function public:getLifeCost()
    return private.data[self].abil_type:getLifeCost(self)
end

---@return number
function public:getManaCost()
    return private.data[self].abil_type:getManaCost(self)
end

---@return number
function public:getSpecialCost()
    return private.data[self].abil_type:getSpecialCost(self)
end

---@return number
function public:getChargesForUse()
    return private.data[self].abil_type:getChargesForUse(self)
end

---@return number
function public:getMaxCharges()
    local max = private.data[self].abil_type:getMaxCharges(self)
    private.data[self].charges:setMax(max)
    return max
end

---@return number
function public:getCooldown()
    return private.data[self].abil_type:getCooldown(self)
end

---@return number
function public:getCastingTime()
    return private.data[self].abil_type:getCastingTime(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.casting2ability = setmetatable({}, {__mode = 'k'})
private.charges2ability = setmetatable({}, {__mode = 'k'})

---@param self AbilityExt
---@param owner Unit
---@param abil_type AbilityExtType
function private.newData(self, owner, abil_type)
    local priv = {
        target_unit = nil,
        target_x = 0,
        target_y = 0,

        owner = owner,
        abil_type = abil_type,

        casting = TimedObj.new(),
        charges = AbilityExtCharges.new(),

        targeting_actions = {},
        casting_actions = {},

        targeting_finish_actions = ActionList.new(self),
    }
    private.data[self] = priv
    private.casting2ability[priv.casting] = self
    private.charges2ability[priv.charges] = self

    for _, event in pairs(TargetingEvent) do
        priv.targeting_actions[event] = ActionList.new(self)
    end

    for _, event in pairs(CastingEvent) do
        priv.casting_actions[event] = ActionList.new(self)
    end

    priv.casting:addStartAction(private.castingStart)
    priv.casting:addLoopAction(private.castingLoop)
    priv.casting:addFinishAction(private.castingFinish)
end

---@type TimedObjCallback
private.castingStart = function(casting)
    ---@type AbilityExt
    local self = private.casting2ability[casting]
    private.data[self].abil_type:castingStart(self)
end

---@type TimedObjCallback
private.castingLoop = function(casting)
    ---@type AbilityExt
    local self = private.casting2ability[casting]
    private.data[self].abil_type:castingLoop(self)
end

---@type TimedObjCallback
private.castingFinish = function(casting)
    ---@type AbilityExt
    local self = private.casting2ability[casting]
    private.data[self].abil_type:castingFinish(self)
end

---@type AbilityExtChargesCallback
private.cooldownLoop = function(charges)
    ---@type AbilityExt
    local self = private.charges2ability[charges]
    private.data[self].abil_type:cooldownLoop(self)
end

---@type AbilityExtChargesCallback
private.chargesChanged = function(charges)
    ---@type AbilityExt
    local self = private.charges2ability[charges]
    private.data[self].abil_type:chargesChanged(self)
end

return static