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

local FrameType = {}
FrameType.BACKDROP = true
FrameType.BUTTON = true
FrameType.CHATDISPLAY = true
FrameType.CHECKBOX = true
FrameType.CONTROL = true
FrameType.DIALOG = true
FrameType.EDITBOX = true
FrameType.FRAME = true
FrameType.GLUEBUTTON = true
FrameType.GLUECHECKBOX = true
FrameType.GLUEEDITBOX = true
FrameType.GLUEPOPUPMENU = true
FrameType.GLUETEXTBUTTON = true
FrameType.HIGHLIGHT = true
FrameType.LISTBOX = true
FrameType.MENU = true
FrameType.MODEL = true
FrameType.POPUPMENU = true
FrameType.SCROLLBAR = true
FrameType.SLASHCHATBOX = true
FrameType.SLIDER = true
FrameType.TEXT = true
FrameType.TEXTAREA = true
FrameType.TEXTBUTTON = true
FrameType.TIMERTEXT = true
FrameType.SPRITE = true

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
    BlzFrameClearAllPoints(frame_obj)

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

    if frame_obj == game_ui_obj then
        frame.__x = -x_offset
        frame.__y = Frame.getScreenHeight()
        frame.__width = Frame.getScreenWidth()
        frame.__height = Frame.getScreenHeight()
    end

    return frame
end

---@param frame_type FrameType|string
---@return Frame
function Frame.new(frame_type, parent)
    local parent_obj
    if not parent then
        parent_obj = game_ui_obj
    else
        parent_obj = parent:getObj()
    end
    local obj
    if FrameType[frame_type] then
        obj = BlzCreateFrameByType(frame_type, frame_type, parent_obj, "", 0)
    else
        obj = BlzCreateFrame(frame_type, parent_obj, 0, 0)
    end
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
    return self.__frame_obj or game_ui_obj
end

---@param x number
---@param y number
function Frame:setPosition(x, y)
    self.__x = x or 0
    self.__y = y or 0
    self:update()
end

---@param width number
---@param height number
function Frame:setSize(width, height)
    self.__width = width
    self.__height = height
    self:update()
end

function Frame:getWidth()
    return self.__width or 0
end

function Frame:getHeight()
    return self.__height or 0
end

---@param frame Frame
function Frame:setAllPoints(frame)
    BlzFrameSetAllPoints(self.__frame_obj, frame.__frame_obj)
end

function Frame:getX()
    local p_x
    if not self.__parent then
        p_x = 0
    else
        p_x = self.__parent:getX()
    end
    local x = self.__x or 0
    return p_x + x
end

function Frame:getY()
    local p_y
    if not self.__parent then
        p_y = Frame.getScreenHeight()
    else
        p_y = self.__parent:getY()
    end
    local y = self.__y or 0
    return p_y - y
end

function Frame:applyMainFramePos()
    local parent_obj
    if not self.__parent then
        parent_obj = game_ui_obj
    else
        parent_obj = self.__parent:getObj()
    end
    local x = self.__x or 0
    local y = self.__y or 0

    BlzFrameSetPoint(self.__frame_obj, FRAMEPOINT_TOPLEFT, game_ui_obj, FRAMEPOINT_TOPLEFT, self:getX(), self:getY())
    BlzFrameSetSize(self.__frame_obj, self.__width, self.__height)
end

--- Redefine this function if need other screen size depencies.
function Frame:update()
    self:applyMainFramePos()
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
        Frame.__db:forEach(function(_, frame)
            frame:update()
        end)
        cur_width = w
        cur_height = h
    end
    timer:addAction(1, update_resolution)
end

return Frame