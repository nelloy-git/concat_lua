--==========
-- Includes
--==========

---@type DataBase
local Frame = require('Class.Frame.Main')

--========
-- Module
--========


local x_offset = 0
local screen_width = 0.8
local screen_height = 0.6

local resolution_width = 0
local resolution_height = 0

---@return number
function Frame.getScreenWidth()
    return screen_width
end

---@return number
function Frame.getScreenHeight()
    return screen_height
end

---@return number
function Frame.getScreenXOffset()
    return x_offset
end

--- Returns true if resolution has been changed.
---@return boolean
function Frame.updateScreen()
    local w = BlzGetLocalClientWidth()
    local h = BlzGetLocalClientHeight()
    if w ~= resolution_width or h ~= resolution_height then
        x_offset = -(w / (4 * h / 3) - 1) / 2
        screen_width = 0.8 + 2 * x_offset
        resolution_width = w
        resolution_height = h
        return true
    end
    return false
end