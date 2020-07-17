--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class

---@type ActionClass
local Action = require(lib_modname..'.Action')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkTypeErr = Functions.checkTypeErr
---@type Logger
local Log = require(lib_modname..'.Logger').getDefault()
---@type TriggerClass
local Trigger = require(lib_modname..'.Handle.Trigger')
--endregion

--=======
-- Class
--=======

local DataSync = Class.new('DataSync')
--region Class
---@class DataSync
local public = DataSync.public
---@class DataSyncClass
local static = DataSync.static
---@type DataSyncClass
local override = DataSync.override
local private = {}
--endregion

--=========
-- Static
--=========

---@alias DataSyncCallback fun(source:player, data:string)

local inited = false
function override.Init()
    if inited then return end
    if IsCompiletime() then return end

    private.trigger = Trigger.new()
    private.trigger:addAction(private.runActions)

    inited = true
end

---@param id string
---@param child_instance DataSync | nil
---@return DataSync
function override.new(id, child_instance)
    checkTypeErr(id, 'string', 'id')
    if child_instance then
        checkTypeErr(child_instance, DataSync, 'child_instance')
    end

    if private.ids[id] then
        Log:err('Frame with the same name already exists.', 2)
    end

    local instance = child_instance or Class.allocate(DataSync)
    private.newData(instance, id)

    return instance
end

--========
-- Public
--========

---@param callback DataSyncCallback
---@return Action
function public:addAction(callback)
    local priv = private.data[self]

    local action = Action.new(callback)
    table.insert(priv.actions, action)

    return action
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for i = 1, #priv.actions do
        if priv.actions[i] == action then
            table.remove(priv.actions, i)
            return true
        end
    end

    return false
end

---@param data string
function public:sendData(data)
    BlzSendSyncData(private.data[self].id, data)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.ids = setmetatable({}, {__mode = 'v'})

private.trigger = nil -- override.Init()

---@param self DataSync
function private.newData(self, id)
    local priv = {
        id = id,
        actions = {}
    }
    private.data[self] = priv
    private.ids[id] = self

    -- Adds event to trigger
    for i = 0, bj_MAX_PLAYER_SLOTS do
        private.trigger:addPlayerSyncEvent(Player(i), id, false)
    end
end

function private.runActions()
    local player = GetTriggerPlayer()
    local id = BlzGetTriggerSyncPrefix()
    local data = BlzGetTriggerSyncData()
    local priv = private.data[private.ids[id]]

    for i = 1, #priv.actions do
        priv.actions[i]:run(player, data)
    end
end

return static