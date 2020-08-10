local Interface = {}

---@type FrameLib
local FrameLib = require(LibList.FrameLib)
--local SBtn = FrameLib.SimpleButton
---@type InterfaceSkillsBarClass
--local SkillsBar = require('Interface.SkillsBar.SkillsBar')
---@type InterfaceSkillTooltipClass
--local SkillTooltip = require('Interface.SkillsBar.SkillTooltip')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local Timer = UtilsLib.Handle.Timer
local Trigger = UtilsLib.Handle.Trigger

if IsCompiletime() then
    return
end

--===================
-- Capture origin UI
--===================

local console_ui_backdrop = BlzGetFrameByName("ConsoleUIBackdrop", 0)
local function freeFrame(handle)
    BlzFrameSetParent(handle, console_ui_backdrop)
    BlzFrameClearAllPoints(handle)
end

------------------
-- Free minimap --
------------------
local map_handle = BlzGetFrameByName("MiniMapFrame", 0)
freeFrame(map_handle)
Interface.Minimap = FrameLib.Frame.Normal.Image.new(map_handle)
---------------
-- Free chat --
---------------
local chat_handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 7)
BlzFrameSetParent(chat_handle, console_ui_backdrop)

--freeFrame(chat_handle)
--Interface.Chat = FrameLib.Frame.Normal.Image.new(chat_handle)
--Interface.Chat:setParent(Interface.ChatEdit)
--Interface.Chat:setPos(0, Interface.ChatEdit:getHeight())

--------------------
-- Free chat edit --
--------------------
local chat_edit_handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 11)
--BlzFrameClearAllPoints(chat_edit_handle)
BlzFrameSetParent(chat_edit_handle, console_ui_backdrop)
BlzFrameClearAllPoints(chat_edit_handle)
BlzFrameSetPoint(chat_edit_handle, FRAMEPOINT_TOPLEFT, console_ui_backdrop, FRAMEPOINT_TOPLEFT, 0, 0.05)
BlzFrameSetPoint(chat_edit_handle, FRAMEPOINT_BOTTOMLEFT, console_ui_backdrop, FRAMEPOINT_BOTTOMLEFT, 0, 0)
--freeFrame(chat_edit_handle)
--Interface.ChatEditBox = FrameLib.Frame.Normal.Image.new(chat_edit_handle)
--local child1 = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 9)
--BlzFrameSetParent(child1, console_ui_backdrop)
--BlzFrameClearAllPoints(child1)
--BlzFrameSetVisible(child1, false)
--Interface.ChatEditBoxChild1 = FrameLib.Frame.Normal.Image.new(child1)

--local child2 = BlzFrameGetChild(chat_edit_handle, 1)
--BlzFrameSetParent(child2, console_ui_backdrop)
--BlzFrameClearAllPoints(child2)
--Interface.ChatEditBoxChild2 = FrameLib.Frame.Normal.Image.new(child2)
--Interface.ChatEditBoxChild2:setPos(0, 0.3)


--------------------------
-- Free command buttons --
--------------------------
Interface.SkillsButtons = {}

for i = 5, 11 do
    local btn_handle = BlzGetFrameByName("CommandButton_"..tonumber(i), 0)
    freeFrame(btn_handle)
    -- TODO change to BUTTON
    local btn = FrameLib.Frame.Normal.Image.new(btn_handle)
    btn:setParent(Interface.Minimap)
    btn:setPos(-(i - 4) * btn:getWidth(), 0)
    
    Interface.SkillsButtons[i - 4] = btn
end

--------------
-- Free Log --
--------------

--local log_handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 7)
--
--freeFrame(log_handle)
--Interface.Log = FrameLib.Frame.Normal.Image.new(log_handle)
--Interface.Log:setPos(0, 0)
-- ORIGIN_FRAME_WORLD_FRAME

-- Hide portrait
BlzFrameSetVisible(BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, 0))
-- Hide inventory
BlzFrameSetVisible(BlzFrameGetParent(BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_ITEM_BUTTON, 0))), false)


FrameLib.Screen.addResolutionChangedAction(
    function(prev_x0, prev_width, prev_height, new_x0, new_width, new_height)
        Interface.Minimap:setPos(new_x0 + new_width - Interface.Minimap:getWidth(), 0)
        --Interface.ChatEditBox:setPos(new_x0, 0)
        BlzFrameSetPoint(chat_edit_handle, FRAMEPOINT_TOPLEFT, console_ui_backdrop, FRAMEPOINT_TOPLEFT, new_x0, 0.025)
        BlzFrameSetPoint(chat_edit_handle, FRAMEPOINT_BOTTOMLEFT, console_ui_backdrop, FRAMEPOINT_BOTTOMLEFT, new_x0, 0)
    end)

return Interface