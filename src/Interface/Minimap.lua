--=========
-- Include
--=========

local Class = require(LibList.ClassLib)
---@type FrameLib
local FrameLib = require(LibList.FrameLib)
local FrameNormalBase = FrameLib.Frame.Normal.Base
local FrameNormalBasePublic = Class.getPublic(FrameNormalBase)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local Log = UtilsLib.Log

--=======
-- Class
--=======

local InterfaceMinimap = Class.new('InterfaceMinimap', FrameNormalBase)
---@class InterfaceMinimap : FrameNormalBase
local public = InterfaceMinimap.public
---@class InterfaceMinimapClass : FrameNormalBaseClass
local static = InterfaceMinimap.static
---@type InterfaceMinimapClass
local override = InterfaceMinimap.override
local private = {}

--=========
-- Static
--=========

local static_instance = nil

---@return InterfaceMinimap
function override.new()
    if static_instance then
        Log:wrn('It is static class.')
        return static_instance
    end

    local instance = Class.allocate(InterfaceMinimap)
    instance = FrameNormalBase.new(private.fdf, instance)

    private.newData(instance)

    static_instance = instance
    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    local priv = private.data[self]
    FrameNormalBasePublic.setPos(self, x, y)

    priv.minimap:setPos(self:getAbsX() + 0.05 * self:getHeight(),
                        self:getAbsY() + 0.05 * self:getHeight())
end

---@param w number
---@param h number
function public:setSize(w, h)
    local priv = private.data[self]
    FrameNormalBasePublic.setSize(self, w, h)

    priv.minimap:setSize(0.9 * h, 0.9 * h)
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]
    FrameNormalBasePublic.setVisible(self, flag)

    priv.minimap:setVisible(flag)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceMinimap
function private.newData(self)
    local priv = {
        minimap = FrameLib.Origin.Minimap,
    }
    private.data[self] = priv
end

private.fdf = FrameLib.Fdf.Normal.Backdrop.new('InterfaceMinimapBorder')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setBackgroundTileMode(true)
private.fdf:setBackgroundTileSize(0.2)
private.fdf:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf:setBlendAll(true)
private.fdf:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf:setCornerSize(0.0125)
private.fdf:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

return static