--==========
-- Includes
--==========

---@type DataBase
local Frame = require('Class.Frame.Main')

require('Class.Frame.Position')

--========
-- Module
--========

local FrameScreenModule = {}

local update_period = 1
local update_resolution

local initialized = false
function FrameScreenModule.init()
    if initialized then return nil end
    Frame.init()
    update_resolution()
    initialized = true
end

local x_offset = 0
local screen_width = 0.8
local screen_height = 0.6

---@return number
function Frame.getScreenWidth()
    return screen_width
end

---@return number
function Frame.getScreenHeight()
    return screen_height
end

---@return number
function Frame.getScreenRatio()
    return screen_width / screen_height
end

function Frame.getScreenXOffset()
    return x_offset
end

local cur_width = 0
local cur_height = 0
update_resolution = function()
    local w = BlzGetLocalClientWidth()
    local h = BlzGetLocalClientHeight()
    if w ~= cur_width or h ~= cur_height then
        x_offset = (w / (4 * h / 3) - 1) / 2
        screen_width = 0.8 + 2 * x_offset
        cur_width = w
        cur_height = h

        Frame.GAME_UI:update()
    end
    glTimer:addAction(update_period, update_resolution)
end

return FrameScreenModule