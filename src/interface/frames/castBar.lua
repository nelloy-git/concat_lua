local SelectedUnits = require('player.unitsSelected')
---@type AbilityEvent
local AbilityEvent = require('ability.abilityEvent')

local castBar = {}

function castBar.init()
    TriggerSleepAction(0)

    local toc_file = "war3mapImported\\frame_files\\MyBar.toc"
    if not BlzLoadTOCFile(toc_file) then
        print('Error in '..toc_file)
        print(getErrorPos())
    end

    local castProgressBar = BlzCreateSimpleFrame("MyBarEx", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 1)
    local castProgressBarText = BlzGetFrameByName("MyBarExText", 1)
    BlzFrameSetAbsPoint(castProgressBar, FRAMEPOINT_CENTER, 0.3, 0.15)
    BlzFrameSetSize(castProgressBar, 0.17, 0.02)
    BlzFrameSetValue(castProgressBar, 50)
    BlzFrameSetTexture(castProgressBar, "Replaceabletextures\\Teamcolor\\Teamcolor01.blp", 0, true)
    BlzFrameSetText(castProgressBarText, "Cast")
    BlzFrameSetVisible(castProgressBar, false)
    print('Cast bar init done')

    local function update()
        local player_index = player2index(GetLocalPlayer())
        local selected_units = SelectedUnits.get(player_index)

        if #selected_units ~= 1 then
            BlzFrameSetVisible(castProgressBar, false)
            return nil
        end

        local unit = selected_units[1]
        local ability, time, full_time = AbilityEvent.getUnitCastingData(unit)

        if time >= 0 then
            BlzFrameSetValue(castProgressBar, 100 * time / full_time)
            BlzFrameSetText(castProgressBarText, ability:getName())
            BlzFrameSetVisible(castProgressBar, true)
        else
            BlzFrameSetVisible(castProgressBar, false)
        end
    end

    local trigger2 = CreateTrigger()
    TriggerRegisterTimerEvent(trigger2, 0.05, true)
    TriggerAddAction(trigger2, update)
end

return castBar