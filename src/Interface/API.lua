--=========
-- Include
--=========

---@type Interface
local Interface = require('Interface.Interface')
---@type InterfaceItemSlotSyncClass
local ItemSlotSync = require('Interface.Item.SlotSync')

--=============
--     API
--=============


---@class InterfaceAPI
local InterfaceAPI = {}

InterfaceAPI.Inventory = Interface.Inventory

InterfaceAPI.addItemSlotSyncAction = ItemSlotSync.addSyncAction
InterfaceAPI.removeItemSlotSyncAction = ItemSlotSync.removeSyncAction

function InterfaceAPI.init()
    --BlzHideOriginFrames(true)
    local game_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local world_handle = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameClearAllPoints(world_handle)
    BlzFrameSetAllPoints(world_handle, game_handle)

end


return InterfaceAPI