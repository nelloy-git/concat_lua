--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Timer = HandleLib.Timer or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')

--========
-- Module
--========

---@class FrameScreen
local Screen = {}

local p_width = 800
local p_height = 600

local screen_x0 = 0
local screen_y0 = 0
local screen_width = 0.8
local screen_height = 0.6

local update_timer = 0
local update_period = 1

local actions = ActionList.new(Screen)

---@return number
function Screen.getX0()
    return screen_x0
end
---@return number
function Screen.getX0()
    return screen_y0
end

---@return number
function Screen.getWidth()
    return screen_width
end

---@return number
function Screen.getHeight()
    return screen_width
end

---@alias FrameScreenCallback fun(x0:number, y0:number, width:number, height:number)

---@param callback FrameScreenCallback
---@return Action
function Screen.addChangedAction(callback)
    return actions:add(callback)
end

---@param action Action
---@return boolean
function Screen.removeAction(action)
    return actions:remove(action)
end

local function updateResolution()
    local cur_p_width = BlzGetLocalClientWidth()
    local cur_p_height = BlzGetLocalClientHeight()

    -- No changes
    if cur_p_width == p_width and cur_p_height == p_height then
        return
    end
    p_width = cur_p_width
    p_height = cur_p_height

    local ui_pixel_width = cur_p_height * 4 / 3
    screen_width = 0.8 * cur_p_width / ui_pixel_width
    screen_x0 = -(screen_width - 0.8) / 2

    for i = 1, #actions do
        actions[i]:run(screen_x0, screen_y0, screen_width, screen_height)
    end
end

if not IsCompiletime() then
    update_timer = Timer.new()
    update_timer:start(update_period, true, updateResolution)
end

return Screen