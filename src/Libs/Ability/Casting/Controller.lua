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

---@type AbilityCastingClass
local AbilityCasting = require(lib_path..'Casting.Base') or error('')
---@type AbilityCastingTypeClass
local AbilityCastingType = require(lib_path..'Casting.Type') or error('')

--=======
-- Class
--=======

local AbilityCastingController = Class.new('AbilityCastingController')
---@class AbilityCastingController
local public = AbilityCastingController.public
---@class AbilityCastingControllerClass
local static = AbilityCastingController.static
---@type AbilityCastingControllerClass
local override = AbilityCastingController.override
local private = {}

--========
-- Static
--========

---@alias AbilityCastingControllerCallback fun(charges:AbilityCastingController)

---@param owner Unit
---@param abil_casting_type AbilityCastingType
---@param child AbilityCastingController | nil
---@return AbilityCastingController
function override.new(owner, abil_casting_type, child)
    isTypeErr(owner, Unit, 'owner')
    isTypeErr(abil_casting_type, AbilityCastingType, 'abil_casting_type')
    if child then isTypeErr(child, AbilityCastingController, 'child') end

    local instance = child or Class.allocate(AbilityCastingController)
    private.newData(instance, abil_casting_type, owner)

    return instance
end

--========
-- Public
--========

function public:getTimeLeft()
    return private.data[self].casting_data:getTimeLeft()
end

---@param target AbilityTarget
function public:start(target)
    local priv = private.data[self]

    private.updateData(self, priv)

    priv.target = target
    priv.casting_data:start(priv.casting_time)
end

function public:cancel()
    local priv = private.data[self]

    priv.abil_casting_type:onCastingCancel(priv.target, priv.owner,
                                           priv.casting_data:getTimeLeft(),
                                           priv.casting_data:getFullTime())
    priv.casting_data:cancel()
end

function public:interrupt()
    local priv = private.data[self]

    priv.abil_casting_type:onCastingInterrupt(priv.target, priv.owner,
                                              priv.casting_data:getTimeLeft(),
                                              priv.casting_data:getFullTime())
    priv.casting_data:cancel()
end

function public:finish()
    local priv = private.data[self]

    priv.abil_casting_type:onCastingFinish(priv.target, priv.owner,
                                           priv.casting_data:getTimeLeft(),
                                           priv.casting_data:getFullTime())
    priv.casting_data:finish()
end

--===========
-- Callbacks
--===========

---@param callback AbilityCastingControllerCallback | Action
function public:setCastingAction(callback)
    if type(callback) == 'function' then
        private.data[self].casting_action = Action.new(callback, self)
    elseif callback == nil or Class.type(callback, Action) then
        local action = callback
        private.data[self].casting_action = action
    else
        Log:err('variable \'callback\' is not of type AbilityCastingControllerCallback | Action', 2)
    end
end

---@param callback AbilityCastingControllerCallback | Action
function public:setFinishAction(callback)
    if type(callback) == 'function' then
        private.data[self].finish_action = Action.new(callback, self)
    elseif callback == nil or Class.type(callback, Action) then
        local action = callback
        private.data[self].finish_action = action
    else
        Log:err('variable \'callback\' is not of type AbilityCastingControllerCallback | Action', 2)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.casting2controller = setmetatable({}, {__mode = 'kv'})

---@param self AbilityCastingController
---@param abil_casting_type AbilityCastingType
---@param owner Unit
function private.newData(self, abil_casting_type, owner)
    local priv = {
        casting_time = abil_casting_type:getCastingTime(owner),

        target = nil,
        owner = owner,
        abil_casting_type = abil_casting_type,
        casting_data = AbilityCasting.new(),

        start_action = nil,
        casting_action = nil,
        cancel_action = nil,
        interrupt_action = nil,
        finish_action = nil
    }
    private.data[self] = priv
    private.casting2controller[priv.casting_data] = self

    priv.casting_data:setCastingAction(private.casting_action)
    priv.casting_data:setFinishAction(private.finish_action)
end

---@param self AbilityCastingController
---@param priv table
function private.updateData(self, priv)
    -- Update full casting time
    priv.casting_time = priv.abil_casting_type:getCastingTime(priv.owner)
end

---@type AbilityCooldownCallback
private.casting_callback = function(casting_data)
    ---@type AbilityCastingController
    local self = private.casting2controller[casting_data]
    local priv = private.data[self]

    priv.abil_casting_type:onCastingLoop(priv.target, priv.owner,
                                         casting_data:getTimeLeft(),
                                         casting_data:getFullTime())
    if priv.casting_action then priv.casting_action:run(self) end
end
private.casting_action = Action.new(private.casting_callback, AbilityCasting)

---@type AbilityCastingCallback
private.finish_callback = function(casting_data)
    ---@type AbilityCastingController
    local self = private.casting2controller[casting_data]
    local priv = private.data[self]

    priv.abil_casting_type:onCastingFinish(priv.target, priv.owner,
                                           casting_data:getTimeLeft(),
                                           casting_data:getFullTime())
    if priv.finish_action then priv.finish_action:run(self) end
end
private.finish_action = Action.new(private.finish_callback, AbilityCasting)

return static