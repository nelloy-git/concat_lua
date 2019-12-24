--=========
-- Include
--=========

local Utils = require('Class.Frame.FrameUtils')

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

---@param fdf_object FdfObjectRuntime
---@param instance_data table | nil
---@return Frame
function static.new(fdf_object, instance_data)
    if not instance_data then
        Log(Log.Err, getClassName(Frame), 'can not create instance of abstract class')
        return nil
    end

    local instance = instance_data

    local is_simpleframe = Utils.isSimpleFdf(fdf_object)

    local framehandle
    if is_simpleframe then
        framehandle = BlzCreateSimpleFrame(fdf_object.name, private.game_ui_frame, 0)
    else
        framehandle = BlzCreateFrameByType(fdf_object.name, fdf_object.name, private.game_ui_frame, '', 0)
    end

    private.new(instance, framehandle, is_simpleframe)
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

---@return boolean
function public:isSimpleframe()
    return private.get(self).is_simpleframe
end

--- Runs onParentChange and onPositionChange callbacks.
---@param parent Frame
function public:setParent(parent)
    local priv = private.get(self)

    if priv.is_simpleframe ~= parent:isSimpleframe() then
        local msg = ('simple and normal frames can not be parents for each other. \"setParent\" ignored.')
        Log(Log.Err, getClassName(Frame), msg)
        return nil
    end

    priv.parent = parent
    if priv.parent then
        BlzFrameSetParent(priv.wc3_frame, parent:getFramehandle())
        if not priv.follow then
            BlzFrameSetPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                             parent:getFramehandle(), FRAMEPOINT_BOTTOMLEFT,
                             priv.x, priv.y)
        end
    else
        BlzFrameSetParent(priv.wc3_frame, private.game_ui_frame)
        if not priv.follow then
            BlzFrameSetAbsPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                                priv.x, priv.y)
        end
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
    if not priv.follow then
        if priv.parent then
            BlzFrameSetPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                             priv.parent, FRAMEPOINT_BOTTOMLEFT,
                             priv.x, priv.y)
        else
            BlzFrameSetAbsPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                                priv.x, priv.y)
        end
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
    if not priv.follow then
        if priv.parent then
            BlzFrameSetPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                             priv.parent, FRAMEPOINT_BOTTOMLEFT,
                             priv.x, priv.y)
        else
            BlzFrameSetAbsPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                                priv.x, priv.y)
        end
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
    if not priv.follow then
        BlzFrameSetSize(priv.wc3_frame, priv.width, priv.height)
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
    if not priv.follow then
        BlzFrameSetSize(priv.wc3_frame, priv.width, priv.height)
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

---@param frame Frame
---@return Frame
function public:setFollowTarget(frame)
    local priv = private.get(self)

    local cur = priv.follow
    BlzFrameClearAllPoints(self:getFramehandle())

    priv.follow = frame
    if frame then
        BlzFrameSetPoint(self:getFramehandle(), FRAMEPOINT_BOTTOMLEFT,
                         frame:getFramehandle(), FRAMEPOINT_BOTTOMLEFT,
                         priv.follow_left_offset, priv.follow_bottom_offset)
        BlzFrameSetPoint(self:getFramehandle(), FRAMEPOINT_TOPLEFT,
                         frame:getFramehandle(), FRAMEPOINT_TOPLEFT,
                         priv.follow_left_offset, priv.follow_top_offset)
        BlzFrameSetPoint(self:getFramehandle(), FRAMEPOINT_TOPRIGHT,
                         frame:getFramehandle(), FRAMEPOINT_TOPRIGHT,
                         priv.follow_right_offset, priv.follow_top_offset)
        BlzFrameSetPoint(self:getFramehandle(), FRAMEPOINT_BOTTOMRIGHT,
                         frame:getFramehandle(), FRAMEPOINT_BOTTOMRIGHT,
                         priv.follow_right_offset, priv.follow_bottom_offset)

        priv.width = frame:getWidth() - (priv.follow_left_offset + priv.follow_right_offset)
        priv.height = frame:getHeight() - (priv.follow_bottom_offset + priv.follow_top_offset)
    else
        self:setParent(priv.parent)
    end

    return cur
end

---@return Frame
function public:getFollowTarget()
    return private.get(self).follow
end

function public:setFollowOffsets(left, right, top, bottom)
    local priv = private.get(self)

    priv.follow_left_offset = left
    priv.follow_right_offset = right
    priv.follow_top_offset = top
    priv.follow_bottom_offset = bottom

    self:setFollower(self:getFollower())
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
function private.new(self, framehandle, is_simpleframe)
    ---@class FramePrivate
    local priv = {
        wc3_frame = framehandle,
        is_simpleframe = is_simpleframe,

        parent = nil,
        x = 0,
        y = 0,
        width = 0,
        height = 0,
        level = 0,
        alpha = 255,
        visible = true,

        follow = nil,
        follow_left_offset = 0,
        follow_right_offset = 0,
        follow_top_offset = 0,
        follow_bottom_offset = 0,
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

    private_data[self] = nil
end

return Frame