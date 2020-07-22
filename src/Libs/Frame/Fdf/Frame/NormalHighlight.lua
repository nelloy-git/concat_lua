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

local FdfNormalHighlight = Class.new('FdfNormalHighlight', FdfNormalBase)
---@class FdfNormalHighlight : FdfNormalBase
local public = FdfNormalHighlight.public
---@class FdfNormalHighlightClass : FdfNormalBaseClass
local static = FdfNormalHighlight.static
---@type FdfNormalHighlightClass
local override = FdfNormalHighlight.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param fdf_file FdfFile | nil
---@param child_instance FdfNormalHighlight | nil
---@return FdfNormalHighlight
function override.new(name, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfNormalHighlight, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfNormalHighlight)
    instance = FdfNormalBase.new(name, 'HIGHLIGHT', fdf_file, instance)

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