local Interface = {}

---@type FrameLib
local FrameLib = require(LibList.FrameLib)
--local SBtn = FrameLib.SimpleButton
---@type InterfaceSkillsBarClass
--local SkillsBar = require('Interface.SkillsBar.SkillsBar')
---@type InterfaceSkillTooltipClass
--local SkillTooltip = require('Interface.SkillsBar.SkillTooltip')

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

-- Free minimap
local map_handle = BlzGetFrameByName("MiniMapFrame", 0)
freeFrame(map_handle)
Interface.Minimap = FrameLib.Frame.Normal.Image.new(map_handle)

-- Free chat edit
local chat_edit_handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 11)
freeFrame(chat_edit_handle)
Interface.ChatEdit = FrameLib.Frame.Normal.Image.new(chat_edit_handle)

-- Free chat
local chat_handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 7)
freeFrame(chat_handle)
Interface.Chat = FrameLib.Frame.Normal.Image.new(chat_handle)
Interface.Chat:setParent(Interface.ChatEdit)
Interface.Chat:setPos(0, Interface.ChatEdit:getHeight())

-- Free command buttons
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

-- Hide portrait
BlzFrameSetVisible(BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, 0))
-- Hide inventory
BlzFrameSetVisible(BlzFrameGetParent(BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_ITEM_BUTTON, 0))), false)


FrameLib.Screen.addResolutionChangedAction(
    function(prev_x0, prev_width, prev_height, new_x0, new_width, new_height)
        Interface.Minimap:setPos(new_x0 + new_width - Interface.Minimap:getWidth(), 0)
        Interface.ChatEdit:setPos(new_x0, 0)
    end)

return Interface