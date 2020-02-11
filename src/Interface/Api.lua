--=========
-- Include
--=========

---@type InterfaceUnitBagClass
local InterfaceUnitBag = require('Interface.UnitBag')
---@type ScreenUpdater
local Screen = require('Frame.Screen')
---@type Timer
local Timer = require('Class.Timer.Timer')

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

    timerLoop()
end

if not IsCompiletime() then
    InterfaceAPI.BagUI = InterfaceUnitBag.new(5, 4)

    local timer = Timer.new()
    timer:start(1, true, timerLoop)
end


return InterfaceAPI