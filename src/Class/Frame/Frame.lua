--=========
-- Include
--=========

---@type DataBaseClass
local DataBase = require('Class.DataBase')

--================
-- Abstract Class
--================

---@type FrameClass
local Frame = newClass('Frame')

---@class FrameClass
local static = Frame.static
---@class Frame
local public = Frame.public
---@type table
local override = Frame.override
---@type table(Frame, table)
local private = {}

private.DB = DataBase.new('userdata', getClassName(Frame))

--=========
-- Methods
--=========

---@oaram framehandle FrameType
---@param instance_data table | nil
---@return Frame
function static.new(framehandle, instance_data)
    if not instance_data then
        Log(Log.Err, getClassName(Frame), 'can not create instance of abstract class')
        return nil
    end

    local instance = instance_data
    local priv = {
        wc3_frame = framehandle,
        parent = nil,
        x = 0,
        y = 0,
        width = 0,
        height = 0,
        level = 0,
        alpha = 255,
        visible = true
    }
    private[instance] = priv
    private.DB:set(framehandle, instance)

    instance:update()

    return instance
end

---@param framehandle framehandle
---@return Frame
function static.get(framehandle)
    return private.DB:get(framehandle)
end

function public:free()
    local priv = private[self]
    private.DB:remove(priv.wc3_frame)
    BlzDestroyFrame(priv.wc3_frame)

    private[self] = nil
    freeInstanceData(self)
end

function public:onParentChange()
    local priv = private[self]

    if priv.parent then
        BlzFrameSetPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                         priv.parent, FRAMEPOINT_BOTTOMLEFT,
                         priv.x, priv.y)
    else
        BlzFrameSetAbsPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                            priv.x, priv.y)
    end
    self:onPositionChange()
end

function public:onPositionChange()
    local priv = private[self]

    if priv.parent then
        BlzFrameSetPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                         priv.parent, FRAMEPOINT_BOTTOMLEFT,
                         priv.x, priv.y)
    else
        BlzFrameSetAbsPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                            priv.x, priv.y)
    end
end

function public:onSizeChange()
    local priv = private[self]
    BlzFrameSetSize(priv.wc3_frame, priv.width, priv.heigth)
end

function public:onLevelChange()
    local priv = private[self]
    BlzFrameSetLevel(priv.wc3_frame, priv.level)
end

function public:onAlphaChange()
    local priv = private[self]
    BlzFrameSetAlpha(priv.wc3_frame, priv.alpha)
end

function public:onVisionChange()
    local priv = private[self]
    BlzFrameSetVisible(priv.wc3_frame, priv.visible)
end

---@return framehandle
function public:getWc3Frame()
    return private[self].wc3_frame
end

---@param parent framehandle
function public:setParent(parent)
    private[self].parent = parent
    self:onParentChange()
end

---@return Frame
function public:getParent()
    return private[self].parent
end

---@param x number
function public:setX(x)
    private[self].x = x
    self:onPositionChange()
end

---@return number
function public:getX()
    return private[self].x
end

---@param y number
function public:setY(y)
    private[self].y = y
    self:onPositionChange()
end

---@return number
function public:getY()
    return private[self].y
end

---@param width number
function public:setWidth(width)
    private[self].width = width
    self:onSizeChange()
end

---@return number
function public:getWidth()
    return private[self].width
end

---@param height number
function public:setHeight(height)
    private[self].height = height
    self:onSizeChange()
end

---@reutrn number
function public:getHeight()
    return private[self].height
end

---@param level number
function public:setLevel(level)
    private[self].level = level
    self:onLevelChange()
end

---@return number
function public:getLevel()
    return private[self].level
end

---@param alpha number
function public:setAlpha(alpha)
    private[self].alpha = alpha
    self:onAlphaChange()
end

---@return number
function public:getAlpha()
    return private[self].alpha
end

---@param flag boolean
function public:setVisible(flag)
    private[self].visible = flag
    self:onVisionChange()
end

---@return boolean
function public:isVisible()
    return private[self].visible
end

return Frame