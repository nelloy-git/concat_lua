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

local FdfNormalBase = Class.new('FdfNormalBase', FdfFrame)
---@class FdfNormalBase : FdfFrame
local public = FdfNormalBase.public
---@class FdfNormalBaseClass : FdfFrameClass
local static = FdfNormalBase.static
---@type FdfNormalBaseClass
local override = FdfNormalBase.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_type string
---@param fdf_file FdfFile | nil
---@param child_instance FdfNormalBase | nil
---@return FdfNormalBase
function override.new(name, base_type, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfNormalBase, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfNormalBase)
    instance = FdfFrame.new(name, base_type, fdf_file, instance)

    return instance
end

--========
-- Public
--========

---@param subframe FdfNormalBase
function public:addSubframe(subframe)
    checkTypeErr(subframe, FdfNormalBase, 'subframe')
    FdfFramePublic.addSubframe(self, subframe)
end

--=========
-- Private
--=========

return static