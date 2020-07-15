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
---@type FdfNormalBaseClass
local FdfNormalBase = require(lib_modname..'.Fdf.Frame.NormalBase')

--=======
-- Class
--=======

local FdfNormalBackdrop = Class.new('FdfNormalBackdrop', FdfNormalBase)
---@class FdfNormalBackdrop : FdfNormalBase
local public = FdfNormalBackdrop.public
---@class FdfNormalBackdropClass : FdfNormalBaseClass
local static = FdfNormalBackdrop.static
---@type FdfNormalBackdropClass
local override = FdfNormalBackdrop.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param fdf_file FdfFile | nil
---@param child_instance FdfNormalBackdrop | nil
---@return FdfNormalBackdrop
function override.new(name, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfNormalBackdrop, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfNormalBackdrop)
    instance = FdfNormalBase.new(name, 'BACKDROP', fdf_file, instance)

    return instance
end

--========
-- Public
--========

function public:setFile(path)
end

--=========
-- Private
--=========

return static