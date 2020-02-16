--=========
-- Include
--=========

---@type Interface
--local Interface = require('Interface.Interface')
---@type FrameAPI
local FrameAPI = require('Frame.API')
---@type TriggerClass
local Trigger = require('Utils.Trigger')

--=============
--     API
--=============

local button_type = FrameAPI.SimpleButtonType.new('TestButton', true)


---@class InterfaceAPI
local InterfaceAPI = {}

--InterfaceAPI.Bag = Interface.Bag

function InterfaceAPI.init()
    --BlzHideOriginFrames(true)
    local game_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local world_handle = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameClearAllPoints(world_handle)
    BlzFrameSetAllPoints(world_handle, game_handle)

    local frame = FrameAPI.SimpleButton.new(button_type)
    frame:setX(0.4)
    frame:setY(0.3)
    frame:addAction(FrameAPI.SimpleButton.ActionType.MousePress, function(button, player, mouse_btn)
        if mouse_btn == MOUSE_BUTTON_TYPE_LEFT then
            print('Left button pressed')
        elseif mouse_btn == MOUSE_BUTTON_TYPE_RIGHT then
            print('Right button pressed')
        elseif mouse_btn == MOUSE_BUTTON_TYPE_MIDDLE then
            print('Wheel button pressed')
        end
    end)

end


return InterfaceAPI