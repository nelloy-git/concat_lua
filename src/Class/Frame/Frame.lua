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
        return
    end
    local instance = child_data or Class.allocate(Frame, child_data)
    private.newData(instance, frame_type)

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
    return private[self].framehandle
end

---@return boolean
function public:isSimpleframe()
    return private[self].is_simpleframe
end

---@param parent Frame
function public:setParent(parent)
    local priv = private[self]

    if priv.is_simpleframe ~= parent:isSimpleframe() then
        Log.error(Frame, 'simple and normal frames can not be parents for each other. \"setParent\" ignored.', 2)
    else
        priv.parent = parent
        local parent_frame = private.game_ui_frame
        if parent then
            parent_frame = parent:getFramehandle()
        end
        BlzFrameSetParent(priv.framehandle, parent_frame)
        if not priv.follow then
            BlzFrameSetPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                            parent_frame, FRAMEPOINT_BOTTOMLEFT,
                            priv.x, priv.y)
        end
    end
end

---@return Frame | nil
function public:getParent()
    return private[self].parent
end

---@param x number
function public:setX(x)
    local priv = private[self]

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
    return private[self].x
end

---@param y number
function public:setY(y)
    local priv = private[self]

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
    return private[self].y
end

---@param width number
function public:setWidth(width)
    local priv = private[self]

    priv.width = width
    BlzFrameSetSize(priv.framehandle, priv.width, priv.height)
end

---@return number
function public:getWidth()
    return private[self].width
end

---@param height number
function public:setHeight(height)
    local priv = private[self]

    priv.height = height
    BlzFrameSetSize(priv.framehandle, priv.width, priv.height)
end

---@return number
function public:getHeight()
    return private[self].height
end

---@param level number
function public:setLevel(level)
    local priv = private[self]

    priv.level = level
    BlzFrameSetLevel(priv.framehandle, priv.level)
end

---@return number
function public:getLevel()
    return private[self].level
end

---@param alpha number
function public:setAlpha(alpha)
    local priv = private[self]

    priv.alpha = alpha
    BlzFrameSetAlpha(priv.framehandle, priv.alpha)
end

---@return number
function public:getAlpha()
    return private[self].alpha
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private[self]

    priv.visible = flag
    BlzFrameSetVisible(priv.framehandle, priv.visible)
end

---@return boolean
function public:isVisible()
    return private[self].visible
end

--- While following setX, setY are ignored.
---@param frame Frame
function public:setFollowTarget(frame)
    local priv = private[self]

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
    return private[self].follow
end

---@param x number
---@param y number
function public:setFollowOffsets(x, y)
    local priv = private[self]

    priv.follow_x_offset = x
    priv.follow_y_offset = y

    self:setFollowTarget(self:getFollowTarget())
end

function public:free()
    private.freeData(self)
    Class.free(self)
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
function private.newData(self, frame_type)
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
function private.freeData(self)
    local priv = private_data[self]
    BlzDestroyFrame(priv.framehandle)
    private.DB:remove(priv.framehandle)

    private_data[self] = nil
end

return Frame