---@type Unit
local Unit = require('baseClasses.Unit')
---@type AbilityEvent
local AbilityEvent = require('baseClasses.Ability.AbilityCastingEvents')

local AbilityCastingBar = {}

local progress_timer
local cast_progress_bar
local cast_progress_bar_text

local function updateProgress()
    local selected_units = Unit.getSelectedByPlayer(GetLocalPlayer())
    if #selected_units ~= 1 then
        BlzFrameSetVisible(cast_progress_bar, false)
        progress_timer:addAction(0, runFuncInDebug, updateProgress)
        return nil
    end

    local unit = selected_units[1]
    local casting_data = AbilityEvent.__casters_db:get(unit)
    if not casting_data then
        BlzFrameSetVisible(cast_progress_bar, false)
        progress_timer:addAction(0, runFuncInDebug, updateProgress)
        return nil
    end

    BlzFrameSetValue(cast_progress_bar, 100 * casting_data.elapsed_time / casting_data.timeout)
    BlzFrameSetText(cast_progress_bar_text, casting_data.ability:getName())
    BlzFrameSetVisible(cast_progress_bar, true)
    progress_timer:addAction(0, runFuncInDebug, updateProgress)
end

function AbilityCastingBar.init()
    local toc_file = "war3mapImported\\frameFiles\\CastingBar\\CastingBar.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error in '..toc_file)
    end

    cast_progress_bar = BlzCreateSimpleFrame("MyBarEx", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 1)
    cast_progress_bar_text = BlzGetFrameByName("MyBarExText", 1)
    BlzFrameSetAbsPoint(cast_progress_bar, FRAMEPOINT_CENTER, 0.3, 0.15)
    BlzFrameSetSize(cast_progress_bar, 0.17, 0.02)
    BlzFrameSetValue(cast_progress_bar, 50)
    BlzFrameSetTexture(cast_progress_bar, "Replaceabletextures\\Teamcolor\\Teamcolor01.blp", 0, true)
    BlzFrameSetText(cast_progress_bar_text, "Cast")
    BlzFrameSetVisible(cast_progress_bar, false)

    progress_timer = glTimer
    progress_timer:addAction(0, runFuncInDebug, updateProgress)
end

return AbilityCastingBar