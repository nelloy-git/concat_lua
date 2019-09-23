local Interface = {}

local game_ui
local world
local menu
local allies
local log
local quests
local cmd_buttons = {}

function Interface.init()
    game_ui = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    world = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    menu = BlzGetOriginFrame(ORIGIN_FRAME_SYSTEM_BUTTON, 0)
    log = BlzGetOriginFrame(ORIGIN_FRAME_SYSTEM_BUTTON, 2)
    quests = BlzGetOriginFrame(ORIGIN_FRAME_SYSTEM_BUTTON, 3)
    ui_parent = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, 0))


    BlzHideOriginFrames(true)

    -- World
    BlzFrameSetAllPoints(world, game_ui)
    -- Command buttons
    --local toc_file = "war3mapImported\\frameFiles\\CommandPanel\\CommandPanel.toc"
    --if not BlzLoadTOCFile(toc_file) then
    --    error('Error while loading '..toc_file)
    --    return nil
    --end

    require('baseClasses.Interface.CommandPanel')

    -- Menu
    BlzFrameSetParent(menu, ui_parent)
    BlzFrameClearAllPoints(menu)
    BlzFrameSetAbsPoint(menu, FRAMEPOINT_BOTTOMLEFT, 0.460, 0)
    BlzFrameSetVisible(menu, true)
    -- Quest
    BlzFrameSetParent(quests, menu)
    BlzFrameClearAllPoints(quests)
    BlzFrameSetPoint(quests, FRAMEPOINT_BOTTOMLEFT, menu, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
    BlzFrameSetVisible(quests, true)
    -- Log
    BlzFrameSetParent(log, quests)
    BlzFrameClearAllPoints(log)
    BlzFrameSetPoint(log, FRAMEPOINT_BOTTOMLEFT, quests, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
    BlzFrameSetVisible(log, true)

end

return Interface 