--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

---@type FdfFileClass
local FdfFile = require(lib_modname..'.Fdf.File')
---@type FdfNormalBaseClass
local FdfNormalBase = require(lib_modname..'.Fdf.Frame.NormalBase')

--=======
-- Class
--=======

local FdfNormalText = Class.new('FdfNormalText', FdfNormalBase)
---@class FdfNormalText : FdfNormalBase
local public = FdfNormalText.public
---@class FdfNormalTextClass : FdfNormalBaseClass
local static = FdfNormalText.static
---@type FdfNormalTextClass
local override = FdfNormalText.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param fdf_file FdfFile | nil
---@param child_instance FdfNormalText | nil
---@return FdfNormalText
function override.new(name, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfNormalText, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfNormalText)
    instance = FdfNormalBase.new(name, 'TEXT', fdf_file, instance)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    local str_width = tostring(width)
    self:setParameter('Width', str_width)
end

---@param height number
function public:setHeight(height)
    local str_height = tostring(height)
    self:setParameter('Height', str_height)
end

--- Look-Up FileNames in some String table (for example gameinterface)
---@param flag boolean
function public:setDecorateFileNames(flag)
    if flag then
        self:setParameter('DecorateFileNames')
    else
        self:removeParameter('DecorateFileNames')
    end
end

---@param text string
function public:setText(text)
    self:setParameter('Text', '\"'..text..'\"')
end

---@param path string
---@param size number
function public:setFont(path, size)
    self:setParameter('FrameFont', string.format('\"%s\", %f, \"\"',
                                                 path, size))
end

---@param horz string | "'JUSTIFYCENTER'" | "'JUSTIFYLEFT'" | "'JUSTIFYRIGHT'"
---@param vert string | "'JUSTIFYMIDDLE'" | "'JUSTIFYTOP'" | "'JUSTIFYBOTTOM'"
function public:setJustification(horz, vert)
    self:setParameter('FontJustificationH', horz)
    self:setParameter('FontJustificationV', vert)
end

---@param x number
---@param y number
function public:setJustificationOffset(x, y)
    self:setParameter('FontJustificationOffset', tostring(x)..' '..tostring(y))
end

---@param r number
---@param g number
---@param b number
---@param a number
function public:setColor(r, g, b, a)
    self:setParameter('FontColor', string.format('%f %f %f %f',
                                                 r, g, b, a))
end

---@param r number
---@param g number
---@param b number
---@param a number
function public:setHighlightColor(r, g, b, a)
    self:setParameter('FontHighlightColor', string.format('%f %f %f %f',
                                                 r, g, b, a))
end

---@param r number
---@param g number
---@param b number
---@param a number
function public:setDisabledColor(r, g, b, a)
    self:setParameter('FontDisabledColor', string.format('%f %f %f %f',
                                                 r, g, b, a))
end

---@param r number
---@param g number
---@param b number
---@param a number
function public:setShadowColor(r, g, b, a)
    self:setParameter('FontShadowColor', string.format('%f %f %f %f',
                                                 r, g, b, a))
end

---@param x number
---@param y number
function public:setShadowOffset(x, y)
    self:setParameter('FontShadowOffset', tostring(x)..' '..tostring(y))
end

--=========
-- Private
--=========

return static