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
---@type InputLib
local InputLib = lib_dep.Input or error('')
local DataSync = InputLib.DataSync or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isType = UtilsLib.isType or error('')
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

    if priv.abil_type:checkConditions(self) then
        priv.abil_type:targetingStart(self,
                                  private.targetingCancelCallback,
                                  private.targetingFinishCallback)
    end
end

function public:targetingCancel()
    private.data[self].abil_type:targetingCancel()
end

function public:targetingFinish()
    private.data[self].abil_type:targetingFinish()
end

-----------
-- Casting
-----------

---@param target any
function public:castingStart(target)
    local priv = private.data[self]

    if not priv.abil_type:checkConditions(self) then
        return
    end

    if not priv.abil_type:checkTarget(self, target) then
        return
    end

    priv.target = target
    priv.abil_type:castingStart(self)
end

function public:castingCancel()
    local priv = private.data[self]

    priv.abil_type:castingCancel(self)
    priv.target = nil
end

function public:castingInterrupt()
    local priv = private.data[self]

    priv.abil_type:castingInterrupt(self)
    priv.target = nil
end

function public:castingFinish()
    local priv = private.data[self]

    priv.abil_type:castingFinish(self)
    priv.target = nil
end

------------------------
-- AbilityExtType hooks
------------------------

---@return number
function public:getId()
    return private.data[self].id
end

function public:getIcon()
    return "ReplaceableTextures\\CommandButtons\\BTNAbsorbMagic.blp"
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.id2abil = {}
private.casting2ability = setmetatable({}, {__mode = 'k'})
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
    }
    private.data[self] = priv
    private.id2abil[priv.id] = self
    private.casting2ability[priv.casting_timer] = self
    private.charges2ability[priv.charges] = self
end

local cur_new_id = 0
function private.newId()
    cur_new_id =  cur_new_id + 1
    return cur_new_id
end

---@type AbilityExtTypeTargetingCancelCallback
private.targetingCancelCallback = function(self)
end

---@type AbilityExtTypeTargetingFinishCallback
private.targetingFinishCallback = function(self, target)
    -- Send data to other players
    local msg = tostring(self:getId())..':'
    if isType(target, Handle) then
        msg = msg..tostring(target:getId())
    elseif type(target) == 'table' and target.x and target.y then
        msg = msg..tostring(target.x)..':'..tostring(target.y)
    end

    private.target_sync:sendData(msg)
end

local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end

    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

---@type InputDataSyncCallback
private.targetingSynced = function(source, msg)
    local args = split(msg, ':')

    local abil = private.id2abil[tonumber(args[1])]
    local target
    if #args == 2 then
        target = Handle.getLinked(tonumber(args[2]))
    elseif #args == 3 then
        target = {x = tonumber(args[2]), y = tonumber(args[3])}
    end

    abil:castingStart(target)
end

if not IsCompiletime() then
    private.target_sync = DataSync.new()
    private.target_sync:addAction(private.targetingSynced)
end

return static