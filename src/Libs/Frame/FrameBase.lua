--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Action
local Log = UtilsLib.DefaultLogger
local checkType = UtilsLib.Functions.checkType
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Handle = UtilsLib.Handle.Base
local Timer = UtilsLib.Handle.Timer

---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.Fdf.Frame')
---@type FrameScreen
local Screen = require(lib_modname..'.Screen')

--=======
-- Class
--=======

local FrameBase = Class.new('FrameBase', Handle)
---@class FrameBase : Handle
local public = FrameBase.public
---@class FrameBaseClass : HandleClass
local static = FrameBase.static
---@type FrameBaseClass
local override = FrameBase.override
local private = {}

--=========
-- Static
--=========

---@param handle framehandle
---@param fdf FdfFrame | nil
---@param child_instance FrameBase | nil
---@return FrameBase
function override.new(handle, fdf, child_instance)
    checkTypeErr(handle, 'framehandle', 'handle')
    if child_instance then checkTypeErr(child_instance, FrameBase, 'child_instance') end

    local instance = child_instance or Class.allocate(FrameBase)
    instance = Handle.new(handle, BlzDestroyFrame, instance)
    private.newData(instance, fdf)

    return instance
end

--========
-- Public
--========

---@return FdfFrame | nil
function public:getFdf()
    return private.data[self].fdf
end

---@param x number
---@param y number
function public:setPos(x, y)
    local priv = private.data[self]

    priv.x = x
    priv.y = y

    local handle = self:getHandleData()
    if priv.parent then
        BlzFrameSetPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                         priv.parent:getHandleData(), FRAMEPOINT_BOTTOMLEFT,
                         x, y)
    else
        BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                            Screen.getX0() + x, y)
    end
end

--- Returns x offset from parent.
---@return number
function public:getX()
    return private.data[self].x
end

--- Returns y offset from parent.
function public:getY()
    return private.data[self].y
end

---@param width number
---@param height number
function public:setSize(width, height)
    local priv = private.data[self]

    priv.width = width
    priv.height = height
    BlzFrameSetSize(self:getHandleData(), width, height)
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
end

---@return framehandle | nil
function public:getParent()
    return private.data[self].parent
end

--- User must check frame and parent are both simple or they are both normal.
---@param parent FrameBase | nil
function public:setParent(parent)
    local priv = private.data[self]

    priv.parent = parent

    local handle = self:getHandleData()
    local parent_handle
    if parent then
        parent_handle = parent:getHandleData()
    end
    BlzFrameSetParent(handle, parent_handle)
end

function public:getLevel()
    return private.data[self].level
end

---@param level number
function public:setLevel(level)
    local priv = private.data[self]

    priv.level = level
    BlzFrameSetLevel(self:getHandleData(), level)
end

function public:getAlpha()
    return private.data[self].alpha
end

---@param alpha number
function public:setAlpha(alpha)
    private.data[self].alpha = alpha
    BlzFrameSetAlpha(self:getHandleData(), alpha)
end

function public:getVisible()
    return BlzFrameIsVisible(self:getHandleData())
end

---@param visible boolean
function public:setVisible(visible)
    BlzFrameSetVisible(self:getHandleData(), visible)
end

---@return FrameBase | nil
function public:getTooltip()
    return private.data[self].tooltip
end

---@param tooltip FrameBase | nil
function public:setTooltip(tooltip)
    private.data[self].tooltip = tooltip
    BlzFrameSetTooltip(self:getHandleData(), tooltip:getHandleData())
    tooltip:setVisible(false)
end

---@param name string
function public:getSubframe(name)
    return private.data[self].subframes[name]
end

--- Sets class for subframe.
---@param name string
---@param class FrameBaseClass
function public:setSubframeClass(name, class)
    checkTypeErr(class, FrameBase, 'class')

    local subframe = private.data[self].subframes[name]
    if not checkType(subframe, FrameBase) then
        Log:err(tostring(self)..': can not find subframe \"'..name..'\".', 2)
    end

    local subfame_handle = subframe:getHandleData()
    subframe:destroy() -- was created with framehandle so destroy() wont remove handle data.
    subframe = class.new(subfame_handle)
    private.data[self].subframes[name] = subframe
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FrameBase
---@param fdf FdfFrame
function private.newData(self, fdf)
    local handle = self:getHandleData()
    local priv = {
        fdf = fdf,

        x = 0,
        y = 0,
        width = BlzFrameGetWidth(handle),
        height = BlzFrameGetHeight(handle),
        tooltip = nil,
        parent = Handle.getLinked(BlzFrameGetParent(handle)),

        level = 0,
        alpha = 0,

        subframes = {}
    }
    private.data[self] = priv

    -- Creates FrameBase instances for subframes. Subframe class can be changed with public:setSubframeClass.
    if fdf then
        for name, subframe in pairs(fdf:getAllSubframes()) do
            checkTypeErr(subframe, FdfFrame, 'fdf_subframes['..name..']')
            priv.subframes[name] = static.new(BlzGetFrameByName(fdf:getName(), subframe, 0))
        end
    end
end

return static