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

local FdfHighlight = Class.new('FdfHighlight', FdfBase)
---@class FdfHighlight : FdfBase
local public = FdfHighlight.public
---@class FdfHighlightClass : FdfBaseClass
local static = FdfHighlight.static
---@type FdfHighlightClass
local override = FdfHighlight.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfHighlight | nil
---@return FdfHighlight
function override.new(name, child)
    isTypeErr(name, 'string', 'name')
    if child then isTypeErr(child, FdfHighlight, 'child') end

    local instance = child or Class.allocate(FdfHighlight)
    instance = FdfBase.new(name, 'HIGHLIGHT', false, instance)

    return instance
end

--========
-- Public
--========

--- Look-Up FileNames in some String table (for example gameinterface)
---@param flag boolean
function public:setDecorateFileNames(flag)
    if flag then
        self:setParameter('DecorateFileNames')
    else
        self:removeParameter('DecorateFileNames')
    end
end

---@param t string | "'FILETEXTURE'" | "'SHADE'"
function public:setHighlightType(t)
    self:setParameter('HighlightType', '\"'..t..'\"')
end

---@param path string
function public:setAlphaFile(path)
    self:setParameter('HighlightAlphaFile', '\"'..path..'\"')
end

---@param mode string | "'ADD'" | "'BLEND'"
function public:setAlphaMode(mode)
    self:setParameter('HighlightAlphaMode', '\"'..mode..'\"')
end

---@param r number
---@param g number
---@param b number
---@param a number
function public:setColor(r, g, b, a)
    self:setParameter('HighlightColor', string.format('%f %f %f %f', r, g, b, a))
end

--=========
-- Private
--=========

return static