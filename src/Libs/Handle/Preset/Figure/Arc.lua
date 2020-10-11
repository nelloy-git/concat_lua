--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type FigurePixelClass
local Pixel = require(lib_path..'Preset.Figure.Pixel') or error('')
---@type HandleSettings
local Settings = require(lib_path..'Settings') or error('')

--=======
-- Class
--=======

local FigureArc = Class.new('FigureArc')
---@class FigureArc
local public = FigureArc.public
---@class FigureArcClass
local static = FigureArc.static
---@type FigureArcClass
local override = FigureArc.override
local private = {}

--=========
-- Static
--=========

---@param child FigureArc | nil
---@return FigureArc
function override.new(child)
    if child then isTypeErr(child, FigureArc, 'child') end

    local instance = child or Class.allocate(FigureArc)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param x0 number
---@param y0 number
---@param range number
---@param start_angle number
---@param end_angle number
function public:setPosPolar(x0, y0, range, start_angle, end_angle)
    local priv = private.data[self]

    local length = (end_angle - start_angle) * range
    local count = math.floor(length / private.step) + 1
    while (count > #priv.pixels) do
        local pixel = Pixel.new()
        pixel:setColor(priv.color.r, priv.color.g, priv.color.b, priv.color.a)
        pixel:renderAlways(priv.render_always)
        pixel:setVisible(priv.is_visible)
        table.insert(priv.pixels, pixel)
    end
    while (count < #priv.pixels) do
        local pixel = table.remove(priv.pixels)
        pixel:destroy()
    end

    local a0 = start_angle
    local step_a = (end_angle - start_angle) / count
    for i = 1, count do
        priv.pixels[i]:setPos(x0 + range * math.cos(a0), y0 + range * math.sin(a0), 0)
        a0 = a0 + step_a
    end
end

--- [0, 1]
---@param r number
---@param g number
---@param b number
---@param a number
function public:setColor(r, g, b, a)
    local priv = private.data[self]

    priv.color = {r = r, g = g, b = b, a = a}
    for i = 1, #priv.pixels do
        priv.pixels[i]:setColor(r, g, b, a)
    end
end

---@param flag boolean
function public:renderAlways(flag)
    local priv = private.data[self]

    priv.render_always = flag
    for i = 1, #priv.pixels do
        priv.pixels[i]:renderAlways(flag)
    end
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]

    priv.is_visible = flag
    for i = 1, #priv.pixels do
        priv.pixels[i]:setVisible(flag)
    end
end

function public:destroy()
    local priv = private.data[self]
    for i = 1, #priv.pixels do
        priv.pixels[i]:destroy()
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.step = Settings.FigurePixelSize / 2

---@param self FigureArc
function private.newData(self)
    local priv = {
        color = {r = 1, g = 1, b = 1, a = 1},
        render_always = true,
        is_visible = true,

        pixels = {}
    }
    private.data[self] = priv
end

return static