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

-----------------
-- ChatEditBox --
-----------------

Interface.ChatEditBox = FrameLib.Origin.ChatEditBox
Interface.ChatEditBox:setPos(0, 0)
Interface.ChatEditBox:setSize(0.3, 0.025)

-------------
-- CharBox --
-------------

Interface.ChatBox = FrameLib.Origin.ChatBox
Interface.ChatBox:setParent(Interface.ChatEditBox)
Interface.ChatBox:setPos(0, Interface.ChatEditBox:getHeight())
Interface.ChatBox:setSize(0.25, 0.25)

-------------
-- Minimap --
-------------

Interface.Minimap = FrameLib.Origin.Minimap
Interface.Minimap:setSize(0.2, 0.2)
Interface.Minimap:setPos(0.8 - Interface.Minimap:getWidth(), 0)
FrameLib.Screen.addResolutionChangedAction(function (_, _, _, new_x0, new_width, _)
    Interface.Minimap:setPos(new_x0 + new_width - Interface.Minimap:getWidth(), 0)
end)

-------------------
-- Skill buttons --
-------------------

Interface.SkillsButtons = {}
for i = 5, 11 do
    local btn = FrameLib.SkillButton[i]
    btn:setParent(Interface.Minimap)
    btn:setPos(-((11 - i) + 4) * btn:getWidth(), 0)

    Interface.SkillsButtons[i - 4] = btn
end

--===================
-- Capture origin UI
--===================

local console_ui_backdrop = BlzGetFrameByName("ConsoleUIBackdrop", 0)
local function freeFrame(handle)
    BlzFrameSetParent(handle, console_ui_backdrop)
    BlzFrameClearAllPoints(handle)
end

local function freeAll(handle)

    local count = BlzFrameGetChildrenCount(handle)
    for i = 0, count - 1 do
        local child = BlzFrameGetChild(handle, i)

        freeFrame(child)
        if BlzFrameGetChildrenCount(child) > 0 then
            freeAll(child)
        end
    end
end

local function moveAll(handle, point, other_handle, other_point, x, y)
    BlzFrameSetPoint(handle, point, other_handle, other_point, x, y)

    local count = BlzFrameGetChildrenCount(handle)
    for i = 0, count - 1 do
        local child = BlzFrameGetChild(handle, i)
        if BlzFrameGetChildrenCount(child) > 0 then
            moveAll(child, point, other_handle, other_point, x, y)
        else
            BlzFrameSetPoint(child, point, other_handle, other_point, x, y)
        end
    end
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
        --Interface.ChatEditBox:setPos(new_x0, 0.3)
        --Interface.ChatEditBox:setPos(new_x0, 0)
        --BlzFrameSetPoint(chat_edit_box_handle, FRAMEPOINT_TOPLEFT, console_ui_backdrop, FRAMEPOINT_TOPLEFT, new_x0, 0.025)
        --BlzFrameSetPoint(chat_edit_box_handle, FRAMEPOINT_BOTTOMLEFT, console_ui_backdrop, FRAMEPOINT_BOTTOMLEFT, new_x0, 0)
        
        --moveAll(child0, FRAMEPOINT_TOPLEFT, chat_edit_box_handle, FRAMEPOINT_TOPLEFT, 0, 0)
        --moveAll(child0, FRAMEPOINT_BOTTOMRIGHT, chat_edit_box_handle, FRAMEPOINT_BOTTOMRIGHT, 0, 0)

        --moveAll(child1, FRAMEPOINT_TOPLEFT, chat_edit_box_handle, FRAMEPOINT_TOPLEFT, 0, 0)
        --moveAll(child1, FRAMEPOINT_BOTTOMRIGHT, chat_edit_box_handle, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
    end)

return Interface