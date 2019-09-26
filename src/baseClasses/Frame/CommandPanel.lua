local Frame = require('baseClasses.Frame.FrameData')
local FrameOrigins = require('baseClasses.Frame.FrameOrigin')

local FrameCommandPanel = {}

local button_size = 0.030

local initialized = false
function FrameCommandPanel.init()
    if initialized then return nil end

    FrameOrigins.init()

    for _, button in pairs(Frame.COMMAND_BUTTON) do
        button:clearAllPoints()
        button:setParent(Frame.GAME_UI)
    end

    -- Hide 1-4 buttons
    for i = 1, 4 do
        local button = Frame.COMMAND_BUTTON[i]
        button:setAbsPoint(FRAMEPOINT_TOPRIGHT, -1, -1)
        button:setSize(0, 0)
        button:hide()
    end

    -- Move 5-12 buttons
    for i = 5, 12 do
        local button = Frame.COMMAND_BUTTON[i]
        local top_left_x = button_size * (i - 9)
        local top_left_y = button_size
        local bottom_right_x = top_left_x + button_size
        local bottom_right_y = top_left_y - button_size
        button:setPoint(FRAMEPOINT_TOPLEFT, Frame.GAME_UI, FRAMEPOINT_BOTTOM, top_left_x, top_left_y)
        button:setPoint(FRAMEPOINT_BOTTOMRIGHT, Frame.GAME_UI, FRAMEPOINT_BOTTOM, bottom_right_x, bottom_right_y)
    end

    Frame.COMMAND_PANEL:setSize(0, 0)
    Frame.COMMAND_PANEL:hide()

    initialized = true
end

return FrameCommandPanel