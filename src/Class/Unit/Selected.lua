---@type Unit
local Unit = require('Class.Unit.Main')
---@type UnitEvent
local UnitEvent = require('Class.Unit.Event')

local SelectedUnits = {}

local initialized = false
function SelectedUnits.init()
    if initialized then return nil end

    UnitEvent.init()

    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        SelectedUnits[Player(i)] = {}
    end

    UnitEvent.UNIT_SELECTED:addAction(unitSelectedFunc)
    UnitEvent.UNIT_DESELECTED:addAction(unitDeselectedFunc)

    initialized = true
end

---@param player player
---@return Unit[]
function Unit.getSelectedByPlayer(player)
    local copy = {}
    for i = 1, #SelectedUnits[player] do
        table.insert(copy, 1, SelectedUnits[player][i])
    end
    return copy
end

---@param player player
---@return number
function Unit.countSelectedByPlayer(player)
    return #SelectedUnits[player]
end

---@param player player
---@return boolean
function Unit:isSelectedByPlayer(player)
    for i = 1, #SelectedUnits[player] do
        if self == SelectedUnits[player][i] then
            return true
        end
    end
    return false
end

unitSelectedFunc = function()
    local unit = Unit.GetTriggerUnit()
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

unitDeselectedFunc = function()
    local unit = Unit.GetTriggerUnit()
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

return SelectedUnits