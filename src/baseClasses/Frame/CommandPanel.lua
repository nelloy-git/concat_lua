local FrameOrigins = require('baseClasses.Frame.Origin')

local CommandPanelFrame = {}

local button_size = 0.030

local initialized = false
function CommandPanelFrame.init()
    if initialized then return nil end

    FrameOrigins.init()

    for _, button in pairs(FrameOrigins.COMMAND_BUTTON) do
        button:clearAllPoints()
        button:setParent(FrameOrigins.GAME_UI)
    end

    -- Hide 1-4 buttons
    for i = 1, 4 do
        local button = FrameOrigins.COMMAND_BUTTON[i]
        button:setAbsPoint(FRAMEPOINT_TOPRIGHT, -1, -1)
        button:setSize(0, 0)
        button:hide()
    end

    -- Move 5-12 buttons
    for i = 5, 12 do
        local button = FrameOrigins.COMMAND_BUTTON[i]
        local top_left_x = button_size * (i - 9)
        local top_left_y = button_size
        local bottom_right_x = top_left_x + button_size
        local bottom_right_y = top_left_y - button_size
        button:setPoint(FRAMEPOINT_TOPLEFT, FrameOrigins.GAME_UI, FRAMEPOINT_BOTTOM, top_left_x, top_left_y)
        button:setPoint(FRAMEPOINT_BOTTOMRIGHT, FrameOrigins.GAME_UI, FRAMEPOINT_BOTTOM, bottom_right_x, bottom_right_y)
    end

    FrameOrigins.COMMAND_PANEL:setSize(0, 0)
    FrameOrigins.COMMAND_PANEL:hide()

    initialized = true
end


return CommandPanelFrame