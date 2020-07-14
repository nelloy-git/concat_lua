--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr

---@type FdfFileClass
local FdfFile = require(lib_modname..'.Fdf.File')
---@type FdfSimpleBaseClass
local FdfSimpleBase = require(lib_modname..'.Fdf.Frame.SimpleBase')

--=======
-- Class
--=======

local FdfSimpleFrame = Class.new('FdfSimpleFrame', FdfSimpleBase)
---@class FdfSimpleFrame : FdfSimpleBase
local public = FdfSimpleFrame.public
---@class FdfSimpleFrameClass : FdfSimpleBaseClass
local static = FdfSimpleFrame.static
---@type FdfSimpleFrameClass
local override = FdfSimpleFrame.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param fdf_file FdfFile | nil
---@param child_instance FdfSimpleFrame | nil
---@return FdfSimpleFrame
function override.new(name, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfSimpleFrame, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfSimpleFrame)
    instance = FdfSimpleBase.new(name, 'SIMPLEFRAME', fdf_file, instance)

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

--=========
-- Private
--=========

return static