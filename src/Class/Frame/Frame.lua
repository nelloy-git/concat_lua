--=========
-- Include
--=========

local Class = require('Utils.Class')

local DataBase = require('Class.DataBase')
local FrameType = require('Class.Frame.FrameType')

--================
-- Abstract Class
--================

---@class FrameClass
local Frame = Class.newClass('Frame')

---@class Frame
local public = Frame.public
---@type FrameClass
local static = Frame.static
---@type table
local override = Frame.override
---@type table(Frame, table)
local private = {}

--========
-- Static
--========

---@param frame_type FrameType
---@param instance_data table | nil
---@return Frame
function static.new(frame_type, instance_data)
    if not instance_data then
        Log(Log.Err, Frame, 'can not create instance of abstract class')
        return nil
    end

    local instance = instance_data
    private.new(instance, frame_type)

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
    Class.freeInstanceData(self)
end

---@return framehandle
function public:getFramehandle()
    return private.get(self).framehandle
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
        Log(Log.Err, Frame, msg)
        return nil
    end

    priv.parent = parent
    if priv.parent then
        BlzFrameSetParent(priv.framehandle, parent:getFramehandle())
        if not priv.follow then
            BlzFrameSetPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                             parent:getFramehandle(), FRAMEPOINT_BOTTOMLEFT,
                             priv.x, priv.y)
        end
    else
        BlzFrameSetParent(priv.framehandle, private.game_ui_frame)
        if not priv.follow then
            BlzFrameSetAbsPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                                priv.x, priv.y)
        end
    end
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
            BlzFrameSetPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                             priv.parent, FRAMEPOINT_BOTTOMLEFT,
                             priv.x, priv.y)
        else
            BlzFrameSetAbsPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                                priv.x, priv.y)
        end
    end
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
            BlzFrameSetPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                             priv.parent, FRAMEPOINT_BOTTOMLEFT,
                             priv.x, priv.y)
        else
            BlzFrameSetAbsPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                                priv.x, priv.y)
        end
    end
end

---@return number
function public:getY()
    return private.get(self).y
end

---@param width number
function public:setWidth(width)
    local priv = private.get(self)

    priv.width = width
    BlzFrameSetSize(priv.framehandle, priv.width, priv.height)
end

---@return number
function public:getWidth()
    return private.get(self).width
end

---@param height number
function public:setHeight(height)
    local priv = private.get(self)

    priv.height = height
    BlzFrameSetSize(priv.framehandle, priv.width, priv.height)
end

---@return number
function public:getHeight()
    return private.get(self).height
end

---@param level number
function public:setLevel(level)
    local priv = private.get(self)

    priv.level = level
    BlzFrameSetLevel(priv.framehandle, priv.level)
end

---@return number
function public:getLevel()
    return private.get(self).level
end

---@param alpha number
function public:setAlpha(alpha)
    local priv = private.get(self)

    priv.alpha = alpha
    BlzFrameSetAlpha(priv.framehandle, priv.alpha)
end

---@return number
function public:getAlpha()
    return private.get(self).alpha
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.get(self)

    priv.visible = flag
    BlzFrameSetVisible(priv.framehandle, priv.visible)
end

---@return boolean
function public:isVisible()
    return private.get(self).visible
end

--- While following setX, setY are ignored.
---@param frame Frame
---@return Frame
function public:setFollowTarget(frame)
    local priv = private.get(self)

    local cur = priv.follow
    BlzFrameClearAllPoints(self:getFramehandle())

    priv.follow = frame
    if frame then
        BlzFrameSetPoint(self:getFramehandle(), FRAMEPOINT_CENTER,
                         frame:getFramehandle(), FRAMEPOINT_CENTER,
                         priv.follow_left_offset, priv.follow_bottom_offset)
    else
        self:setParent(priv.parent)
    end

    return cur
end

---@return Frame
function public:getFollowTarget()
    return private.get(self).follow
end

function public:setFollowOffsets(x, y)
    local priv = private.get(self)

    priv.follow_x_offset = x
    priv.follow_y_offset = y

    self:setFollower(self:getFollower())
end

--=========
-- Private
--=========

---@type DataBase
private.DB = DataBase.new('userdata', Frame)
if not is_compiletime then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

local private_data = {}
---@param self Frame
---@param frame_type FrameType
---@return FramePrivate
function private.new(self, frame_type)
    local framehandle
    if frame_type:isSimple() then
        framehandle = BlzCreateSimpleFrame(frame_type:getName(), private.game_ui_frame, 0)
    else
        framehandle = BlzCreateFrameByType(frame_type:getName(), frame_type:getName(), private.game_ui_frame, '', 0)
    end

    ---@class FramePrivate
    local priv = {
        framehandle = framehandle,
        is_simpleframe = frame_type:isSimple(),

        parent = nil,
        x = 0,
        y = 0,
        width = 0,
        height = 0,
        level = 0,
        alpha = 255,
        visible = true,

        follow = nil,
        follow_x_offset = 0,
        follow_y_offset = 0,
    }
    private_data[self] = priv
    private.DB:set(framehandle, self)

    return priv
end

function private.get(self)
    return private_data[self]
end

function private.free(self)
    local priv = private_data[self]
    BlzDestroyFrame(priv.framehandle)
    private.DB:remove(priv.framehandle)

    private_data[self] = nil
end

return Frame