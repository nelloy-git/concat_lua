local DataBase = require('utils.DataBase')

---@class Frame
local Frame = {
    __type = "FrameClass",
    __db = DataBase.new("userdata", "Frame")
}
local Frame_meta = {
    __type = "Frame",
    __index = Frame
}

---@alias FrameType string
---| '"BACKDROP"'
---| '"BUTTON"'
---| '"CHATDISPLAY"'
---| '"CHECKBOX"'
---| '"CONTROL"'
---| '"DIALOG"'
---| '"EDITBOX"'
---| '"FRAME"'
---| '"GLUEBUTTON"'
---| '"GLUECHECKBOX"'
---| '"GLUEEDITBOX"'
---| '"GLUEPOPUPMENU"'
---| '"GLUETEXTBUTTON"'
---| '"HIGHLIGHT"'
---| '"LISTBOX"'
---| '"MENU"'
---| '"MODEL"'
---| '"POPUPMENU"'
---| '"SCROLLBAR"'
---| '"SLASHCHATBOX"'
---| '"SLIDER"'
---| '"SPRITE​"'
---| '"TEXT"'
---| '"TEXTAREA"'
---| '"TEXTBUTTON"'
---| '"TIMERTEXT"'

local x_offset

local game_ui_obj
local command_panel_obj
local hero_panel_obj

local initialized = false
function Frame.init()
    if initialized then return nil end

    game_ui_obj = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    command_panel_obj = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, 0))
    hero_panel_obj = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BAR, 0))

    initialized = true
end

---@param frame_type FrameType
---@return Frame
function Frame.new(frame_type, parent)
    local frame = {
        __frame_obj = BlzCreateFrame(frame_type, Frame.GAME_UI, 0, 0),
        __parent_obj = parent or Frame.GAME_UI,
        __childrens = {}
    }
    setmetatable(frame, Frame_meta)
    Frame.__db:add(frame.__frame_obj, frame)

    return frame
 end

---@param frame_obj framehandle
---@return Frame
function Frame.get(frame_obj)
    if frame_obj == nil then return nil end
    local frame = Frame.__db:get(frame_obj)
    if frame ~= nil then return frame end

    -- Safety get parent.
    local parent_obj
    if frame_obj == game_ui_obj or frame_obj == command_panel_obj or  frame_obj == hero_panel_obj then
        parent_obj = nil
    else
        parent_obj = BlzFrameGetParent(frame_obj)
    end

    frame = {
        __frame_obj = frame_obj,
        __parent = Frame.get(parent_obj),
        __childrens = {}
    }
    setmetatable(frame, Frame_meta)
    Frame.__db:add(frame.__frame_obj, frame)

    return frame
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

---@param parent Frame
function Frame:setParent(parent)
    if not parent then parent = Frame.GAME_UI end

    -- Remove frome previous parent.
    local prev_parent = self.__parent
    prev_parent.__childrens[self] = nil
    -- Add to current parent.
    self.__parent = parent
    parent.__childrens[self] = true
end

---@return framehandle
function Frame:getObj()
    return self.__frame_obj
end

---@param point framepointtype
---@param x number
---@param y number
function Frame:setAbsPoint(point, x, y)
    local width = BlzGetLocalClientWidth()
    local height = BlzGetLocalClientHeight()
    x_offset = (width / (4 * height / 3) - 1) / 2
    Debug(width, 'x', height, '   ', x_offset)
    Debug(x_offset)
    
    BlzFrameSetAbsPoint(self.__frame_obj, point, x - x_offset, y)
end

---@param point framepointtype
---@param x number
---@param y number
function Frame:setPoint(point, relative_frame, relative_point, x, y)
    BlzFrameSetPoint(self.__frame_obj, point, relative_frame, relative_point, x, y)
end

---@param frame Frame
function Frame:setAllPoints(frame)
    BlzFrameSetAllPoints(self.__frame_obj, frame.__frame_obj)
end

function Frame:clearAllPoints()
    BlzFrameClearAllPoints(self.__frame_obj)
end

return Frame