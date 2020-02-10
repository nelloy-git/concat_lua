--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type Timer
local Timer = require('Class.Timer.Timer')

--=======
-- Class
--=======

local ControllerScreen = Class.new('ControllerScreen')
---@class ControllerScreen
local public = ControllerScreen.public
---@class ControllerScreenClass
local static = ControllerScreen.static
---@type ControllerScreenClass
local override = ControllerScreen.override
local private = {}

--=========
-- Static
--=========

---@return number
function static.getRealZeroX()
    if not private.inited then
        private.timerLoop()
    end 
    return private.min_x
end

---@return number
function static.getRealWidth()
    if not private.inited then
        private.timerLoop()
    end
    return private.real_width
end

---@return number
function static.getRealRatio()
    if not private.inited then
        private.timerLoop()
    end
    return private.real_width
end

--=========
-- Private
--=========

private.inited = false

private.data = setmetatable({}, {__mode = 'k'})
private.pixel_width = 0
private.pixel_height = 0
private.default_ratio = 4 / 3

private.min_x = 0
private.real_width = 0
private.real_ratio = 0

function private.update(width, height)
    local ui_pixel_width = height / private.default_ratio
    private.real_width = 0.8 * (ui_pixel_width / width + 1)
    private.min_x = -(private.real_width - 0.8) / 2
    private.real_ratio = width / height
    private.inited = true

    --print(private.min_x, private.real_width)
end

function private.timerLoop()
    local cur_width = BlzGetLocalClientWidth()
    local cur_height = BlzGetLocalClientHeight()
    if cur_width ~= private.pixel_width or cur_height ~= private.pixel_height then
        private.pixel_width = cur_width
        private.pixel_height = cur_height
        private.update(cur_width, cur_height)
    end
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(1, true, private.timerLoop)
end

return static