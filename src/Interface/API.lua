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
InterfaceAPI.CastingBar = Interface.CastingBar

InterfaceAPI.addItemSlotSyncAction = ItemSlotSync.addSyncAction
InterfaceAPI.removeItemSlotSyncAction = ItemSlotSync.removeSyncAction

InterfaceAPI.getTarget = Interface.getTarget

function InterfaceAPI.init()
    --BlzHideOriginFrames(true)
    local game_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local world_handle = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameClearAllPoints(world_handle)
    BlzFrameSetAllPoints(world_handle, game_handle)

    local menu_handle = BlzGetFrameByName("UpperButtonBarMenuButton", 0)
    BlzFrameClearAllPoints(menu_handle)
    BlzFrameSetParent(menu_handle, world_handle)
    BlzFrameSetAbsPoint(menu_handle, FRAMEPOINT_BOTTOMLEFT, 0, 0)

    BlzHideOriginFrames(true)
end


return InterfaceAPI