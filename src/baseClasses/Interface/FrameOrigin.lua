local Frame = require('baseClasses.Interface.FrameData')

local FrameOrigins = {}

local initialized = false
function FrameOrigins.init()
    if initialized then return nil end

    Frame.GAME_UI = Frame.getOrigin(ORIGIN_FRAME_GAME_UI, 0)
    Frame.COMMAND_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 6),
        [8] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 7),
        [9] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 8),
        [10] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 9),
        [11] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 10),
        [12] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 11),
    }
    Frame.HERO_BAR = Frame.getOrigin(ORIGIN_FRAME_GAME_UI, 0)
    Frame.HERO_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 6),
    }
    Frame.HERO_HP_BAR = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 6),
    }
    Frame.HERO_MANA_BAR = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 6),
    }
    Frame.HERO_HP_BAR = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 6),
    }
    Frame.ITEM_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 5),
    }
    Frame.MINIMAP = Frame.getOrigin(ORIGIN_FRAME_MINIMAP, 0)
    Frame.MINIMAP_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 5),
    }
    Frame.SYSTEM_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_SYSTEM_BUTTON, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_SYSTEM_BUTTON, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_SYSTEM_BUTTON, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_SYSTEM_BUTTON, 3),
    }
    Frame.WORLD_FRAME = Frame.getOrigin(ORIGIN_FRAME_WORLD_FRAME, 0)
    
    --Frame.TOOLTIP
    --Frame.UBERTOOLTIP
    --Frame.CHAT_MSG
    --Frame.UNIT_MSG
    --Frame.TOP_MSG
    --Frame.PORTRAIT

    initialized = true
end

return FrameOrigins