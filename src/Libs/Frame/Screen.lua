--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Action
local Timer = UtilsLib.Handle.Timer

--========
-- Module
--========

---@class FrameScreen
local Screen = {}

local screen_pixel_width = 1024
local screen_pixel_height = 768

local screen_width = 0.8
local screen_height = 0.6
local screen_x0 = 0

local update_timer = 0
local update_period = 1

local actions = {}

---@return number
function Screen.getX0()
    return screen_x0
end

---@alias FrameScreenCallback fun(prev_x0:number, prev_width:number, prev_height:number, new_x0:number, new_width:number, new_height:number)

---@param callback FrameScreenCallback
---@return Action
function Screen.addResolutionChangedAction(callback)
    local action = Action.new(callback, Screen)
    table.insert(actions, action)
    return action
end

---@param action Action
---@return boolean
function Screen.removeAction(action)
    if action:getOwner() ~= Screen then
        return false
    end

    for i = 1, #actions do
        if actions[i] == action then
            table.remove(actions, i)
            return true
        end
    end

    return false
end

if not IsCompiletime() then
    update_timer = Timer.new()
    update_timer:start(update_period, true, function()
        local cur_screen_width = BlzGetLocalClientWidth()
        local cur_screen_height = BlzGetLocalClientHeight()

        -- No changes
        if cur_screen_width == screen_pixel_width and
           cur_screen_height == screen_pixel_height then
            return
        end

        local prev_x0 = screen_x0
        local prev_width = screen_width
        local prev_height = screen_height

        screen_pixel_width = cur_screen_width
        screen_pixel_height = cur_screen_height

        local ui_pixel_width = cur_screen_height * 4 / 3

        screen_width = 0.8 * cur_screen_width / ui_pixel_width
        screen_x0 = -(screen_width - 0.8) / 2

        for i = 1, #actions do
            actions[i]:run(prev_x0, prev_width, prev_height,
                           screen_x0, screen_width, screen_height)
        end
    end)
end

return Screen