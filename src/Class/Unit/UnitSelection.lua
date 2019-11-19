--=========
-- Include
--=========

---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

---@type UnitSelectionClass
local UnitSelection = newClass('UnitSelection')

---@class UnitSelection
local public = UnitSelection.public
---@class UnitSelectionClass
local static = UnitSelection.static
---@type table
local override = UnitSelection.override
---@type table(UnitSelection, table)
local private = {}

private.selected_lists = {}

if not is_compiletime then
    private.select_trig = Trigger.new()
    private.deselect_trig = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local pl = Player(i)
        private.selected_lists[pl] = {}
        private.select_trig:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SELECTED, pl)
        private.deselect_trig:addPlayerUnitEvent(EVENT_PLAYER_UNIT_DESELECTED, pl)
    end
end

--=========
-- Methods
--=========

---@return Trigger
function static.getSelectingTrigger()
    return private.select_trig
end

---@return Trigger
function static.getDeselectingTrigger()
    return private.deselect_trig
end

---@param player player
---@return unit[]
function static.get(player)
    local copy = {}
    for i = 1, #private.selected_lists[player] do
        table.insert(copy, 1, private.selected_lists[player][i])
    end
    return copy
end

---@param player player
---@return number
function static.count(player)
    return #private.selected_lists[player]
end

---@param unit unit
---@param player player
---@return boolean
function static.isSelectedBy(unit, player)
    local list = private.selected_lists[player]
    for i = 1, #list do
        if unit == list[i] then
            return true
        end
    end
    return false
end

function private.onUnitSelect()
    local u = GetTriggerUnit()
    local pl = GetTriggerPlayer()

    if not static.isSelectedBy(u, pl) then
        table.insert(private.selected_lists[pl], #private.selected_lists[pl] + 1, u)
    end
end

function private.onUnitDeselect()
    local u = GetTriggerUnit()
    local pl = GetTriggerPlayer()

    local pos = -1
    local list = private.selected_lists[pl]
    for i = 1, #list do
        if u == list[i] then
            pos = i
            break
        end
    end

    if pos < 0 then
        Debug(string.format('%s error: trying deselect unselected unit.', getClassName(UnitSelection)))
    else
        table.remove(list, pos)
    end
end

return UnitSelection