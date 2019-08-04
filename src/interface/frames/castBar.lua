local SelectedUnits = require('player.unitsSelected')
local Ability = require('unit.abilities.ability')

local castBar = {}

function castBar.init()
    TriggerSleepAction(1)

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
        local abil, time, cast_time = Ability.getUnitCastingAbility(unit)
        --print(abil, time, cast_time)

        if time >= 0 then
            BlzFrameSetValue(castProgressBar, 100 * time / cast_time)
            BlzFrameSetText(castProgressBarText, abil.getName())
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

--function UpdateBars takes nothing returns nothing
--    local unit u = GetTriggerUnit()
--   call BlzFrameSetValue(BlzGetFrameByName("MyBarEx",1), GetUnitLifePercent(u)) //Load the Frame at ("MyBarEx",1) and set its value to the %HP
--    call BlzFrameSetValue(BlzGetFrameByName("MyBarEx",2), GetUnitManaPercent(u))
--    set u = null
-- endfunction
-- 
-- function MyBarCreate takes nothing returns nothing
--   local framehandle bar = BlzCreateSimpleFrame("MyBarEx", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 1) //Create Bar at createContext 1
--    local framehandle bar2 = BlzCreateSimpleFrame("MyBarEx", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 2) //createContext 2
--   local framehandle bar4 = BlzCreateSimpleFrame("MyBar", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 4) //createContext 4, other names so would not be needed.
--    call BlzFrameSetAbsPoint(bar, FRAMEPOINT_CENTER, 0.5, 0.3) // pos the bar
--    call BlzFrameSetPoint(bar2, FRAMEPOINT_TOP, bar, FRAMEPOINT_BOTTOM, 0.0, 0.0) // pos bar2 below bar
--    call BlzFrameSetPoint(bar4, FRAMEPOINT_BOTTOM, bar, FRAMEPOINT_TOP, 0.0, 0.0) // pos bar4 above bar
--    call BlzFrameSetSize(bar4, 0.04, 0.04) //change the size of bar4
-- 
--    call BlzFrameSetValue(bar4, 35) //Starting value for bar 4.
-- 
--   call BlzFrameSetTexture(bar, "Replaceabletextures\\Teamcolor\\Teamcolor00.blp", 0, true) //change the BarTexture of bar to color red
--    call BlzFrameSetTexture(bar2, "Replaceabletextures\\Teamcolor\\Teamcolor01.blp", 0, true) //color blue for bar2
--    call BlzFrameSetTexture(bar4, "Replaceabletextures\\CommandButtons\\BTNHeroPaladin.blp", 0, true) //bar4 to Paladin-Face
--   call BlzFrameSetTexture(BlzGetFrameByName("MyBarBackground",4), "Replaceabletextures\\CommandButtonsDisabled\\DISBTNHeroPaladin.blp", 0, true) //Change the background to DisabledPaladin-Face. ("MyBarBackground", 4) belongs to Bar4. would Bar4 be a "MyBarEx" one would have to write "MyBarExBackground" cause they are named differently in fdf.
-- 
--    call BlzFrameSetText(BlzGetFrameByName("MyBarExText",1), "Life")
--    call BlzFrameSetText(BlzGetFrameByName("MyBarExText",2), "Mana")
--    call BlzFrameSetText(BlzGetFrameByName("MyBarText",4), I2S(R2I(BlzFrameGetValue(bar4)))+"%")
-- 
--    call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 99999, "Select an unit to update the Bars")
-- endfunction
-- 
-- //===========================================================================
-- function InitTrig_MyBar takes nothing returns nothing
--    local trigger trig = CreateTrigger()
--     set gg_trg_MyBar = CreateTrigger()
--     call TriggerRegisterTimerEventSingle( gg_trg_MyBar, 0.00 )
--     call TriggerAddAction( gg_trg_MyBar, function MyBarCreate )
--    call BlzLoadTOCFile("war3mapimported\\mybar.toc")
--    call TriggerRegisterPlayerSelectionEventBJ(trig, Player(0), true )
--    call TriggerAddAction(trig, function UpdateBars)
-- endfunction