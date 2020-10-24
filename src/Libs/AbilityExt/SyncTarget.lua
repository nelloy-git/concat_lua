--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Handle = HandleLib.Base or error('')
local Trigger = HandleLib.Trigger or error('')
---@type InputLib
local InputLib = lib_dep.Input or error('')
local DataSync = InputLib.DataSync or error('')
local DataSyncPublic = Class.getPublic(DataSync) or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isType = UtilsLib.isType or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')
local splitStr = UtilsLib.splitStr or error('')

---@type AbilityExtPointClass
local AbilityExtPoint = require(lib_path..'Point') or error('')

--=======
-- Class
--=======

local AbilityExtSyncTarget = Class.new('AbilityExtSyncTarget', DataSync)
---@class AbilityExtSyncTarget : InputDataSync
local public = AbilityExtSyncTarget.public
---@class AbilityExtSyncTargetClass : InputDataSyncClass
local static = AbilityExtSyncTarget.static
---@type AbilityExtSyncTargetClass
local override = AbilityExtSyncTarget.override
local private = {}

--=========
-- Static
--=========

---@param child AbilityExtSyncTarget | nil
---@return AbilityExtSyncTarget
function override.new(child)
    if child then isTypeErr(child, AbilityExtSyncTarget, 'child') end

    local instance = child or Class.allocate(AbilityExtSyncTarget)
    instance = DataSync.new(instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param abil_id number
---@param targets Handle[] | AbilityExtPoint[]
function public:send(abil_id, targets)
    local sep = private.sep

    local msg = tostring(abil_id)
    if not isType(targets, 'table') then
        Log:err(tostring(AbilityExtSyncTarget)..': \'targets\' must be a list of targets (table).')
    end

    for i = 1, #targets do
        if isType(targets[i], Handle) then
            msg = msg..sep..tostring(targets[i]:getId())
        elseif isType(targets[i], AbilityExtPoint) then
            msg = msg..sep..targets[i]:tostring()
        else
            Log:err(tostring(AbilityExtSyncTarget)..': unavailable type.')
        end
    end

    DataSyncPublic.send(self, msg)
end

---@alias AbilityExtSyncTargetCallback fun(sync:AbilityExtSyncTarget, abil_id:number, targets:table, source:player)

---@param callback AbilityExtSyncTargetCallback
---@return Action
function public:addAction(callback)
    return private.data[self].actions:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    return private.data[self].actions:remove(action)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.sep = ':'

function private.newData(self)
    local priv = {
        actions = ActionList.new()
    }
    private.data[self] = priv

    DataSyncPublic.addAction(self, private.originCallback)
end

---@param msg string
function private.parse(msg)
    local vals = splitStr(msg, private.sep)

    local abil_id = tonumber(vals[1])
    local target = {}
    for i = 2, #vals do
        local cur = AbilityExtPoint.new(vals[i])
        if not cur then
            cur = Handle.getLinked(tonumber(vals[i]))
        end
        table.insert(target, cur)
    end

    return abil_id, target
end

---@param self AbilityExtSyncTarget
---@param msg string
---@param source player
function private.originCallback(self, msg, source)
    local priv = private.data[self]

    local abil_id, targets = private.parse(msg)
    priv.actions:run(self, abil_id, targets, source)
end

return static