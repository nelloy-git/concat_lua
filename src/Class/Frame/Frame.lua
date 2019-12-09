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
if not is_compiletime then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

--===========
-- Callbacks
--===========

function public:onParentChange() end
function public:onPositionChange() end
function public:onSizeChange() end
function public:onLevelChange() end
function public:onAlphaChange() end
function public:onVisionChange() end

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

---@return framehandle
function public:getWc3Frame()
    return private[self].wc3_frame
end

--- Runs onParentChange and onPositionChange callbacks.
---@param parent framehandle
function public:setParent(parent)
    local priv = private[self]

    priv.parent = parent
    if priv.parent then
        BlzFrameSetParent(priv.wc3_frame, priv.parent)
    else
        BlzFrameSetParent(priv.wc3_frame, private.game_ui_frame)
    end
    self:onParentChange()
    self:onPositionChange()
end

---@return Frame
function public:getParent()
    return private[self].parent
end

---@param x number
function public:setX(x)
    local priv = private[self]

    priv.x = x
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

---@return number
function public:getX()
    return private[self].x
end

---@param y number
function public:setY(y)
    local priv = private[self]

    priv.y = y
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

---@return number
function public:getY()
    return private[self].y
end

---@param width number
function public:setWidth(width)
    local priv = private[self]

    priv.width = width
    BlzFrameSetSize(priv.wc3_frame, priv.width, priv.height)
    self:onSizeChange()
end

---@return number
function public:getWidth()
    return private[self].width
end

---@param height number
function public:setHeight(height)
    local priv = private[self]

    priv.height = height
    BlzFrameSetSize(priv.wc3_frame, priv.width, priv.height)
    self:onSizeChange()
end

---@return number
function public:getHeight()
    return private[self].height
end

---@param level number
function public:setLevel(level)
    local priv = private[self]

    priv.level = level
    BlzFrameSetLevel(priv.wc3_frame, priv.level)
    self:onLevelChange()
end

---@return number
function public:getLevel()
    return private[self].level
end

---@param alpha number
function public:setAlpha(alpha)
    local priv = private[self]

    priv.alpha = alpha
    BlzFrameSetAlpha(priv.wc3_frame, priv.alpha)
    self:onAlphaChange()
end

---@return number
function public:getAlpha()
    return private[self].alpha
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private[self]

    priv.visible = flag
    BlzFrameSetVisible(priv.wc3_frame, priv.visible)
    self:onVisionChange()
end

---@return boolean
function public:isVisible()
    return private[self].visible
end

return Frame