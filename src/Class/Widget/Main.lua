--==========
-- Includes
--==========

---@type DataBase
local DataBase = require('utils.DataBase')

--=======
-- Class
--=======

---@class Widget : Class
local Widget = Class('Widget')
--local Widget = newClass('Widget')
db = DataBase.new("userdata", "Frame")

local initialized = false
function Widget.init()
    if initialized then return nil end

    game_ui_obj = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    Widget.GAME_UI = Widget.getOrigin(ORIGIN_FRAME_GAME_UI, 0)

    initialized = true
end

local game_ui_obj
---@param framehandle framehandle
---@return Widget
function Widget:newInstance(framehandle)
    ---@type Widget
    local widget = Widget:newInstance()
    widget.__framehandle = framehandle
    db:add(framehandle, widget)

    if framehandle ~= game_ui_obj then
        BlzFrameClearAllPoints(framehandle)
        BlzFrameSetParent(framehandle, game_ui_obj)
    end

    if Widget.GAME_UI ~= nil then
        widget:setParent(Widget.GAME_UI)
    end

    return widget
end

---@return framehandle
function Widget:getObj()
    return self.__framehandle
end

---@param framehandle framehandle
---@return Widget
function Widget.get(framehandle)
    local widget = db:get(framehandle)
    if widget ~= nil then
        return widget
    end

    return newWidget(framehandle)
end

---@param frametype string
---@return Widget
function Widget.newDefaultType(frametype)
    local framehandle = BlzCreateFrameByType(frametype, frametype, game_ui_obj, "", 0)
    return Widget.get(framehandle)
 end

---@param frametype string
---@return Widget
 function Widget.newCustomType(frametype)
    local framehandle = BlzCreateFrame(frametype, game_ui_obj, 0, 0)
    return Widget.get(framehandle)
 end

---@param originframetype originframetype
---@param index number
---@return Widget
function Widget.getOrigin(originframetype, index)
    local framehandle = BlzGetOriginFrame(originframetype, index)
    return Widget.get(framehandle)
end

---@param framename string
---@param context number
function Widget.getByName(framename, context)
    local framehandle = BlzGetFrameByName(framename, context)
    return Widget.get(framehandle)
end

---@param path string
---@return boolean
function Widget.loadToc(path)
    if not BlzLoadTOCFile(path) then
        Debug('Widget error: can not load .toc file. \n'..path)
        return false
    end
    return true
end

return Widget