---@type InterfaceFrame
local Frame = require('interface.frame')
---@type InterfaceFrameTextButton
local textButton = require('interface.frames.textButton')

---@class Interface
local Interface = {}

local function restoreFrame(name, index)
    local frame = BlzGetFrameByName(name, index)
    BlzFrameClearAllPoints(frame)
    BlzFrameSetVisible(frame, false)
    return frame
end

function Interface.init()
    TriggerSleepAction(0.01)

    Interface.menuBtn = Frame.get(ORIGIN_FRAME_SYSTEM_BUTTON, 0)
    Interface.unitStats = Frame.get('SimpleUnitStatsPanel', 0)

    local tmp = Interface.unitStats:getParent()
    tmp:hide()

    --BlzHideOriginFrames(true)
    BlzEnableUIAutoPosition(false)
    BlzFrameSetAllPoints(BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0))

    Interface.menuBtn:show()
    Interface.menuBtn:clearAllPoints()
    Interface.menuBtn:setAbsPoint(FRAMEPOINT_TOPLEFT, 0.3, 0.3)

    ---@type InterfaceFrame[]
    Interface.button = {}
    for i = 0, 11 do
        local btn = Frame.get(ORIGIN_FRAME_COMMAND_BUTTON, i)
        Interface.button[i + 1] = btn
        local w = btn:width()
        local h = btn:height()
        btn:clearAllPoints()
        btn:setAbsPoint(FRAMEPOINT_TOPLEFT, 0.4 - (3.5 - i) * w, h)
        if i < 5 then
            btn:hide()
        end
    end

    ---@type InterfaceFrame[]
    Interface.heroIndicator = {}
    for i = 0, 6 do
        local indicator = Frame.get(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, i)
        Interface.heroIndicator[i + 1] = indicator
        indicator:setAbsPoint(FRAMEPOINT_TOPLEFT, -1, -1)
        indicator:scale(0.001)
    end

    Interface.gameUI = Frame.get(ORIGIN_FRAME_GAME_UI, 0)
    --local btn = textButton.new('Button1', 0.3, 0.3, Interface.gameUI)
    --btn:setSize(0.12, 0.05)

    --local btn = textButton.new('Button2', 0.3, 0.35, Interface.gameUI)
    --btn:setSize(0.12, 0.05)

    print('Interface initialized')
end

return Interface