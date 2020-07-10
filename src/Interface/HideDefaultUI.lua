local HideDefaultUI = {}

local function hide(handle)
    BlzFrameClearAllPoints(handle)
    BlzFrameSetAbsPoint(handle, FRAMEPOINT_CENTER, 3, 3)
    BlzFrameSetScale(handle, 0.001)
end

local function hideByType(frame_type, index)
    hide(BlzGetOriginFrame(frame_type, index))
end

local function hideByName(name, index)
    local fh = hide(BlzGetFrameByName(name, index))
end

local function free(handle)
    BlzFrameClearAllPoints(handle)
    BlzFrameSetParent(handle, nil)
end

function HideDefaultUI.hide()
    -- Hide origin frames.
    for i=0,11 do
        hideByType(ORIGIN_FRAME_ITEM_BUTTON, i)
        hideByType(ORIGIN_FRAME_COMMAND_BUTTON, i)
        --hideByType(ORIGIN_FRAME_SYSTEM_BUTTON, i)
        hideByType(ORIGIN_FRAME_PORTRAIT, i)
        hideByType(ORIGIN_FRAME_MINIMAP, i)
        hideByType(ORIGIN_FRAME_MINIMAP_BUTTON, i)
        hideByType(ORIGIN_FRAME_TOOLTIP, i)
        hideByType(ORIGIN_FRAME_UBERTOOLTIP, i)
        hideByType(ORIGIN_FRAME_TOP_MSG, i)
        --hideByName("ResourceBarFrame", i)
        --hideByName("ConsoleUI", i)
    end
    BlzFrameSetAllPoints(BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0))
    BlzHideOriginFrames(true)
    BlzFrameSetVisible(BlzGetFrameByName("ConsoleUIBackdrop",0), false)

    for i = 0, 11 do
        free(BlzGetOriginFrame(ORIGIN_FRAME_SYSTEM_BUTTON, i))
    end
end

return HideDefaultUI