--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_modname..'.Normal.Base')
---@type FdfNormalBackdropClass
local FdfNormalBackdrop = require(lib_modname..'.Fdf.Frame.NormalBackdrop')

--=======
-- Class
--=======

local FrameNormalButton = Class.new('FrameNormalButton', FrameNormalBase)
---@class FrameNormalButton : FrameNormalBase
local public = FrameNormalButton.public
---@class FrameNormalButtonClass : FrameNormalBaseClass
local static = FrameNormalButton.static
---@type FrameNormalButtonClass
local override = FrameNormalButton.override
local private = {}

--=========
-- Static
--=========

---@param fdf_or_handle FdfNormalBackdrop | framehandle
---@param child_instance FrameNormalButton | nil
---@return FrameNormalButton
function override.new(fdf_or_handle, child_instance)
    fdf_or_handle = fdf_or_handle or private.fdf
    if not (checkType(fdf_or_handle, 'framehandle') or checkType(fdf_or_handle, FdfNormalBackdrop)) then
        Log:err('variable \'fdf_frame\'('..tostring(fdf_or_handle)..') is not of type framehandle or '..tostring(FdfNormalBackdrop), 2)
    end
    if child_instance then checkTypeErr(child_instance, FrameNormalBase, 'child_instance') end

    local instance = child_instance or Class.allocate(FrameNormalButton)
    instance = FrameNormalBase.new(fdf_or_handle, instance)

    return instance
end

--========
-- Public
--========


--=========
-- Private
--=========

private.fdf_name = 'FrameNormalButton'
private.fdf_texture_name = 'FrameNormalButtonTexture'

private.fdf = FdfNormalBackdrop.new(private.fdf_name)
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setBackground("ReplaceableTextures\\\\CommandButtons\\\\BTNAcidBomb.blp")
private.fdf:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
private.fdf:setCornerSize(0.0125)
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")

return static