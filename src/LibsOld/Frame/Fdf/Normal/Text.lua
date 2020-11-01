--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type FdfBaseClass
local FdfBase = require(lib_path..'Fdf.Base') or error('')

--=======
-- Class
--=======

local FdfText = Class.new('FdfText', FdfBase)
---@class FdfText : FdfBase
local public = FdfText.public
---@class FdfTextClass : FdfBaseClass
local static = FdfText.static
---@type FdfTextClass
local override = FdfText.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfText | nil
---@return FdfText
function override.new(name, child)
    isTypeErr(name, 'string', 'name')
    if child then isTypeErr(child, FdfText, 'child') end

    local instance = child or Class.allocate(FdfText)
    instance = FdfBase.new(name, 'TEXT', false, instance)

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