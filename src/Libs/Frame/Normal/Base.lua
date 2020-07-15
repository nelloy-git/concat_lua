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

---@type FdfNormalBaseClass
local FdfNormalBase = require(lib_modname..'.Fdf.Frame.NormalBase')

---@type FrameBaseClass
local FrameBase = require(lib_modname..'.FrameBase')
local FrameBasePublic = Class.getPublic(FrameBase)

--=======
-- Class
--=======

local FrameNormalBase = Class.new('FrameNormalBase', FrameBase)
---@class FrameNormalBase : FrameBase
local public = FrameNormalBase.public
---@class FrameNormalBaseClass : FrameBaseClass
local static = FrameNormalBase.static
---@type FrameNormalBaseClass
local override = FrameNormalBase.override
local private = {}

--=========
-- Static
--=========

---@param fdf_or_handle FdfNormalBase | framehandle
---@param child_instance FrameNormalBase | nil
---@return FrameNormalBase
function override.new(fdf_or_handle, child_instance)
    local fdf
    local handle
    if checkType(fdf_or_handle, 'framehandle') then
        fdf = nil
        handle = fdf_or_handle
    elseif checkType(fdf_or_handle, FdfNormalBase)  then
        fdf = fdf_or_handle
        handle = BlzCreateFrame(fdf:getName(), private.console_ui_backdrop, 0, 0)
    else
        Log:err('variable \'fdf_frame\'('..tostring(fdf_or_handle)..') is not of type framehandle or '..tostring(FdfNormalBase), 2)
    end
    if child_instance then checkTypeErr(child_instance, FrameNormalBase, 'child_instance') end

    local instance = child_instance or Class.allocate(FrameNormalBase)
    instance = FrameBase.new(handle, fdf, instance)

    return instance
end

--========
-- Public
--========

---@param parent FrameNormalBase | nil
function public:setParent(parent)
    if parent then
        checkTypeErr(parent, FrameNormalBase, 'parent')
    else
        parent = private.full_screen_parent
    end

    FrameBasePublic.setParent(self, parent)
end

---@param tooltip FrameNormalBase | nil
function public:setTooltip(tooltip)
    if tooltip then checkTypeErr(tooltip, FrameNormalBase, 'tooltip') end
    FrameBasePublic.setTooltip(self, tooltip)
end

--=========
-- Private
--=========

if not IsCompiletime() then
    private.console_ui_backdrop = BlzGetFrameByName("ConsoleUIBackdrop", 0)
    BlzFrameClearAllPoints(private.console_ui_backdrop)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_TOPLEFT, 0, 0)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_TOPRIGHT, 0, 0)
    private.full_screen_parent = static.new(private.console_ui_backdrop)
end

return static