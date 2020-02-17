--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ActionClass
local Action = require('Utils.Action')
---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type UnitAPI
local UnitAPI = require('Unit.API')
local Unit = UnitAPI.Unit
---@type ItemAPI
local ItemAPI = require('Item.API')
local Item = ItemAPI.Item
---@type Interface
local Interface

--=======
-- Class
--=======

local InterfaceItemSlotSync = Class.new('InterfaceItemSlotSync')
---@class InterfaceItemSlotSync
local public = InterfaceItemSlotSync.public
---@class InterfaceItemSlotSyncClass
local static = InterfaceItemSlotSync.static
---@type InterfaceItemSlotSyncClass
local override = InterfaceItemSlotSync.override
local private = {}

--=========
-- Static
--=========

---@alias InterfaceItemSlotSyncCallback fun(player:player, unit:Unit, item:Item, mouse_btn:mousebuttontype)

---@param slot_icon SimpleButton
---@param player player
---@param mouse_button mousebuttontype
function static.startSync(slot_icon, player, mouse_button)
    ---@type Interface
    Interface = Interface or require('Interface.Interface')

    local player_id = GetPlayerId(player)
    local mouse_id = private.MouseButton2Id[mouse_button]
    local item_slot = slot_icon:getParent()
    local item_id = item_slot:getItem():getId()
    local unit_id = Interface:getTarget():getId()

    local data = private.serialize(player_id, unit_id, item_id, mouse_id)
    BlzSendSyncData(private.prefix, data)
end

---@param callback InterfaceItemSlotSyncCallback
---@return Action
function static.addSyncAction(callback)
    local action = Action.new(callback, InterfaceItemSlotSync)
    table.insert(private.actions, action)

    return action
end

---@param action Action
---@return boolean
function static.removeSyncAction(action)
    for i = 1, #private.actions do
        if action == private.actions[i] then
            table.remove(private.actions, i)
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.actions = {}
private.prefix = 'SlotPressed'

if not IsCompiletime() then
    private.MouseButton2Id = {
        [MOUSE_BUTTON_TYPE_LEFT] = 1,
        [MOUSE_BUTTON_TYPE_RIGHT] = 2,
        [MOUSE_BUTTON_TYPE_MIDDLE] = 3
    }
    private.Id2MouseButton = {
        [1] = MOUSE_BUTTON_TYPE_LEFT,
        [2] = MOUSE_BUTTON_TYPE_RIGHT,
        [3] = MOUSE_BUTTON_TYPE_MIDDLE
    }
end

function private.finishSync()
    local prefix = BlzGetTriggerSyncPrefix()
    if prefix == private.prefix then
        local data = BlzGetTriggerSyncData()
        local res = private.deserialize(data)

        local player = Player(res.player_id)
        local unit = Unit.getInstance(res.unit_id)
        local item = Item.getInstance(res.item_id)
        local mouse_button = private.Id2MouseButton[res.mouse_button_id]

        for i = 1, #private.actions do
            private.actions[i]:run(player, unit, item, mouse_button)
        end
    end
end

if not IsCompiletime() then
    private.sync_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        private.sync_trigger:addPlayerSyncEvent(Player(i), private.prefix, false)
    end
    private.sync_trigger:addAction(private.finishSync)
end

---@param player_id number
---@param unit_handle number
---@param item_id number
---@param mouse_button_id number
---@return string
function private.serialize(player_id, unit_handle, item_id, mouse_button_id)
    return string.format('%d_%d_%d_%d', player_id, unit_handle, item_id, mouse_button_id)
end

---@param str string
---@return table
function private.deserialize(str)
    local player_start = 1
    local player_end = str:find('_') - 1
    local unit_start = player_end + 2
    local unit_end = str:find('_', unit_start) - 1
    local item_start = unit_end + 2
    local item_end = str:find('_', item_start) - 1
    local mouse_start = item_end + 2
    local mouse_end = str:len()

    local res = {
        player_id = tonumber(str:sub(player_start, player_end)),
        unit_id = tonumber(str:sub(unit_start, unit_end)),
        item_id = tonumber(str:sub(item_start, item_end)),
        mouse_button_id = tonumber(str:sub(mouse_start, mouse_end))
    }
    return res
end

return static