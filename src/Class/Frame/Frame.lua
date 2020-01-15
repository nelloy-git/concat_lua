--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type FrameTypeClass
local FrameType = require('Class.Frame.FrameType')

--================
-- Abstract Class
--================

local Frame = Class.new('Frame')
---@class Frame
local public = Frame.public
---@class FrameClass
local static = Frame.static
local override = Frame.override
local private = {}

--========
-- Static
--========

---@param frame_type FrameType
---@param child_data any
---@return Frame
function static.new(frame_type, child_data)
    if not child_data then
        Log(Log.Err, Frame, 'can not create instance of abstract class')
        return nil
    end
    local instance = child_data or Class.allocate(Frame, child_data)
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

---@return framehandle
function public:getFramehandle()
    return private.get(self).framehandle
end

---@return boolean
function public:isSimpleframe()
    return private.get(self).is_simpleframe
end

---@param parent Frame
function public:setParent(parent)
    local priv = private.get(self)

    if priv.is_simpleframe ~= parent:isSimpleframe() then
        local msg = ('simple and normal frames can not be parents for each other. \"setParent\" ignored.')
        Log(Log.Wrn, Frame, msg)
    else
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
end

---@return Frame | nil
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
function public:setFollowTarget(frame)
    local priv = private.get(self)

    BlzFrameClearAllPoints(self:getFramehandle())

    priv.follow = frame
    if frame then
        BlzFrameSetPoint(self:getFramehandle(), FRAMEPOINT_CENTER,
                         frame:getFramehandle(), FRAMEPOINT_CENTER,
                         priv.follow_left_offset, priv.follow_bottom_offset)
    else
        self:setParent(priv.parent)
    end
end

---@return Frame
function public:getFollowTarget()
    return private.get(self).follow
end

---@param x number
---@param y number
function public:setFollowOffsets(x, y)
    local priv = private.get(self)

    priv.follow_x_offset = x
    priv.follow_y_offset = y

    self:setFollowTarget(self:getFollowTarget())
end

function public:free()
    private.free(self)
    Class.freeInstanceData(self)
end

--=========
-- Private
--=========

local private_data = {}

private.DB = DataBase.new('userdata', Frame)
if not IsCompiletime() then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

---@param self Frame
---@param frame_type FrameType
---@return table
function private.new(self, frame_type)
    local framehandle
    if frame_type:isSimple() then
        framehandle = BlzCreateSimpleFrame(frame_type:getName(), private.game_ui_frame, 0)
    else
        framehandle = BlzCreateFrameByType(frame_type:getName(), frame_type:getName(), private.game_ui_frame, '', 0)
    end

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

---@param self Frame
---@return table
function private.get(self)
    return private_data[self]
end

---@param self Frame
function private.free(self)
    local priv = private_data[self]
    BlzDestroyFrame(priv.framehandle)
    private.DB:remove(priv.framehandle)

    private_data[self] = nil
end

return Frame