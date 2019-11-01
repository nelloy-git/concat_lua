--==========
-- Includes
--==========

---@type Widget
local Widget = require('Class.Widget.Main')

--========
-- Module
--========


local x_offset = 0
local y_offset = 0.6
local screen_width = 0.8
local screen_height = 0.6

local resolution_width = 0
local resolution_height = 0

---@return number
function Widget.getScreenWidth()
    return screen_width
end

---@return number
function Widget.getScreenHeight()
    return screen_height
end

---@return number
function Widget.getScreenXOffset()
    return x_offset
end

---@return number
function Widget.getScreenYOffset()
    return y_offset
end

--- Returns true if resolution has been changed.
---@return boolean
function Widget.updateScreen()
    local w = BlzGetLocalClientWidth()
    local h = BlzGetLocalClientHeight()
    if w ~= resolution_width or h ~= resolution_height then
        x_offset = -(w / (4 * h / 3) - 1) / 2
        screen_width = 0.8 - 2 * x_offset
        resolution_width = w
        resolution_height = h
        return true
    end
    return false
end