---@type UnitEvent
local UnitEvent = require('utils.trigger.events.UnitEvents')

---@class SelectedUnits
local SelectedUnits = {}

--- Predefined
local unitSelected
local unitDeselected

function SelectedUnits.init()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        SelectedUnits[Player(i)] = {}
    end
    ---@type Trigger
    UnitEvent.getTrigger("AnyUnitSelected"):addAction(unitSelected)
    ---@type Trigger
    UnitEvent.getTrigger("AnyUnitDeselected"):addAction(unitDeselected)
end

unitSelected = function()
    local unit = GetTriggerUnit()
    local player = GetTriggerPlayer()

    local already_selected = false
    for i = 1, #SelectedUnits[player] do
        if unit == SelectedUnits[player][i] then
            already_selected = true
            break
        end
    end

    if not already_selected then
        table.insert(SelectedUnits[player], 1, unit)
    end
end

unitDeselected = function()
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

---@param player player
---@return unit[]
function SelectedUnits.get(player)
    local copy = {}
    for i = 1, #SelectedUnits[player] do
        table.insert(copy, 1, SelectedUnits[player][i])
    end
    return copy
end

return SelectedUnits