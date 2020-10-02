--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local TimedObj = HandleLib.TimedObj or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityExtChargesClass
local AbilityExtCharges = require(lib_path..'Charges') or error('')
---@type AbilityExtEventModule
local AbilityExtEventModule = require(lib_path..'Event') or error('')
local Event = AbilityExtEventModule.Enum or error('')

--=======
-- Class
--=======

local AbilityExtController = Class.new('AbilityExtController')
---@class AbilityExtController
local public = AbilityExtController.public
---@class AbilityExtControllerClass
local static = AbilityExtController.static
---@type AbilityExtControllerClass
local override = AbilityExtController.override
local private = {}

--=========
-- Static
--=========

---@param child AbilityExtController | nil
---@return AbilityExtController
function static.new(child)
    if child then isTypeErr(child, AbilityExtController, 'child') end

    local instance = child or Class.allocate(AbilityExtController)
    private.newData(instance)

    return instance
end

---@return number
function static.getPeriod()
    return TimedObj.getPeriod()
end

--========
-- Public
--========

-- Controls

---@return boolean
function public:use()
    local priv = private.data[self]

    -- Is casting
    if priv.casting:getTimeLeft() > 0 then
        private.runEvent(self, Event.ERROR_ALREADY_CASTING)
        return false
    end

    -- Check charges.
    local left = priv.charges:get()
    local for_use = priv.charges_for_use
    if left < for_use then
        private.runEvent(self, Event.ERROR_NO_CHARGES)
        return false
    end

    priv.casting:start(priv.casting_time)
    priv.charges:set(left - for_use)
    private.runEvent(self, Event.CASTING_START)
    return true
end

function public:cancel()
    local priv = private.data[self]

    if priv.casting:getTimeLeft() > 0 then
        priv.casting:cancel()
        private.runEvent(self, Event.CASTING_CANCEL)
    end
end

function public:interrupt()
    local priv = private.data[self]
    if priv.casting:getTimeLeft() > 0 then
        priv.casting:cancel()
        private.runEvent(self, Event.CASTING_INTERRUPT)
    end
end

function public:finish()
    local priv = private.data[self]
    if priv.casting:getTimeLeft() > 0 then
        priv.casting:finish()
        private.runEvent(self, Event.CASTING_FINISH)
    end
end

-- Casting

--- Set current casting time left.
---@param time number
function public:setCastingLeft(time)
    local priv = private.data[self]
    if priv.casting:getTimeLeft() > 0 then
        priv.casting:setTimeLeft(time)
    end
end

---@return number
function public:getCastingLeft()
    return private.data[self].casting:getTimeLeft()
end

--- Set full casting time.
---@param time number
function public:setCastingTime(time)
    private.data[self].casting_time = time
end

--- Get full casting time.
---@return number
function public:getCastingTime()
    return private.data[self].casting_time
end

-- Charges

---@param for_use number
function public:setChargesForUse(for_use)
    private.data[self].charges_for_use = for_use
end

---@return number
function public:getChargesForUse()
    return private.data[self].charges_for_use
end

---@param charges number
---@param ignore_max boolean
function public:setCharges(charges, ignore_max)
    private.data[self].charges:set(charges, ignore_max)
end

---@return number
function public:getCharges()
    return private.data[self].charges:get()
end

---@param max number
function public:setMaxCharges(max)
    private.data[self].charges:setMax(max)
end

---@return number
function public:getMaxCharges()
    return private.data[self].charges:getMax()
end

---@param time number
function public:setChargeTimeLeft(time)
    private.data[self].charges:setTimeLeft(time)
end

---@return number
function public:getChargeTimeLeft()
    return private.data[self].charges:getTimeLeft()
end

---@param time number
function public:setChargeCooldown(time)
    private.data[self].charges:setCooldown(time)
end

---@return number
function public:getChargeCooldown()
    return private.data[self].charges:getCooldown()
end

-- Actions

---@alias AbilityExtControllerCallback fun(controller:AbilityExtController, event:AbilityExtEvent)

---@param event AbilityExtEvent
---@param callback AbilityExtControllerCallback
---@return Action
function public:addAction(event, callback)
    local priv = private.data[self]
    return priv.actions[event]:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for event, list in pairs(priv.actions) do
        if list:remove(action) then
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.casting2controller = setmetatable({}, {__mode = 'v'})
private.charges2controller = setmetatable({}, {__mode = 'v'})

---@param self AbilityExtController
function private.newData(self)
    local priv = {
        casting_time = 1,
        charges_for_use = 1,

        ---@type TimedObj
        casting = TimedObj.new(),
        ---@type AbilityExtCharges
        charges = AbilityExtCharges.new(),

        ---@type table<AbilityExtEvent, Action | nil>
        actions = {}
    }
    private.data[self] = priv

    priv.casting:addLoopAction(private.castingLoop)
    priv.casting:addFinishAction(private.castingFinish)
    private.casting2controller[priv.casting] = self

    priv.charges:setLoopAction(private.cooldownLoop)
    priv.charges:setChangedAction(private.chargesChanged)
    private.charges2controller[priv.charges] = self

    for _, event in pairs(Event) do
        priv.actions[event] = ActionList.new()
    end
end

---@param timer TimedObj
function private.castingLoop(timer)
    local self = private.casting2controller[timer]
    private.runEvent(self, Event.CASTING_LOOP)
end

---@param timer TimedObj
function private.castingFinish(timer)
    local self = private.casting2controller[timer]
    private.runEvent(self, Event.CASTING_FINISH)
end

---@type AbilityExtCharges
function private.cooldownLoop(charges)
    local self = private.charges2controller[charges]
    private.runEvent(self, Event.COOLDOWN_LOOP)
end

---@type AbilityExtCharges
function private.chargesChanged(charges)
    local self = private.charges2controller[charges]
    private.runEvent(self, Event.CHARGES_CHANGED)
end

---@param self AbilityExtController
---@param event AbilityExtEvent
function private.runEvent(self, event)
    local priv = private.data[self]

    -- Instance actions
    local action = priv.actions[event]
    if action then action:run(self, event) end
end

return static