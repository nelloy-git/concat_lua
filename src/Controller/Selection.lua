--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type ActionClass
local Action = require('Utils.Action')

--=======
-- Class
--=======

local SelectionController = Class.new('SelectionController')
---@class SelectionController
local public = SelectionController.public
---@class SelectionControllerClass
local static = SelectionController.static
---@type SelectionControllerClass
local override = SelectionController.override
local private = {}

--=========
-- Static
--=========

---@alias SelectionCallback fun(player:player, select:boolean, unit:unit)

---@param player player
---@param selected boolean
---@param selection_cb SelectionCallback
function static.addAction(player, selected, selection_cb)
    local action = Action.new(selection_cb, SelectionController)
    local list = private.getActionList(player, selected)
    table.insert(list, action)
end

--=========
-- Private
--=========

private.selected_actions = {}
private.deselected_actions = {}

---@param player player
---@param selected boolean
function private.getActionList(player, selected)
    local list
    if selected then
        list = private.selected_actions
    else
        list = private.deselected_actions
    end

    if not list[player] then
        list[player] = {}
        if selected then
            private.selected_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SELECTED, player)
        else
            private.deselected_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_DESELECTED, player)
        end
    end

    return list[player]
end

local savetyRun = savetyRun
function private.selectTriggerFunc()
    local pl = GetTriggerPlayer()

    local list = private.selected_actions[pl]
    if list then
        for i = 1, #list do
            list[i]:run(pl, true, GetTriggerUnit())
        end
    end
end

function private.deselectTriggerFunc()
    local pl = GetTriggerPlayer()

    local list = private.deselected_actions[pl]
    if list then
        for i = 1, #list do
            list[i]:run(pl, true, GetTriggerUnit())
        end
    end
end

if not IsCompiletime() then
    private.selected_trigger = Trigger.new()
    private.selected_trigger:addAction(private.selectTriggerFunc)

    private.deselected_trigger = Trigger.new()
    private.deselected_trigger:addAction(private.deselectTriggerFunc)
end

return static