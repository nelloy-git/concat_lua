--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type ActionClass
local Action = require('Class.Action')

--=======
-- Class
--=======

local KeyboardController = Class.new('KeyboardController')
---@class KeyboardController
local public = KeyboardController.public
---@class KeyboardControllerClass
local static = KeyboardController.static
---@type KeyboardControllerClass
local override = KeyboardController.override
local private = {}

--=========
-- Static
--=========

---@alias KeyboardCallback fun(pl:player, key:oskeytype, meta:number, is_down:boolean)

---@param player player
---@param key oskeytype
---@param meta number
---@param is_down boolean
---@param keyboard_cb KeyboardCallback
---@return Action
function static.addAction(player, key, meta, is_down, keyboard_cb)
    local action = Action.new(keyboard_cb, KeyboardController)
    local list = private.getActionList(player, key, meta, is_down)
    table.insert(list, action)
    private.list_pointer[action] = list
    return action
end

---@param action Action
---@return boolean
function static.removeAction(action)
    local list = private.list_pointer[action]
    if not list then
        return false
    end

    for i = 1, #list do
        if action == list[i] then
            table.remove(list, i)
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.player = {}

private.list_pointer = {}

---@param player player
---@param key oskeytype
---@param meta number
---@param is_down boolean
---@return Action[]
function private.getActionList(player, key, meta, is_down)
    local player_list = private.player
    if not player_list[player] then
        player_list[player] = {
            key = {}
        }
    end

    local key_list = player_list[player].key
    if not key_list[key] then
        key_list[key] = {
            meta = {}
        }
    end

    local meta_list = key_list[key].meta
    if not meta_list[meta] then
        meta_list[meta] = {
            is_down = {}
        }
    end

    local is_down_list = meta_list[meta].is_down
    if not is_down_list[is_down] then
        is_down_list[is_down] = {}
        private.trigger:addPlayerKeyEvent(player, key, meta, is_down)
    end

    return is_down_list[is_down]
end

---@param player player
---@param key oskeytype
---@param meta number
---@param is_down boolean
---@return Action[]
function private.getExistingActionList(player, key, meta, is_down)
    local player_list = private.player
    if not player_list[player] then return end
    local key_list = private.player[player].key
    if not key_list[key] then return end
    local meta_list = key_list[key].meta
    if not meta_list[meta] then return end
    local is_down_list = meta_list[meta].is_down
    if not is_down_list[is_down] then return end

    return is_down_list[is_down]
end

local savetyRun = savetyRun
function private.triggerFunc()
    local pl = GetTriggerPlayer()
    local key = BlzGetTriggerPlayerKey()
    local meta = BlzGetTriggerPlayerMetaKey()
    local is_down = BlzGetTriggerPlayerIsKeyDown()

    local list = private.getExistingActionList(pl, key, meta, is_down)
    if list then
        for i = 1, #list do
            list[i]:run(pl, key, meta, is_down)
        end
    end
end

if not IsCompiletime() then
    private.trigger = Trigger.new()
    private.action = private.trigger:addAction(private.triggerFunc)
end

return static