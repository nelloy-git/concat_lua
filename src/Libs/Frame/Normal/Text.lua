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
---@type FdfNormalTextClass
local FdfNormalText = require(lib_path..'.Fdf.Frame.NormalText')

--=======
-- Class
--=======

local FrameNormalText = Class.new('FrameNormalText', FrameNormalBase)
---@class FrameNormalText : FrameNormalBase
local public = FrameNormalText.public
---@class FrameNormalTextClass : FrameNormalBaseClass
local static = FrameNormalText.static
---@type FrameNormalTextClass
local override = FrameNormalText.override
local private = {}

--=========
-- Static
--=========

---@param fdf_or_handle FdfNormalText | framehandle
---@param child FrameNormalText | nil
---@return FrameNormalText
function override.new(fdf_or_handle, child)
    fdf_or_handle = fdf_or_handle or private.fdf
    if not (checkType(fdf_or_handle, 'framehandle') or checkType(fdf_or_handle, FdfNormalText)) then
        Log:err('variable \'fdf_frame\'('..tostring(fdf_or_handle)..') is not of type framehandle or '..tostring(FdfNormalText), 2)
    end
    if child then isTypeErr(child, FrameNormalBase, 'child') end

    local instance = child or Class.allocate(FrameNormalText)
    instance = FrameNormalBase.new(fdf_or_handle, instance)

    return instance
end

--========
-- Public
--========

---@param text string
function public:setText(text)
    BlzFrameSetText(self:getData(), text)
end

--=========
-- Private
--=========

private.fdf_name = 'FrameNormalTextDefault'

private.fdf = FdfNormalText.new(private.fdf_name)
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setFont('fonts\\nim_____.ttf', 0.008)
private.fdf:setJustification('JUSTIFYCENTER', 'JUSTIFYMIDDLE')

return static