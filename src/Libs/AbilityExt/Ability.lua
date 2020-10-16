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


--------------
-- Self data
--------------


------------------------
-- AbilityExtType hooks
------------------------


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

---@type AbilityExtTypeTargetingCancelCallback
private.targetingCancelCallback = function(self)
    print('Targeting cancel')
end

---@type AbilityExtTypeTargetingFinishCallback
private.targetingFinishCallback = function(self, target)
    print('Targeting finish')
    --self:castingStart(target)
end

return static