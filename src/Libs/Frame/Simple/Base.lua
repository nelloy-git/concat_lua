--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Log = UtilsLib.DefaultLogger
local checkType = UtilsLib.Functions.checkType
local checkTypeErr = UtilsLib.Functions.checkTypeErr

---@type FdfSimpleBaseClass
local FdfSimpleBase = require(lib_modname..'.Fdf.Frame.SimpleBase')

---@type FrameBaseClass
local FrameBase = require(lib_modname..'.FrameBase')
local FrameBasePublic = Class.getPublic(FrameBase)

--=======
-- Class
--=======

local FrameSimpleBase = Class.new('FrameSimpleBase', FrameBase)
---@class FrameSimpleBase : FrameBase
local public = FrameSimpleBase.public
---@class FrameSimpleBaseClass : FrameBaseClass
local static = FrameSimpleBase.static
---@type FrameSimpleBaseClass
local override = FrameSimpleBase.override
local private = {}

--=========
-- Static
--=========

---@param fdf_frame FdfFrame
---@param child_instance FrameSimpleBase | nil
---@return FrameSimpleBase
---@overload fun(frame_handle:framehandle, child_instance:FrameBase) : FrameSimpleBase
function override.new(fdf_frame, child_instance)
    if not (checkType(fdf_frame, 'framehandle') or checkType(fdf_frame, FdfSimpleBase)) then
        Log:err('variable \'fdf_frame\'('..tostring(fdf_frame)..') is not of type framehandle or '..tostring(FdfSimpleBase), 2)
    end
    if child_instance then checkTypeErr(child_instance, FrameSimpleBase, 'child_instance') end

    local instance = child_instance or Class.allocate(FrameSimpleBase)
    instance = FrameBase.new(fdf_frame, instance)

    return instance
end

--========
-- Public
--========

---@param parent FrameSimpleBase | nil
function public:setParent(parent)
    if parent then checkTypeErr(parent, FrameSimpleBase, 'parent') end
    FrameBasePublic.setParent(self, parent)
end

function public:setTooltip(tooltip)
    if tooltip then checkTypeErr(tooltip, FrameSimpleBase, 'tooltip') end
    FrameBasePublic.setTooltip(self, tooltip)
end

--=========
-- Private
--=========

return static