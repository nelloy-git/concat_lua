--=========
-- Include
--=========

---@type Interface
local Interface = require('Interface.Interface')
---@type InterfaceItemSlotSyncClass
local ItemSlotSync = require('Interface.Item.SlotSync')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleEmpty = FrameAPI.SimpleEmpty

--=============
--     API
--=============


---@class InterfaceAPI
local InterfaceAPI = {}

InterfaceAPI.addItemSlotSyncAction = ItemSlotSync.addSyncAction
InterfaceAPI.removeItemSlotSyncAction = ItemSlotSync.removeSyncAction

InterfaceAPI.setTarget = Interface.setTarget
InterfaceAPI.getTarget = Interface.getTarget

function InterfaceAPI.init()
    Interface.init()

    InterfaceAPI.Inventory = Interface.Inventory
    InterfaceAPI.CastingBar = Interface.CastingBar
    InterfaceAPI.AbilityBar = Interface.AbilityBar

    --BlzHideOriginFrames(true)
    local game_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local world_handle = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameClearAllPoints(world_handle)
    BlzFrameSetAllPoints(world_handle, game_handle)

    for i = 0, 11 do
        local cmd = BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, i)
        BlzFrameClearAllPoints(cmd)
        BlzFrameSetSize(cmd, 0.0001, 0.0001)
        BlzFrameSetAbsPoint(cmd, FRAMEPOINT_BOTTOMLEFT, 0, 0)
        BlzFrameSetAbsPoint(cmd, FRAMEPOINT_TOPRIGHT, 0, 0)
    end

    BlzHideOriginFrames(true)
    BlzFrameSetVisible(BlzGetFrameByName("ConsoleUIBackdrop",0), false)

    --local empty = BlzCreateSimpleFrame(SimpleEmpty:getName(), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0)
    local main_menu = BlzGetFrameByName("UpperButtonBarFrame", 0)
    BlzFrameSetVisible(main_menu, true)
    BlzFrameSetParent(main_menu, nil)

    --local menu_handle = BlzGetFrameByName("UpperButtonBarMenuButton", 0)
    --BlzFrameSetParent(menu_handle, world_handle)
    --BlzFrameSetVisible(menu_handle, true)
    --BlzFrameClearAllPoints(menu_handle)
    --BlzFrameSetAbsPoint(menu_handle, FRAMEPOINT_CENTER, 0.4, 0.3)
end


return InterfaceAPI