--==========
-- Includes
--==========

---@type DataBase
local DataBase = require('utils.DataBase')

--=======
-- Class
--=======

---@class Frame
local Frame = newClass('Frame')
local Frame_meta = newMeta(Frame)
Frame.__db = DataBase.new("userdata", "Frame")

local initialized = false
function Frame.init()
    if initialized then return nil end

    BlzHideOriginFrames(true)
    game_ui_obj = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    Frame.GAME_UI = Frame.getOrigin(ORIGIN_FRAME_GAME_UI, 0)

    initialized = true
end

local game_ui_obj
---@param obj framehandle
---@return Frame
local function newFrame(obj)
    frame = {
        __frame_obj = obj,
    }
    setmetatable(frame, Frame_meta)
    Frame.__db:add(frame.__frame_obj, frame)

    if obj ~= game_ui_obj then
        BlzFrameClearAllPoints(frame.__frame_obj)
        BlzFrameSetParent(frame.__frame_obj, game_ui_obj)
    end

    if Frame.GAME_UI ~= nil then
        frame:setParent(Frame.GAME_UI)
    end

    return frame
end

---@return framehandle
function Frame:getObj()
    return self.__frame_obj
end

---@param frame_obj framehandle
---@return Frame
function Frame.get(frame_obj)
    if frame_obj == nil then return nil end

    local frame = Frame.__db:get(frame_obj)
    if frame ~= nil then return frame end

    return newFrame(frame_obj)
end

---@param frame_type string
---@return Frame
function Frame.newDefaultType(frame_type)
    local obj = BlzCreateFrameByType(frame_type, frame_type, game_ui_obj, "", 0)
    return Frame.get(obj)
 end

---@param frame_type string
---@return Frame
 function Frame.newCustomType(frame_type)
    local obj = BlzCreateFrame(frame_type, game_ui_obj, 0, 0)
    return Frame.get(obj)
 end

---@param frame_type originframetype
---@param index number
---@return Frame
function Frame.getOrigin(frame_type, index)
    local obj = BlzGetOriginFrame(frame_type, index)
    return Frame.get(obj)
end

---@param frame_name string
---@param context number
function Frame.getByName(frame_name, context)
    local obj = BlzGetFrameByName(frame_name, context)
    return Frame.get(obj)
end

return Frame