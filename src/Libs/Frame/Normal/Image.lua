--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_deplass
---@type UtilsLib
local UtilsLib = lib_deptilsLib
local checkType = UtilsLib.Functions.checkType
local isTypeErr = UtilsLib.isTypeErr
local Log = UtilsLib.Log

---@type FrameNormalBaseClass
local FrameNormalBase = require(lib_path..'.Normal.Base')
---@type FdfNormalBackdropClass
local FdfNormalBackdrop = require(lib_path..'.Fdf.Frame.NormalBackdrop')

--=======
-- Class
--=======

local FrameNormalImage = Class.new('FrameNormalImage', FrameNormalBase)
---@class FrameNormalImage : FrameNormalBase
local public = FrameNormalImage.public
---@class FrameNormalImageClass : FrameNormalBaseClass
local static = FrameNormalImage.static
---@type FrameNormalImageClass
local override = FrameNormalImage.override
local private = {}

--=========
-- Static
--=========

---@param fdf_or_handle FdfNormalBackdrop | framehandle
---@param child FrameNormalImage | nil
---@return FrameNormalImage
function override.new(fdf_or_handle, child)
    fdf_or_handle = fdf_or_handle or private.fdf
    if not (checkType(fdf_or_handle, 'framehandle') or checkType(fdf_or_handle, FdfNormalBackdrop)) then
        Log:err('variable \'fdf_frame\'('..tostring(fdf_or_handle)..') is not of type framehandle or '..tostring(FdfNormalBackdrop), 2)
    end
    if child then isTypeErr(child, FrameNormalBase, 'child') end

    local instance = child or Class.allocate(FrameNormalImage)
    instance = FrameNormalBase.new(fdf_or_handle, instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setTexture(tex_file, flag, blend)
    BlzFrameSetTexture(self:getData(), tex_file, flag, blend)
end

--=========
-- Private
--=========

return static