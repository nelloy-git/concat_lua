---@class FrameCommandPanel
local FrameCommandPanel = {
    __type = "FrameCommandPanelClass"
}

local FrameCommandPanel_meta = {
    __type = "FrameCommandPanel",
    __index = FrameCommandPanel
}

local game_ui

local initialized = false
function FrameCommandPanel.init()
    if initialized then return nil end

    game_ui = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    
    local toc_file = "war3mapImported\\frameFiles\\CommandPanel\\CommandPanel.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    --local border_2 = BlzCreateFrame("CommandPanelBackgroundTemplate", game_ui, 0, 0)
    --BlzFrameSetAbsPoint(border_2, FRAMEPOINT_BOTTOMRIGHT, 0.4, 0.04)
    --BlzFrameSetSize(border_2, 0.290, 0.01)
--
    --local border_2 = BlzCreateFrame("CommandPanelBackgroundTemplate", game_ui, 0, 0)
    --BlzFrameSetAbsPoint(border_2, FRAMEPOINT_BOTTOM, 0.4, 0.04)
    --BlzFrameSetSize(border_2, 0.290, 0.01)

    local frame = {
    }
    
    local parent = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, 0))
    BlzFrameSetEnable(parent, false)
    parent = BlzFrameGetParent(parent)
    BlzFrameSetEnable(parent, false)
    for i = 0, 11 do
        local button = BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, i)
        BlzFrameClearAllPoints(button)
        BlzFrameSetLevel(button, 5)
        BlzFrameSetSize(button, 0.030, 0.030)
        if i <= 3 then
            BlzFrameSetAbsPoint(button, FRAMEPOINT_BOTTOM, 0, 5)
        elseif i <=7 then
            BlzFrameSetAbsPoint(button, FRAMEPOINT_BOTTOMRIGHT, 0.3975 - (7 - i) * 0.04, 0.01)

            local border = BlzCreateFrame("CommandPanelBackgroundTemplate", game_ui, 0, 0)
            BlzFrameSetAbsPoint(border, FRAMEPOINT_BOTTOMRIGHT, 0.3975 - (7 - i) * 0.04 - 0.030, 0.008)
            BlzFrameSetSize(border, 0.01, 0.034)
        else
            BlzFrameSetAbsPoint(button, FRAMEPOINT_BOTTOMRIGHT, 0.4025 + (i - 7) * 0.04, 0.005)
        end
    end

    local border_1 = BlzCreateFrame("CommandPanelBackgroundTemplate", game_ui, 0, 0)
    BlzFrameSetSize(border_1, 0.326, 0.01)
    BlzFrameSetAbsPoint(border_1, FRAMEPOINT_BOTTOM, 0.4, 0)

    local border_2 = BlzCreateFrame("CommandPanelBackgroundTemplate", game_ui, 0, 0)
    BlzFrameSetSize(border_2, 0.326, 0.01)
    BlzFrameSetAbsPoint(border_2, FRAMEPOINT_BOTTOM, 0.4, 0.04)

    initialized = true
end

return FrameCommandPanel