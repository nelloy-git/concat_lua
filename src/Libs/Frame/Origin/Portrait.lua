--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame)

---@type FrameScreen
local Screen = require(lib_path..'Screen')

--========
-- Module
--========

if IsCompiletime() then
    return
end

-- Portrait size is calculated based on screen resolution. Size base on [0.8, 0.6] coordinates.
-- Размер портрета рассчитывается с учетом того что ВЕСЬ экран [0.8, 0.6].

local handle = BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, 0)
BlzFrameClearAllPoints(handle)

---@class FrameOriginPortrait
local Portrait = Frame.link(handle, false)
Portrait:setParent(nil)
Portrait:setPos(0.4, 0.3)
Portrait:setSize(0.1, 0.1)

---@param width number
---@param height number
function Portrait:setSize(width, height)
    width = 0.8 / Screen.getWidth() * width
    FramePublic.setSize(self, width, height)
end

---@return number
function Portrait:getWidth()
    return Screen.getWidth() / 0.8 * FramePublic.getWidth(Portrait)
end

---@param x number
---@param y number
function Portrait:setPos(x, y)
    x = 0.8 / Screen.getWidth() * (x - Screen.getX0())
    FramePublic.setPos(self, x, y)
end

---@return number
function Portrait:getX()
    return Screen.getWidth() / 0.8 * FramePublic.getX(Portrait)
end

-- TODO getAbsX

local prev_w = Screen.getWidth()
Screen.addChangedAction(function(x0, y0, w, h)
    local k = prev_w / 0.8
    prev_w = w

    local real_w = k * FramePublic.getWidth(Portrait)
    Portrait:setSize(real_w, Portrait:getHeight())

    local real_x = k * FramePublic.getAbsX(Portrait)
    Portrait:setPos(real_x, Portrait:getY())
end)

return Portrait