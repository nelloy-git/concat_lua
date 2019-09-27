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
local screen_width = 0.8
local screen_height = 0.6

-- ============
--  Predefined
-- ============
local game_ui_obj
local command_panel_obj
local hero_panel_obj
local timer
local update_resolution

local initialized = false
function Frame.init()
    if initialized then return nil end

    game_ui_obj = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    command_panel_obj = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, 0))
    hero_panel_obj = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BAR, 0))
    timer = glTimer
    update_resolution()

    initialized = true
end

---@param frame_obj framehandle
---@return Frame
function Frame.get(frame_obj)
    if frame_obj == nil then return nil end
    local frame = Frame.__db:get(frame_obj)
    if frame ~= nil then return frame end

    -- Safety get parent.
    local parent_obj
    if frame_obj == game_ui_obj or frame_obj == command_panel_obj or frame_obj == hero_panel_obj then
        parent_obj = nil
    else
        parent_obj = BlzFrameGetParent(frame_obj)
        if parent_obj == frame_obj then parent_obj = nil end
    end

    ---@type Frame
    frame = {
        __frame_obj = frame_obj,
        __parent = Frame.get(parent_obj),
        __width = 0,
        __height = 0
    }
    setmetatable(frame, Frame_meta)
    Frame.__db:add(frame.__frame_obj, frame)

    frame:setAbsPosition(-0.05, -0.05)
    frame:setSize(0.1, 0.1)

    return frame
end

---@param frame_type FrameType|string
---@return Frame
function Frame.new(frame_type, parent)
    local obj = BlzCreateFrame(frame_type, parent.__frame_obj, 0, 0)
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

---@return number
function Frame.getScreenWidth()
    return screen_width
end

---@return number
function Frame.getScreenHeight()
    return screen_height
end

---@param parent Frame
function Frame:setParent(parent)
    self.__parent = parent
    BlzFrameSetParent(self.__frame_obj, parent.__frame_obj)
end

---@return framehandle
function Frame:getObj()
    return self.__frame_obj
end

---@param x number
---@param y number
function Frame:setAbsPosition(x, y)
    self.__abs_x = x
    self.__abs_y = screen_height - y
    BlzFrameSetAbsPoint(self.__frame_obj, FRAMEPOINT_TOPLEFT, x - x_offset, screen_height - y)
end

---@param relative_frame Frame
---@param x number
---@param y number
function Frame:setPosition(relative_frame, x, y)
    self.__abs_x = nil
    self.__abs_y = nil
    BlzFrameSetPoint(self.__frame_obj, FRAMEPOINT_TOPLEFT, relative_frame.__frame_obj, FRAMEPOINT_TOPLEFT, x, -y)
end

---@param width number
---@param height number
function Frame:setSize(width, height)
    self.__width = width
    self.__height = height
    BlzFrameSetSize(self.__frame_obj, width, height)
end

---@param frame Frame
function Frame:setAllPoints(frame)
    BlzFrameSetAllPoints(self.__frame_obj, frame.__frame_obj)
end

function Frame:clearAllPoints()
    self.__abs_points = {}
    BlzFrameClearAllPoints(self.__frame_obj)
end

--- Redefine this function if need other screen size depencies.
function Frame:update()
    self:setAbsPosition(self.__abs_x, self.__abs_y)
    self:setSize(self.__width, self.__height)
end

function Frame:hide()
    BlzFrameSetVisible(self.__frame_obj, false)
end

function Frame:show()
    BlzFrameSetVisible(self.__frame_obj, true)
end

local cur_width
local cur_height
update_resolution = function()
    local w = BlzGetLocalClientWidth()
    local h = BlzGetLocalClientHeight()
    if w ~= cur_width or h ~= cur_height then
        x_offset = (w / (4 * h / 3) - 1) / 2
        screen_width = 0.8 + 2 * x_offset
        Frame.__db:forEach(function(frame_obj, frame)
            frame:update()
        end)
        cur_width = w
        cur_height = h
    end
    timer:addAction(1, update_resolution)
end

return Frame