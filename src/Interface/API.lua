--=========
-- Include
--=========

---@type InterfaceItemBagClass
local InterfaceItemBag = require('Interface.Item.Bag')
---@type ScreenUpdater
local Screen = require('Frame.Screen')
---@type Timer
local Timer = require('Timer.Timer')

--=============
--     API
--=============

---@class InterfaceAPI
local InterfaceAPI = {}

---@type Unit
InterfaceAPI.target = nil

local function timerLoop()
    local zeroX = Screen.getRealZeroX()
    local realWidth = Screen.getRealWidth()

    InterfaceAPI.BagUI:setX(zeroX + realWidth - InterfaceAPI.BagUI:getWidth())
    InterfaceAPI.BagUI:setY(0)
    if InterfaceAPI.target then
        InterfaceAPI.BagUI:loadBag(InterfaceAPI.target.Bag)
    end
end

function InterfaceAPI.init()
    --BlzHideOriginFrames(true)
    local game_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local world_handle = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameClearAllPoints(world_handle)
    BlzFrameSetAllPoints(world_handle, game_handle)
end


return InterfaceAPI