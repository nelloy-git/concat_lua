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

local game_ui_obj

local initialized = false
function Frame.init()
    if initialized then return nil end

    game_ui_obj = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

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
    local obj = Frame.__db:get(frame_obj)
    if obj then return obj end

    -- Safety get parent.
    local success, parent_obj = pcall(BlzFrameGetParent, obj)
    if not success then parent_obj = nil end

    local frame = {
        __frame_obj = obj,
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
    return Frame.__db:get(obj)
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
    BlzFrameSetPoint(self.__frame_obj, point, game_ui_obj, FRAMEPOINT_BOTTOMLEFT, x, y)
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