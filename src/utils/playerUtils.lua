---@type DataBase
local DataBase = require('utils.DataBase')

---@class PlayerUtils
local PlayerUtils = {}

local local_player = nil
if not is_compiletime then
    local_player = GetLocalPlayer()
end

---Function forces player press button.
---@param key string
---@return nil
function PlayerUtils.forceUIKey(player, key)
    if player == local_player then
        key = string.upper(key)
        ForceUIKey(key)
    end
end

---@type UnitEvent
local UnitEvent = require('trigger.events.unitEvent')

local SelectedUnits = {}

local function unitSelected()
    local unit = GetTriggerUnit()
    local player = GetTriggerPlayer()

    local list = SelectedUnits[player]
    local already_selected = false
    for i = 1, #list do
        if unit == list[i] then
            already_selected = true
            break
        end
    end

    if not already_selected then
        table.insert(list, unit)
    end
end

local function unitDeselected()
    local unit = GetTriggerUnit()
    local player = GetTriggerPlayer()

    local list = SelectedUnits[player]
    local pos = -1
    for i = 1, #list do
        if unit == list[i] then
            pos = i
            break
        end
    end

    if pos > 0 then
        table.remove(list, pos)
    end
end

function SelectedUnits.init()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        SelectedUnits[Player(i)] = {}
    end
    ---@type Trigger
    local selection_trigger = UnitEvent.getTrigger("AnyUnitSelected")
    selection_trigger:addAction(unitSelected, nil)

    ---@type Trigger
    local deselection_trigger = UnitEvent.getTrigger("AnyUnitDeselected")
    deselection_trigger:addAction(unitDeselected, nil)
end

---@param player wc3_Player
---@return wc3_Unit[]
function SelectedUnits.get(player)
    local copy = {}
    for i = 1, #SelectedUnits[player] do
        table.insert(copy, SelectedUnits[i])
    end
    return copy
end

---@param player wc3_Player
---@return integer
function SelectedUnits.count(player)
    return #SelectedUnits[player]
end

return PlayerUtils