--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local TimedObj = HandleLib.TimedObj
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')

--=======
-- Class
--=======

local AbilityExtCharges = Class.new('AbilityExtCharges')
---@class AbilityExtCharges
local public = AbilityExtCharges.public
---@class AbilityExtChargesClass
local static = AbilityExtCharges.static
---@type AbilityExtChargesClass
local override = AbilityExtCharges.override
local private = {}

--========
-- Static
--========

---@return AbilityExtCharges
function override.new()
    local instance = Class.allocate(AbilityExtCharges)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Set current charges.
---@param charges number
---@param ignore_max boolean | nil
function public:set(charges, ignore_max)
    local priv = private.data[self]

    print(charges, priv.max_charges)

    local prev_charges = priv.charges

    if charges > priv.max_charges then
        priv.charges = ignore_max and charges or priv.max_charges
    elseif charges <= 0 then
        priv.charges = 0
    else
        priv.charges = charges
    end

    if charges < priv.max_charges then
        if priv.timer:getTimeLeft() <= 0 then
            priv.timer:start(priv.cooldown)
        end
    else
        priv.timer:cancel()
    end

    if priv.charges ~= prev_charges then
        priv.charges_changed_actions:run(self)
    end
end

--- Get current charges
---@return number
function public:get()
    return private.data[self].charges
end

--- Set maximum charges
---@param max number
function public:setMax(max)
    private.data[self].max_charges = max
    self:set(self:get())
end

--- Get maxinun charges
---@return number
function public:getMax()
    return private.data[self].max_charges
end

--- Pause charges cooldown
---@param flag boolean
function public:pause(flag)
    private.data[self].timer:pause(flag)
end

--- Set time left for getting charge.
---@param time number
function public:setTimeLeft(time)
    private.data[self].timer:setTimeLeft(time)
end

--- Get time left for getting charge.
---@return number
function public:getTimeLeft()
    return private.data[self].timer:getTimeLeft()
end

--- Set full time for getting charge.
---@param time number
function public:setCooldown(time)
    local priv = private.data[self]

    if priv.timer:getTimeLeft() > 0 then
        priv.timer:setTimeLeft(priv.timer:getTimeLeft() + time - priv.cooldown)
    end
    priv.cooldown = time
end

--- Get full time for getting charge.
---@return number
function public:getCooldown()
    return private.data[self].cooldown
end

---@alias AbilityExtChargesCallback fun(charges:AbilityExtCharges)

---@param callback AbilityExtChargesCallback
---@return Action
function public:addCooldownAction(callback)
    private.data[self].cooldown_actions:add(callback)
end

---@param callback AbilityExtChargesCallback
---@return Action
function public:addChargesChangedAction(callback)
    return private.data[self].charges_changed_actions:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    if private.data[self].cooldown_actions:remove(action) then
        return true
    end
    return private.data[self].charges_changed_actions:remove(action)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.timer2charges = setmetatable({}, {__mode = 'kv'})

---@param self AbilityExtCharges
function private.newData(self)
    local priv = {
        charges = 1,
        max_charges = 1,
        cooldown = 0,

        cooldown_actions = ActionList.new(),
        charges_changed_actions = ActionList.new(),

        timer = TimedObj.new(),
    }
    private.data[self] = priv
    private.timer2charges[priv.timer] = self

    priv.timer:addLoopAction(private.timerLoopCallback)
    priv.timer:addFinishAction(private.timerFinishCallback)
end

---@param timer TimedObj
function private.timerLoopCallback(timer)
    local self = private.timer2charges[timer]
    private.data[self].cooldown_actions:run(self)
end

---@param timer TimedObj
function private.timerFinishCallback(timer)
    local self = private.timer2charges[timer]
    self:set(self:get() + 1)
end

return static