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
            child_list = listAllChildrens(child)
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

local function getChild(handle, pos)
    return BlzFrameGetChild(handle, pos)
end

local background_handle = BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 11)
local list = listAllChildrens(background_handle)

local background = background_handle
freeFrame(background)
local prefix = getChild(background, 0)
freeFrame(prefix)
local empty = getChild(background, 1)
BlzFrameClearAllPoints(empty)
--freeFrame(empty)
    local child_1_0 = getChild(empty, 0)
    --freeFrame(child_1_0)
        local message = getChild(child_1_0, 0)
        --freeFrame(message)
        local unknown = getChild(child_1_0, 1)
        --freeFrame(unknown)
        local unknown2 = getChild(child_1_0, 2)
        --freeFrame(unknown2)
        local unknown3 = getChild(child_1_0, 3)
        --freeFrame(unknown3)
        local unknown4 = getChild(child_1_0, 4)
        --freeFrame(unknown4)
    local child_1_1 = getChild(empty, 1)
    --freeFrame(child_1_1)
    local child_1_2 = getChild(empty, 2)
    --freeFrame(child_1_2)
    local child_1_3 = getChild(empty, 3)
    --freeFrame(child_1_3)

BlzFrameSetParent(background, console_ui_backdrop)
BlzFrameSetPoint(background, FRAMEPOINT_BOTTOMLEFT, console_ui_backdrop, FRAMEPOINT_BOTTOMLEFT, -0.15 ,  0.3)

BlzFrameSetParent(prefix, background)
BlzFrameSetPoint(prefix, FRAMEPOINT_LEFT, background, FRAMEPOINT_LEFT, 0.01,  0)

BlzFrameSetParent(empty, console_ui_backdrop)
--BlzFrameSetAllPoints(empty, background)
BlzFrameSetPoint(empty, FRAMEPOINT_BOTTOMLEFT, background, FRAMEPOINT_BOTTOMLEFT, 0,  0)
BlzFrameSetPoint(empty, FRAMEPOINT_TOPRIGHT, background, FRAMEPOINT_TOPRIGHT, 0,  0)

--BlzFrameSetPoint(child_1_0, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)
--BlzFrameSetPoint(message, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)
--BlzFrameSetPoint(unknown, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)
--BlzFrameSetPoint(unknown2, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)
--BlzFrameSetPoint(unknown3, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)
--BlzFrameSetPoint(unknown4, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)
--
--BlzFrameSetPoint(child_1_1, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)
--BlzFrameSetPoint(child_1_2, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)
--BlzFrameSetPoint(child_1_3, FRAMEPOINT_LEFT, prefix, FRAMEPOINT_RIGHT, 0.01,  0)


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