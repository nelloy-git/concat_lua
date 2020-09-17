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

---@type AbilityExtTimerClass
local AbilityExtTimer = require(lib_path..'Timer')
---@type AbilityExtTypeClass
local AbilityExtType = require(lib_path..'Type')

--=======
-- Class
--=======

local AbilityCharges = Class.new('AbilityCharges')
---@class AbilityCharges
local public = AbilityCharges.public
---@class AbilityChargesClass
local static = AbilityCharges.static
---@type AbilityChargesClass
local override = AbilityCharges.override
local private = {}

--========
-- Static
--========

---@param loop_cb Callback | nil
---@param changed_cb Callback | nil
---@return AbilityCharges
function override.new(loop_cb, changed_cb)
    if loop_cb then isTypeErr(loop_cb, 'function', 'loop_cb') end
    if changed_cb then isTypeErr(changed_cb, 'function', 'changed_cb') end

    local instance = Class.allocate(AbilityCharges)
    private.newData(instance, loop_cb, changed_cb)

    return instance
end

--========
-- Public
--========

---@param charges number
---@param ignore_max boolean | nil
function public:set(charges, ignore_max)
    local priv = private.data[self]

    local prev_charges = priv.charges

    if charges >= priv.max_charges then
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
        priv.timer:stop()
    end

    if priv.charges ~= prev_charges and priv.changed_action then
        priv.changed_action:run(self)
    end
end

---@return number
function public:get()
    return private.data[self].charges
end

---@param max number
function public:setMax(max)
    private.data[self].max_charges = max
    self:set(self:get())
end

---@return number
function public:getMax()
    return private.data[self].max_charges
end

---@param time number
function public:setTimeLeft(time)
    private.data[self].timer:setTimeLeft(time)
end

---@return number
function public:getTimerLeft()
    return private.data[self].timer:getTimerLeft()
end

---@param time number
function public:setCooldown(time)
    private.data[self].max_charges = time
end

---@return number
function public:getCooldown()
    return private.data[self].cooldown
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityCharges
---@param loop_cb Callback
---@param changed_cb Callback
function private.newData(self, loop_cb, changed_cb)
    local finish_timer_cb = function()
        self:set(self:get() + 1)
    end

    local priv = {
        charges = 1,
        max_charges = 1,
        cooldown = 0,

        timer = AbilityExtTimer.new(loop_cb, finish_timer_cb),
        changed_action = changed_cb and Action.new(changed_cb) or nil
    }

    private.data[self] = priv
end

return static