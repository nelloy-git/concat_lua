--=========
-- Include
--=========

---@type Interface
local Interface = require('Interface.Interface')
---@type InterfaceBagSyncClass
local BagSync = require('Interface.Bag.Sync')

--=============
--     API
--=============


---@class InterfaceAPI
local InterfaceAPI = {}

InterfaceAPI.getTarget = function() end
InterfaceAPI.Bag = Interface.Bag
InterfaceAPI.addBagSlotPressedAction = BagSync.addBagSlotPressedAction
InterfaceAPI.removeBagSlotPressedAction = BagSync.removeBagSlotPressedAction

function InterfaceAPI.init()
    --BlzHideOriginFrames(true)
    local game_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local world_handle = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameClearAllPoints(world_handle)
    BlzFrameSetAllPoints(world_handle, game_handle)

end


return InterfaceAPI