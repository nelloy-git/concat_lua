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

--===========
-- Callbacks
--===========

function public:onParentChange() end
function public:onPositionChange() end
function public:onSizeChange() end
function public:onLevelChange() end
function public:onAlphaChange() end
function public:onVisionChange() end

--========
-- Static
--========

---@oaram framehandle FrameType
---@param instance_data table | nil
---@return Frame
function static.new(framehandle, instance_data)
    if not instance_data then
        Log(Log.Err, getClassName(Frame), 'can not create instance of abstract class')
        return nil
    end

    local instance = instance_data
    private.new(instance, framehandle)
    private.DB:set(framehandle, instance)

    return instance
end

---@param framehandle framehandle
---@return Frame
function static.get(framehandle)
    return private.DB:get(framehandle)
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

---@return framehandle
function public:getFramehandle()
    return private.get(self).wc3_frame
end

--- Runs onParentChange and onPositionChange callbacks.
---@param parent framehandle
function public:setParent(parent)
    local priv = private.get(self)

    priv.parent = parent
    if priv.parent then
        BlzFrameSetParent(priv.wc3_frame, priv.parent)
        BlzFrameSetPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                         priv.parent, FRAMEPOINT_BOTTOMLEFT,
                         priv.x, priv.y)
    else
        BlzFrameSetParent(priv.wc3_frame, private.game_ui_frame)
        BlzFrameSetAbsPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                            priv.x, priv.y)
    end

    self:onParentChange()
    self:onPositionChange()
end

---@return Frame
function public:getParent()
    return private.get(self).parent
end

---@param x number
function public:setX(x)
    local priv = private.get(self)

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
    return private.get(self).x
end

---@param y number
function public:setY(y)
    local priv = private.get(self)

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
    return private.get(self).y
end

---@param width number
function public:setWidth(width)
    local priv = private.get(self)

    priv.width = width
    BlzFrameSetSize(priv.wc3_frame, priv.width, priv.height)

    if priv.follower then
        priv.follower:setWidth(width)
    end

    self:onSizeChange()
end

---@return number
function public:getWidth()
    return private.get(self).width
end

---@param height number
function public:setHeight(height)
    local priv = private.get(self)

    priv.height = height
    BlzFrameSetSize(priv.wc3_frame, priv.width, priv.height)

    if priv.follower then
        priv.follower:setHeight(height)
    end

    self:onSizeChange()
end

---@return number
function public:getHeight()
    return private.get(self).height
end

---@param level number
function public:setLevel(level)
    local priv = private.get(self)

    priv.level = level
    BlzFrameSetLevel(priv.wc3_frame, priv.level)
    self:onLevelChange()
end

---@return number
function public:getLevel()
    return private.get(self).level
end

---@param alpha number
function public:setAlpha(alpha)
    local priv = private.get(self)

    priv.alpha = alpha
    BlzFrameSetAlpha(priv.wc3_frame, priv.alpha)
    self:onAlphaChange()
end

---@return number
function public:getAlpha()
    return private.get(self).alpha
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.get(self)

    priv.visible = flag
    BlzFrameSetVisible(priv.wc3_frame, priv.visible)
    self:onVisionChange()
end

---@return boolean
function public:isVisible()
    return private.get(self).visible
end

---@return Frame
function public:getFollower()
    return private.get(self).follower
end

---@param frame Frame
---@return Frame
function public:setFollower(frame)
    local priv = private.get(self)

    local cur = priv.follower
    cur:setParent(nil)

    priv.follower = frame
    frame:setParent(self)
    frame:setX(0)
    frame:setY(0)
    frame:setWidth(priv.width)
    frame:setHeight(priv.height)

    return cur
end

--=========
-- Private
--=========

---@type DataBase
private.DB = DataBase.new('userdata', getClassName(Frame))
if not is_compiletime then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

local private_data = {}
---@param self Frame
---@param framehandle framehandle
---@return FramePrivate
function private.new(self, framehandle)
    ---@class FramePrivate
    local priv = {
        wc3_frame = framehandle,
        parent = nil,
        x = 0,
        y = 0,
        width = 0,
        height = 0,
        level = 0,
        alpha = 255,
        visible = true,
        follower = nil
    }
    private_data[self] = priv

    return priv
end

function private.get(self)
    return private_data[self]
end

function private.free(self)
    local priv = private_data[self]
    private.DB:remove(priv.wc3_frame)
    BlzDestroyFrame(priv.wc3_frame)

    private_data[self] = nil
end

return Frame