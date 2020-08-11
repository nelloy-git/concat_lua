--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local Timer = UtilsLib.Handle.Timer

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_modname..'.Normal.Base')

--========
-- Module
--========

if IsCompiletime() then
    return
end

local console_ui_backdrop = BlzGetFrameByName("ConsoleUIBackdrop", 0)
local function freeFrame(handle)
    BlzFrameSetParent(handle, console_ui_backdrop)
    BlzFrameClearAllPoints(handle)
end

local function freeAll(handle)

    local count = BlzFrameGetChildrenCount(handle)
    for i = 0, count - 1 do
        local child = BlzFrameGetChild(handle, i)
        freeAll(child)
    end
    freeFrame(handle)
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

local function listAllChildrens(handle)
    local list = {}

    local count = BlzFrameGetChildrenCount(handle)
    for i = 0, count - 1 do
        local child = BlzFrameGetChild(handle, i)
        local child_list
        if BlzFrameGetChildrenCount(child) > 0 then
            child_list = listAll(child)
        else
            child_list = {child}
        end

        for j = 1, #child_list do
            table.insert(list, child_list[j])
        end
    end
    table.insert(list, handle)

    return list
end

local background_handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 11)
local list = listAll(background_handle)
freeAll(background_handle)

print(#list) -- 12



--BlzFrameSetParent(background_handle, console_ui_backdrop)
--local ChatEditBox = FrameNormalBase.new(background_handle)
--ChatEditBox:setPos(0, 0)
--ChatEditBox:setSize(0.35, 0.025)

--local ChatEditPrefix = FrameNormalBase.new(prefix_handle)
--ChatEditPrefix:setParent(ChatEditBox)
--ChatEditPrefix:setPos(ChatEditBox:getWidth() / 50, 0)
--ChatEditPrefix:setSize(ChatEditBox:getWidth() / 5, ChatEditBox:getHeight())

--local msg_handle = BlzFrameGetChild(background_handle, 1)
--moveAll(background_handle, FRAMEPOINT_TOPLEFT, console_ui_backdrop, FRAMEPOINT_TOPLEFT, -0.1, 0.325)
--moveAll(background_handle, FRAMEPOINT_BOTTOMRIGHT, console_ui_backdrop, FRAMEPOINT_BOTTOMRIGHT, 0.25, 0.3)

--print(BlzFrameGetChildrenCount(prefix_handle))
--local message_handle = BlzFrameGetChild(background_handle, 1)
--freeFrame(message_handle)
--hideAll(message_handle)
--freeFrame(message_handle)
--local ChatEditMessage = FrameNormalBase.new(message_handle)
--ChatEditMessage:setParent(ChatEditPrefix)
--ChatEditMessage:setPos(ChatEditPrefix:getWidth(), 0)
--ChatEditMessage:setSize(ChatEditBox:getWidth() - ChatEditPrefix:getWidth(), ChatEditBox:getHeight())

return nil --ChatEditBox