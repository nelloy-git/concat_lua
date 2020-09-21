--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type FdfBackdropClass
local FdfBackdrop = require(lib_path..'Fdf.Normal.Backdrop') or error('')

--=======
-- Class
--=======

local FrameNormalImage = Class.new('FrameNormalImage', Frame)
---@class FrameNormalImage : Frame
local public = FrameNormalImage.public
---@class FrameNormalImageClass : FrameClass
local static = FrameNormalImage.static
---@type FrameNormalImageClass
local override = FrameNormalImage.override
local private = {}

--=========
-- Static
--=========

---@param child FrameNormalImage | nil
---@return FrameNormalImage
function override.new(child)
    if child then isTypeErr(child, FrameNormalImage, 'child') end

    local fdf = private.fdf
    local instance = child or Class.allocate(FrameNormalImage)
    instance = Frame.new(fdf:getName(), fdf:isSimple(), instance)

    return instance
end

---@param handle framehandle
---@param child FrameNormalImage
---@return FrameNormalImage
function override.link(handle, child)
    isTypeErr(handle, 'framehandle', 'handle')
    if child then isTypeErr(child, FrameNormalImage, 'child') end

    local instance = child or Class.allocate(FrameNormalImage)
    instance = Frame.link(handle, true, instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setTexture(tex_file, flag, blend)
    isTypeErr(tex_file, 'string', 'tex_file')
    isTypeErr(flag, 'number', 'flag')
    isTypeErr(blend, 'boolean', 'blend')
    BlzFrameSetTexture(self:getData(), tex_file, flag, blend)
end

--=========
-- Private
--=========

---@type FdfBackdrop
private.fdf = FdfBackdrop.new('FrameNormalImage')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
private.fdf:setCornerSize(0.0125)
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")

return static