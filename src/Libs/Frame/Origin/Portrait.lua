--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_deplass

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_path..'.Normal.Base')
local FrameNormalBasePublic = Class.getPublic(FrameNormalBase)
---@type FrameScreen
local FrameScreen = require(lib_path..'.Screen')

--========
-- Module
--========

if IsCompiletime() then
    return
end

-- Portrait size is calculated based on screen resolution. Size base on [0.8, 0.6] coordinates.
-- Размер портрета рассчитывается с учетом того что ВЕСЬ экран [0.8, 0.6].
-- Так же не может быть передвинут за пределы стандартного [0.8, 0.6]

local handle = BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, 0)
BlzFrameClearAllPoints(handle)
---@class FrameOriginPortrait
local Portrait = FrameNormalBase.new(handle)
Portrait:setParent(nil)

---@param width number
---@param height number
function Portrait:setSize(width, height)
    width = 0.8 / FrameScreen.getWidth() * width
    FrameNormalBasePublic.setSize(self, width, height)
end

---@return number
function Portrait:getWidth()
    return FrameScreen.getWidth() / 0.8 * FrameNormalBasePublic.getWidth(Portrait)
end

---@param x number
---@param y number
function Portrait:setPos(x, y)
    x = 0.8 / FrameScreen.getWidth() * (x - FrameScreen.getX0())
    FrameNormalBasePublic.setPos(self, x, y)
end

---@return number
function Portrait:getX()
    return FrameScreen.getWidth() / 0.8 * FrameNormalBasePublic.getX(Portrait)
end

-- TODO getAbsX

FrameScreen.addResolutionChangedAction(function(_, screen_prev_w, _, new_x0, _, _)
    local k = screen_prev_w / 0.8

    local real_w = k * FrameNormalBasePublic.getWidth(Portrait)
    Portrait:setSize(real_w, Portrait:getHeight())

    local real_x = k * FrameNormalBasePublic.getX(Portrait)
    Portrait:setPos(real_x, Portrait:getY())
end)

return Portrait