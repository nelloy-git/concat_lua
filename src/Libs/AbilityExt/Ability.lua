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

---@type AbilityExtTypeTargetingClass
local AbilityExtTargetingType = require(lib_path..'Type.Targeting') or error('')
---@type AbilityExtTypeCastingClass
local AbilityExtCastingType = require(lib_path..'Type.Casting') or error('')
---@type AbilityExtTypeDataClass
local AbilityExtDataType = require(lib_path..'Type.Data') or error('')

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
---@param targeting_type AbilityExtTypeTargetingClass
---@param casting_type AbilityExtTypeCasting
---@param data_type AbilityExtTypeData
---@param child AbilityExt | nil
---@return AbilityExt
function override.new(owner, targeting_type, casting_type, data_type, child)
    isTypeErr(owner, Unit, 'owner')
    -- TODO isTypeErr(targeting_type, AbilityExtTargetingType, 'targeting_type')
    -- TODO isTypeErr(casting_type, AbilityExtCastingType, 'casting_type')
    -- TODO isTypeErr(data_type, AbilityExtDataType, 'data_type')
    if child then isTypeErr(child, AbilityExt, 'child') end

    local instance = child or Class.allocate(AbilityExt)
    private.newData(instance, owner, targeting_type, casting_type, data_type)

    return instance
end


--========
-- Public
--========

---@return AbilityExtTypeTargetingClass
function public:getTargetingType()
    return private.data[self].targeting_type
end

---@return AbilityExtType
function public:getType()
    return private.data[self].abil_type
end

-------------
-- Targeting
-------------

function public:targetingStart()
    local priv = private.data[self]

    if priv.data_type:checkConditions(self) then
        priv.targeting_type.start(self,
                                  private.targetingCancelCallback,
                                  private.targetingFinishCallback)
    end
end

function public:targetingCancel()
    private.data[self].targeting_type.cancel()
end

function public:targetingFinish()
    private.data[self].targeting_type.finish()
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

    if priv.data_type:checkConditions(self) then
        priv.casting_type:start(self, nil, function() self:castingStart() end)
    end
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
---@param targeting_type AbilityExtTypeTargeting
---@param casting_type AbilityExtTypeCasting
---@param data_type AbilityExtTypeData
function private.newData(self, owner, targeting_type, casting_type, data_type)
    local priv = {
        target_unit = nil,
        target_x = 0,
        target_y = 0,

        owner = owner,
        targeting_type = targeting_type,
        casting_type = casting_type,
        data_type = data_type,

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

---@type AbilityExtTypeTargetingCancelCallback
private.targetingCancelCallback = function(self)
end

---@type AbilityExtTypeTargetingFinishCallback
private.targetingFinishCallback = function(self, target)
    self:castingStart(target)
end

return static