---@type Trigger
local Trigger = require('trigger.trigger')

---@class SelectedUnits
local SelectedUnits = {}


function SelectedUnits.init()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        SelectedUnits[i] = {}
    end
    ---@type Trigger
    local select_trigger = Trigger.new()
    select_trigger:addEvent_AnyUnitSelected()
    select_trigger:addAction(function()
            local unit = GetTriggerUnit()
            local player_index = player2index(GetTriggerPlayer())
            found = false
            for _, cur in pairs(SelectedUnits[player_index]) do
                if unit == cur then found = true break end
            end

            if not found then
                table.insert(SelectedUnits[player_index], 1, unit)
            end
        end)
    
    ---@type Trigger
    local deselect_trigger = Trigger.new()
    deselect_trigger:addEvent_AnyUnitDeselected()
    deselect_trigger:addAction(function()
            local unit = GetTriggerUnit()
            local owner_index = unit:getOwningPlayerIndex()
            local new_list = {}
            for i = 1, #SelectedUnits[owner_index] do
                if not SelectedUnits[owner_index][i] == unit then
                    table.insert(new_list, 1, SelectedUnits[owner_index][i])
                end
            end
            SelectedUnits[owner_index] = new_list
        end)
    print('Unit selection initialized')
end

function SelectedUnits.get(player_index)
    return SelectedUnits[player_index]
end

function SelectedUnits.count(player_index)
    return #SelectedUnits[player_index]
end

return SelectedUnits