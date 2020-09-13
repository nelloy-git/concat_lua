--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

--=======
-- Class
--=======

local Frame = Class.new('Frame', Handle)
---@class Frame : Handle
local public = Frame.public
---@class FrameClass : HandleClass
local static = Frame.static
---@type FrameClass
local override = Frame.override
local private = {}

--=========
-- Static
--=========

---@param handle framehandle
---@param is_simple boolean
---@param child Frame | nil
---@return Frame
function override.new(handle, is_simple, child)
    isTypeErr(handle, 'framehandle', 'handle')
    if child then isTypeErr(child, Frame, 'child') end

    local instance = child or Class.allocate(Frame)
    instance = Handle.new(handle, BlzDestroyFrame, instance)
    private.newData(instance, is_simple)

    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
function public:setPos(x, y)
    local priv = private.data[self]

    priv.x = x
    priv.y = y

    local handle = self:getData()
    if priv.parent then
        BlzFrameSetPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                         priv.parent:getData(), FRAMEPOINT_BOTTOMLEFT,
                         x, y)
    else
        BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                            x, y)
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

---@return number
function public:getAbsX()
    local priv = private.data[self]

    local parent = priv.parent
    local parent_x = parent and parent:getAbsX() or 0
    local self_x = priv.x

    return self_x + parent_x
end

---@return number
function public:getAbsY()
    local priv = private.data[self]

    local parent = priv.parent
    local parent_y = parent and parent:getAbsY() or 0
    local self_y = priv.y

    return self_y + parent_y
end

---@param width number
---@param height number
function public:setSize(width, height)
    local priv = private.data[self]

    priv.width = width
    priv.height = height
    BlzFrameSetSize(self:getData(), width, height)
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
end

---@return boolean
function public:isSimple()
    return private.data[self].is_simple
end

---@return framehandle | nil
function public:getParent()
    return private.data[self].parent
end

--- User must check frame and parent are both simple or they are both normal.
---@param parent Frame | nil
function public:setParent(parent)
    local priv = private.data[self]
    priv.parent = parent

    local handle = self:getData()
    local parent_handle

    if priv.is_simple then
        -- Simple frame
        if parent and not parent:isSimple() then
            Log:err('Normal frame can not be a parent of simple frame.', 2)
        end
        parent_handle = parent and parent:getData() or nil
    else
        -- Normal frame
        if parent and parent:isSimple() then
            Log:err('Simple frame can not be a parent of normal frame.', 2)
        end
        parent_handle = parent and parent:getData() or private.console_ui_backdrop
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
    BlzFrameSetLevel(self:getData(), level)
end

function public:getAlpha()
    return private.data[self].alpha
end

---@param alpha number
function public:setAlpha(alpha)
    private.data[self].alpha = alpha
    BlzFrameSetAlpha(self:getData(), alpha)
end

---@return boolean
function public:isVisible()
    return BlzFrameIsVisible(self:getData())
end

---@param visible boolean
function public:setVisible(visible)
    BlzFrameSetVisible(self:getData(), visible)
end

---@return Frame | nil
function public:getTooltip()
    return private.data[self].tooltip
end

---@param tooltip Frame | nil
function public:setTooltip(tooltip)
    local priv = private.data[self]

    if priv.is_simple then
        -- Simple frame
        if tooltip and not tooltip:isSimple() then
            Log:err('Normal frame can not be a tooltip for simple frame.', 2)
        end
    else
        -- Normal frame
        if tooltip and tooltip:isSimple() then
            Log:err('Simple frame can not be a parent of normal frame.', 2)
        end
    end
    local tooltip_handle = tooltip and tooltip:getData() or nil

    priv.tooltip = tooltip
    BlzFrameSetTooltip(self:getData(), tooltip_handle)
    tooltip:setVisible(false)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Frame
---@param is_simple boolean
function private.newData(self, is_simple)
    local handle = self:getData()
    local priv = {
        is_simple = is_simple,

        x = 0,
        y = 0,
        width = BlzFrameGetWidth(handle),
        height = BlzFrameGetHeight(handle),
        tooltip = nil,

        level = 0,
        alpha = 0,
    }
    private.data[self] = priv
end

if not IsCompiletime() then
    private.console_ui_backdrop = BlzGetFrameByName("ConsoleUIBackdrop", 0)
    BlzFrameClearAllPoints(private.console_ui_backdrop)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_TOPLEFT, 0, 0)
    BlzFrameSetAbsPoint(private.console_ui_backdrop, FRAMEPOINT_TOPRIGHT, 0, 0)
end

return static