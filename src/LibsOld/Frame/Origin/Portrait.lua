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
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Log = UtilsLib.Log or error('')

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
local private = {
    parent = nil,
    x = 0,
    y = 0,
    w = 0,
    h = 0
}

---@param x number
---@param y number
function Portrait:setPos(x, y)
    local parent = private.parent
    private.x = parent and parent:getAbsX() + x or x
    private.y = parent and parent:getAbsY() + y or y

    local real_x = 0.8 / Screen.getWidth() * (x - Screen.getX0())
    local real_y = y
    local real_w = FramePublic.getWidth(self)
    local real_h = FramePublic.getHeight(self)

    real_x = real_x < 0.001 and 0.001 or real_x
    real_y = real_y < 0.001 and 0.001 or real_y
    real_x = (real_x + real_w) > 0.799 and 0.799 - real_w or real_x
    real_y = (real_y + real_h) > 0.599 and 0.599 - real_h or real_y

    FramePublic.setPos(self, real_x, real_y)
    FramePublic.setSize(self, real_w, real_h)
end

---@return number
function Portrait:getX()
    return private.x
end

---@param width number
---@param height number
function Portrait:setSize(width, height)
    private.w = width
    private.h = height

    local real_x = FramePublic.getX(self)
    local real_y = FramePublic.getY(self)
    local real_w = 0.8 / Screen.getWidth() * width
    local real_h = height

    real_x = real_x < 0.001 and 0.001 or real_x
    real_y = real_y < 0.001 and 0.001 or real_y
    real_x = (real_x + real_w) > 0.799 and 0.799 - real_w or real_x
    real_y = (real_y + real_h) > 0.599 and 0.599 - real_h or real_y

    FramePublic.setPos(self, real_x, real_y)
    FramePublic.setSize(self, real_w, real_h)
end

---@return number
function Portrait:getWidth()
    return private.w
end

--- Disabled
---@param parent Frame
function Portrait:setParent(parent)
    Log:wrn('Portrait: setParent function is disabled.')
end

Screen.addChangedAction(function(x0, y0, w, h)
    Portrait:setSize(private.w, private.h)
    Portrait:setPos(private.x, private.y)
end)

Portrait:setPos(private.x, private.y)
Portrait:setSize(private.w, private.h)

return Portrait