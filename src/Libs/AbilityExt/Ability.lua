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

---@type AbilityExtChargesClass
local AbilityExtCharges = require(lib_path..'Charges') or error('')
---@type AbilityExtEventModule
local AbilityExtEventModule = require(lib_path..'Event') or error('')
local Event = AbilityExtEventModule.Enum
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

---@param abil_type AbilityExtType
---@param child AbilityExt | nil
---@return AbilityExt
function override.new(abil_type, child)
    isTypeErr(abil_type, AbilityExtType, 'abil_type')
    if child then isTypeErr(child, AbilityExt, 'child') end

    local instance = child or Class.allocate(AbilityExt)
    private.newData(instance, abil_type)

    return instance
end


--========
-- Public
--========

-------------
-- Targeting
-------------

---@return boolean
function public:targetingStart()
    local priv = private.data[self]
    local atype = priv.abil_type

    if atype:targetingCanStart(self) then
        atype:targetingStart(self)
        return true
    end
    priv.target = nil
    return false
end

function public:targetingEnd()
    private.data[self].abil_type:targetingEnd(self)
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
    if atype:castingCanStart(self) then
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
---@param abil_type AbilityExtType
function private.newData(self, abil_type)
    local priv = {
        target_unit = nil,
        target_x = 0,
        target_y = 0,

        abil_type = abil_type,

        casting = TimedObj.new(),
        charges = AbilityExtCharges.new(),
    }
    private.data[self] = priv
    private.casting2ability[priv.casting] = self
    private.charges2ability[priv.charges] = self

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