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

local initialized = false
function Frame.init()
    if initialized then return nil end

    Frame.GAME_UI = Frame.getOrigin(ORIGIN_FRAME_GAME_UI, 0)
    Frame.COMMAND_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 6),
        [8] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 7),
        [9] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 8),
        [10] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 9),
        [11] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 10),
        [12] = Frame.getOrigin(ORIGIN_FRAME_COMMAND_BUTTON, 11),
    }
    Frame.HERO_BAR = Frame.getOrigin(ORIGIN_FRAME_GAME_UI, 0)
    Frame.HERO_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON, 6),
    }
    Frame.HERO_HP_BAR = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_HERO_HP_BAR, 6),
    }
    Frame.HERO_MANA_BAR = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_HERO_MANA_BAR, 6),
    }
    Frame.HERO_HP_BAR = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 5),
        [7] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 6),
    }
    Frame.ITEM_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_ITEM_BUTTON, 5),
    }
    Frame.MINIMAP = Frame.getOrigin(ORIGIN_FRAME_MINIMAP, 0)
    Frame.MINIMAP_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 3),
        [5] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 4),
        [6] = Frame.getOrigin(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 5),
    }
    Frame.SYSTEM_BUTTON = {
        [1] = Frame.getOrigin(ORIGIN_FRAME_SYSTEM_BUTTON, 0),
        [2] = Frame.getOrigin(ORIGIN_FRAME_SYSTEM_BUTTON, 1),
        [3] = Frame.getOrigin(ORIGIN_FRAME_SYSTEM_BUTTON, 2),
        [4] = Frame.getOrigin(ORIGIN_FRAME_SYSTEM_BUTTON, 3),
    }
    --Frame.TOOLTIP
    --Frame.UBERTOOLTIP
    --Frame.CHAT_MSG
    --Frame.UNIT_MSG
    --Frame.TOP_MSG
    --Frame.PORTRAIT
    --Frame.WORLD_FRAME

    initialized = true
end

---@param frame_type FrameType
---@return Frame
function Frame.new(frame_type)
    local obj = BlzCreateFrame(frame_type, Frame.GAME_UI, 0, 0)
    local frame = {
        __frame_obj = BlzCreateFrame(frame_type, Frame.GAME_UI, 0, 0),
        __parent_obj = Frame.GAME_UI,
        __childrens = {}
    }
    setmetatable(frame, Frame_meta)
    Frame.__db:add(frame.__frame_obj, frame)

    return frame
 end

---@param frame_obj framehandle
---@return Frame
function Frame.get(frame_obj)
    return Frame.__db:get(frame_obj)
end

---@param frame_type originframetype
---@param index number
---@return Frame
function Frame.getOrigin(frame_type, index)
    local obj = BlzGetOriginFrame(frame_type, index)
    local frame = Frame.get(obj)
    if frame ~= nil then return frame end

    frame = {
        __frame_obj = obj,
        __parent_obj = BlzFrameGetParent(obj),
        __childrens = {}
    }
    setmetatable(frame, Frame_meta)
    Frame.__db:add(frame.__frame_obj, frame)

    return frame
end

function Frame:setSize(width, height)
    self.__width = width
    self.__height = height
    BlzFrameSetSize(self.frame_obj, width, height)
end

function Frame:getHeight()
    return self.__height
end

function Frame:getWidth()
    return self.__width
end

function Frame:setPosition(x, y)
    self.__x = x
    self.__y = y
    BlzFrameSetPoint(self.__frame_obj, FRAMEPOINT_TOPLEFT, self.__parent_obj, FRAMEPOINT_TOPLEFT, x, y)
end

function Frame:hide()
    BlzFrameSetVisible(self.__frame_obj, false)
end

function Frame:show()
    BlzFrameSetVisible(self.__frame_obj, true)
end

return Frame