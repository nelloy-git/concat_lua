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
    Frame.GAME_UI = Frame.get(game_ui_obj)

    command_panel_obj = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, 0))
    hero_panel_obj = BlzFrameGetParent(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BAR, 0))

    initialized = true
end

local function newFrame(obj, parent)
    frame = {
        __x = 0,
        __y = 0,
        __width = 0,
        __height = 0,
        __frame_obj = obj,
        __parent = parent,
        __childrens = {}
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
    elseif 
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

---@param parent Frame
function Frame:setParent(parent)
    -- Remove child from previous parent.
    for i = 1, #self.__parent.__childrens do
        if self.__parent.__childrens[i] == self then
            table.remove(self.__parent.__childrens, i)
            break
        end
    end

    self.__parent = parent
    table.insert(parent.__childrens, 1, self)
end

---@return Frame
function Frame:getParent()
    return self.__parent
end

---@return Frame[]
function Frame:getChildrens()
    return self.__childrens
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
    local x = self:getX()
end


return Frame