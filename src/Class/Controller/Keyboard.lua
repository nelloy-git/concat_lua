--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type TriggerClass
local Trigger = require('Class.Trigger')
---@type TimerClass
local Timer = require('Class.Timer.Timer')
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

--- Action can not be removed
---@param player player
---@param key oskeytype
---@param meta number
---@param is_down boolean
---@param keyboard_cb KeyboardCallback
function static.addAction(player, key, meta, is_down, keyboard_cb)
    local action = Action.new(keyboard_cb, KeyboardController)
    local list = private.getActionList(player, key, meta, is_down)
    table.insert(list, action)
end

--=========
-- Private
--=========

private.player = {}

---@param player player
---@param key oskeytype
---@param meta number
---@param is_down boolean
function private.getActionList(player, key, meta, is_down)
    local player_list = private.player
    if not player_list[player] then
        player_list[player] = {
            key = {}
        }
    end

    local key_list = private.player[player].key
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
    private.trigger:addAction(private.triggerFunc)
end

return static