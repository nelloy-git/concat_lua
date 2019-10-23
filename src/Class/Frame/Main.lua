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

local game_ui_obj
local command_panel_obj
local hero_panel_obj


local initialized = false
function Frame.init()
    if initialized then return nil end

    game_ui_obj = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    command_panel_obj = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, 0))
    hero_panel_obj = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BAR, 0))

    Frame.GAME_UI = Frame.get(game_ui_obj)
    Frame.GAME_UI:setWidth(1)
    Frame.GAME_UI:setHeight(1)

    Frame.WORLD = Frame.getOrigin(ORIGIN_FRAME_WORLD_FRAME, 0)
    Frame.WORLD:setParent(Frame.GAME_UI)
    Frame.WORLD:setWidth(1)
    Frame.WORLD:setHeight(1)

    initialized = true
end

---@param obj framehandle
---@param parent Frame
local function newFrame(obj, parent)
    frame = {
        __x = 0,
        __y = 0,
        __width = 0,
        __height = 0,
        __frame_obj = obj,
        __parent = parent,
    }
    setmetatable(frame, Frame_meta)
    Frame.__db:add(frame.__frame_obj, frame)

    BlzFrameClearAllPoints(frame.__frame_obj)

    if parent ~= nil then
        BlzFrameSetParent(frame.__frame_obj, parent:getObj())
    end
end

---@param frame_obj framehandle
---@return Frame
function Frame.get(frame_obj)
    if frame_obj == nil then return nil end
    local frame = Frame.__db:get(frame_obj)
    if frame ~= nil then return frame end

    -- Safety get parent.
    local parent_obj
    if frame_obj == game_ui_obj then
        parent_obj = nil
    elseif frame_obj == command_panel_obj or frame_obj == hero_panel_obj then
        BlzFrameSetParent(frame_obj, game_ui_obj)
        parent_obj = game_ui_obj
    else
        parent_obj = BlzFrameGetParent(frame_obj)
        if parent_obj == frame_obj then parent_obj = nil end
    end

    return newFrame(frame_obj, Frame.get(parent_obj))
end

---@param frame_type string
---@return Frame
function Frame.newDefault(frame_type, parent)
    local parent_obj
    if not parent then
        parent_obj = game_ui_obj
    else
        parent_obj = parent:getObj()
    end
    local obj
    obj = BlzCreateFrameByType(frame_type, frame_type, parent_obj, "", 0)
    if not obj then return nil end
    return Frame.get(obj)
 end

---@param frame_type string
---@return Frame
 function Frame.newCustom(frame_type, parent)
    local parent_obj
    if not parent then
        parent_obj = game_ui_obj
    else
        parent_obj = parent:getObj()
    end
    local obj = BlzCreateFrame(frame_type, parent_obj, 0, 0)
    if not obj then return nil end
    return Frame.get(obj)
 end

---@param frame_type originframetype
---@param index number
---@return Frame
function Frame.getOrigin(frame_type, index)
    local obj = BlzGetOriginFrame(frame_type, index)
    if not obj then return nil end
    return Frame.get(obj)
end

---@param frame_name string
---@param context number
function Frame.getByName(frame_name, context)
    local obj = BlzGetFrameByName(frame_name, context)
    if not obj then return nil end
    return Frame.get(obj)
end

---@return framehandle
function Frame:getObj()
    return self.__frame_obj or game_ui_obj
end

return Frame