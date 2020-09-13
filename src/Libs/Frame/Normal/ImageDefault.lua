--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_deplass

---@type FrameNormalImageClass
local FrameNormalImage = require(lib_path..'.Normal.Image')
---@type FdfNormalBackdropClass
local FdfNormalBackdrop = require(lib_path..'.Fdf.Frame.NormalBackdrop')

--=======
-- Class
--=======

local FrameNormalImageDefault = Class.new('FrameNormalImageDefault', FrameNormalImage)
---@class FrameNormalImageDefault : FrameNormalButton
local public = FrameNormalImageDefault.public
---@class FrameNormalImageDefaultClass : FrameNormalButtonClass
local static = FrameNormalImageDefault.static
---@type FrameNormalImageDefaultClass
local override = FrameNormalImageDefault.override
local private = {}

--=========
-- Static
--=========

---@return FrameNormalImageDefault
function override.new()
    local instance = Class.allocate(FrameNormalImageDefault)
    instance = FrameNormalImage.new(private.fdf, instance)

    return instance
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf_name = 'FrameNormalImageDefault'
private.icon = "ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp"

---@type FdfNormalBackdrop
private.fdf = FdfNormalBackdrop.new(private.fdf_name)
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setBackground("ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp")
private.fdf:setCornerFlags("UL|UR|BL|BR|T|L|B|R")
private.fdf:setCornerSize(0.0125)
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setEdgeFile("UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp")

return static