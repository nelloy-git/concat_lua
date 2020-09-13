--=========
-- Include
--=========

---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local ActionList = UtilsLib.ActionList

--========
-- Module
--========

---@alias SelectionCallback fun(group:table<number, unit>)

---@class InterfaceSelection
local Selection = {}

local group = {}
local actions = ActionList.new()
local function onSelection()
    local list = {}
    for i = 1, #group do
        if GetUnitState(group[i], UNIT_STATE_LIFE) > 0.5 then
            table.insert(list, group[i])
        end
    end
    group = list

    local u = GetTriggerUnit()
    local i = 1
    local add = true
    while (add and i <= #group) do
        if group[i] == u then
            add = false
        end
        i = i + 1
    end

    if add then
        table.insert(group, GetTriggerUnit())
    end
    actions:run(group)
end

local function onDeselection()
    local u = GetTriggerUnit()
    local list = {}
    for i = 1, #group do
        if group[i] ~= u then
            table.insert(list, group[i])
        end
    end
    group = list
end

if not IsCompiletime() then
    local trigger_select = UtilsLib.Handle.Trigger.new()
    trigger_select:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SELECTED, GetLocalPlayer())
    trigger_select:addAction(onSelection)

    local trigger_deselect = UtilsLib.Handle.Trigger.new()
    trigger_deselect:addPlayerUnitEvent(EVENT_PLAYER_UNIT_DESELECTED, GetLocalPlayer())
    trigger_deselect:addAction(onDeselection)
end

---@param callback SelectionCallback
---@return Action
function Selection.addAction(callback)
    return actions:add(callback)
end

---@param action Action
---@return boolean
function Selection.removeAction(action)
    return actions:remove(action)
end

return Selection