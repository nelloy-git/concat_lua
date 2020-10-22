--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Handle = HandleLib.Base or error('')
local TimedObj = HandleLib.TimedObj or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isType = UtilsLib.isType or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityExtChargesClass
local AbilityExtCharges = require(lib_path..'Charges') or error('')
---@type AbilityExtEventModule
local AbilityExtEventModule = require(lib_path..'Event') or error('')
local TargetingEvent = AbilityExtEventModule.TargetingEnum
local CastingEvent = AbilityExtEventModule.CastingEnum
---@type AbilityExtSyncTargetClass
local AbilityExtSyncTarget = require(lib_path..'SyncTarget') or error('')
---@type AbilityExtTypeTargetingClass
local AbilityExtTypeTargeting = require(lib_path..'Type.Targeting') or error('')
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

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@return AbilityExtType
function public:getType()
    return private.data[self].abil_type
end

---@return any
function public:getTarget()
    return private.data[self].target
end

---@return TimedObj
function public:getCastingTimer()
    return private.data[self].casting_timer
end

---@return AbilityExtCharges
function public:getCharges()
    return private.data[self].charges
end

-------------
-- Targeting
-------------

function public:targetingStart()
    local priv = private.data[self]
    ---@type AbilityExtType
    local abil_type = priv.abil_type
    local data_type = abil_type:getData()

    if data_type:isAvailable(self) then
        local targ_type = abil_type:getTargeting()
        targ_type.start(self, nil, private.targetingFinishCallback)

        priv.targ_actions[TargetingEvent.START]:run(self, TargetingEvent.START)
    end
end

function public:targetingCancel()
    local priv = private.data[self]
    ---@type AbilityExtType
    local abil_type = priv.abil_type
    abil_type:getTargeting().cancel()

    priv.targ_actions[TargetingEvent.CANCEL]:run(self, TargetingEvent.CANCEL)
end

function public:targetingFinish()
    if not self == AbilityExtTypeTargeting.getCurrent() then
        return
    end

    local priv = private.data[self]
    ---@type AbilityExtType
    local abil_type = priv.abil_type
    abil_type:getTargeting().finish(self)

    priv.targ_actions[TargetingEvent.FINISH]:run(self, TargetingEvent.FINISH)
end

---@return boolean
function public:isTargeting()
    return self == AbilityExtTypeTargeting.getCurrent()
end

-----------
-- Casting
-----------

---@param target any
function public:castingStart(target)
    local priv = private.data[self]
    ---@type AbilityExtType
    local abil_type = priv.abil_type
    local data_type = abil_type:getData()

    if not (data_type:isAvailable(self) and
            data_type:checkTarget(self, target)) then
        return
    end
    -- Update cooldown
    priv.charges:setCooldown(data_type:getCooldown(abil))
    data_type:consume(self)

    priv.target = target
    priv.casting_timer:start(data_type:getCastingTime())
    priv.cast_actions[CastingEvent.START]:run(self, CastingEvent.START)
end

function public:castingCancel()
    local priv = private.data[self]
    ---@type AbilityExtType
    local abil_type = priv.abil_type

    priv.casting_timer:cancel()
    abil_type:getCasting():cancel(self)
    priv.cast_actions[CastingEvent.CANCEL]:run(self, CastingEvent.CANCEL)
    priv.target = nil
end

function public:castingInterrupt()
    local priv = private.data[self]
    ---@type AbilityExtType
    local abil_type = priv.abil_type

    priv.casting_timer:cancel()
    abil_type:getCasting():interrupt(self)
    priv.cast_actions[CastingEvent.INTERRUPT]:run(self, CastingEvent.INTERRUPT)
    priv.target = nil
end

function public:castingFinish()
    local priv = private.data[self]

    -- Call private.castingFinishCallback
    priv.casting_timer:finish()
    priv.target = nil
end

-----------
-- Actions
-----------

---@alias AbilityExtTargetingCallback fun(abil:AbilityExt, event:AbilityExtTargetingEvent)

---@param event AbilityExtTargetingEvent
---@param callback AbilityExtTargetingCallback
---@return Action
function public:addTargetingAction(event, callback)
    return private.data[self].targ_actions[event]:add(callback)
end

---@alias AbilityExtCastingCallback fun(abil:AbilityExt, event:AbilityExtCastingEvent)

---@param event AbilityExtCastingEvent
---@param callback AbilityExtCastingCallback
---@return Action
function public:addCastingCallback(event, callback)
    return private.data[self].cast_actions[event]:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for _, list in pairs(priv.targ_actions) do
        if list:remove(action) then
            return true
        end
    end

    for _, list in pairs(priv.cast_actions) do
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

private.id2abil = {}
private.casting_timer2ability = setmetatable({}, {__mode = 'k'})
private.charges2ability = setmetatable({}, {__mode = 'k'})

---@param self AbilityExt
---@param owner Unit
---@param abil_type AbilityExtType
function private.newData(self, owner, abil_type)
    local priv = {
        id = private.newId(),
        owner = owner,
        abil_type = abil_type,

        target = nil,

        casting_timer = TimedObj.new(),
        charges = AbilityExtCharges.new(),

        targ_actions = {},
        cast_actions = {},
    }
    private.data[self] = priv
    private.id2abil[priv.id] = self
    private.casting_timer2ability[priv.casting_timer] = self
    private.charges2ability[priv.charges] = self

    -- Link casting.
    priv.casting_timer:addLoopAction(private.castingLoopCallback)
    priv.casting_timer:addFinishAction(private.castingFinishCallback)

    for _, event in pairs(TargetingEvent) do
        priv.targ_actions[event] = ActionList.new(self)
    end

    for _, event in pairs(CastingEvent) do
        priv.cast_actions[event] = ActionList.new(self)
    end
end

local cur_new_id = 0
function private.newId()
    cur_new_id =  cur_new_id + 1
    return cur_new_id
end

---@type AbilityExtTypeTargetingFinishCallback
private.targetingFinishCallback = function(self, target)
    local abil_id = private.data[self].id
    if not isType(target, 'table') then
        target = {target}
    end

    private.target_sync:send(abil_id, target)
end

---@type InputDataSyncCallback
private.targetSynced = function(_, abil_id, targets, source)
    local self = private.id2abil[abil_id]

    if #targets <= 1 then targets = targets[1] end
    self:castingStart(targets)
end

---@type TimedObjCallback
private.castingLoopCallback = function(casting_timer)
    ---@type AbilityExt
    local self = private.casting_timer2ability[casting_timer]
    local priv = private.data[self]

    ---@type AbilityExtType
    local abil_type = priv.abil_type
    abil_type:getCasting():loop(self)
    priv.cast_actions[CastingEvent.LOOP]:run(self, CastingEvent.LOOP)
end

---@type TimedObjCallback
private.castingFinishCallback = function(casting_timer)
    ---@type AbilityExt
    local self = private.casting_timer2ability[casting_timer]
    local priv = private.data[self]

    ---@type AbilityExtType
    local abil_type = priv.abil_type
    abil_type:getCasting():finish(self)
    priv.cast_actions[CastingEvent.FINISH]:run(self, CastingEvent.FINISH)
end

if not IsCompiletime() then
    private.target_sync = AbilityExtSyncTarget.new()
    private.target_sync:addAction(private.targetSynced)
end

return static