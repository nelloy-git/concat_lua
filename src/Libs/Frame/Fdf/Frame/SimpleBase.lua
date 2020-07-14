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
---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.Fdf.Frame')
local FdfFramePublic = Class.getPublic(FdfFrame)

--=======
-- Class
--=======

local FdfSimpleBase = Class.new('FdfSimpleBase', FdfFrame)
---@class FdfSimpleBase : FdfFrame
local public = FdfSimpleBase.public
---@class FdfSimpleBaseClass : FdfFrameClass
local static = FdfSimpleBase.static
---@type FdfSimpleBaseClass
local override = FdfSimpleBase.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_type string
---@param fdf_file FdfFile | nil
---@param child_instance FdfSimpleBase | nil
---@return FdfSimpleBase
function override.new(name, base_type, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfSimpleBase, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfSimpleBase)
    instance = FdfFrame.new(name, base_type, fdf_file, instance)

    return instance
end

--========
-- Public
--========

---@param subframe FdfSimpleBase
function public:addSubframe(subframe)
    checkTypeErr(subframe, FdfSimpleBase, 'subframe')
    FdfFramePublic.addSubframe(self, subframe)
end

--=========
-- Private
--=========

return static