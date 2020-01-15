--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameClass
local Frame = require('Class.Frame.Frame')

--=======
-- Class
--=======

local FrameCell = Class.new('FrameCell')
---@class FrameCell
local public = FrameCell.public
---@class FrameCellClass
local static = FrameCell.static
local override = FrameCell.override

local private = {}

--=========
-- Static
--=========

static.POSITION = {
    LEFT = 0,
    TOPLEFT = 1,
    TOP = 2,
    TOPRIGTH = 3,
    RIGHT = 4,
    BOTTOMRIGHT = 5,
    BOTTOM = 6,
    BOTTOMLEFT = 7,
    CENTER = 8
}

---@param child_data any
---@return FrameCell
function static.new(owner, child_data)
    local instance = child_data or Class.allocate(FrameCell, child_data)
    local priv = private.new(instance)

    return instance
end

--========
-- Public
--========

---@param x number
function public:setCenterX(x)
    private.get(self).x = x
    private.updateItemPos(self)
end

---@param y number
function public:setCenterY(y)
    private.get(self).y = y
    private.updateItemPos(self)
end

---@param width number
function public:setWidth(width)
    private.get(self).w = width
    private.updateItemPos(self)
end

---@param height number
function public:setHeight(height)
    private.get(self).h = height
    private.updateItemPos(self)
end

---@param position number
function public:setPosition(position)
    private.get(self).position = position
    private.updateItemPos(self)
end

---@param item Frame
function public:setItem(item)
    local priv = private.get(self)
    priv.item = item
    private.updateItemPos(self)
end

--- Returns containing frame.
---@return Frame
function public:free()
    local item = private.free(self)
    Class.freeInstanceData(self)
    return item
end

--=========
-- Private
--=========

---@param self FrameCell
function private.updateItemPos(self)
    local priv = private.get(self)

    if priv.item then
        local pos = priv.position
        local item = priv.item
        local item_w = item:getWidth()
        local item_h = item:getHeight()

        local x
        local y
        if pos == static.POSITION.LEFT then
            x = priv.x - priv.w / 2 + item_w / 2
            y = priv.y
        elseif pos == static.POSITION.TOPLEFT then
            x = priv.x - priv.w / 2 + item_w / 2
            y = priv.y + priv.h / 2 - item_h / 2
        elseif pos == static.POSITION.TOP then
            x = priv.x
            y = priv.y + priv.h / 2 - item_h / 2
        elseif pos == static.POSITION.TOPRIGTH then
            x = priv.x + priv.w / 2 - item_w / 2
            y = priv.y + priv.h / 2 - item_h / 2
        elseif pos == static.POSITION.RIGHT then
            x = priv.x + priv.w / 2 - item_w / 2
            y = priv.y
        elseif pos == static.POSITION.BOTTOMRIGHT then
            x = priv.x + priv.w / 2 - item_w / 2
            y = priv.y - priv.h / 2 + item_h / 2
        elseif pos == static.POSITION.BOTTOM then
            x = priv.x
            y = priv.y - priv.h / 2 + item_h / 2
        elseif pos == static.POSITION.BOTTOMLEFT then
            x = priv.x - priv.w / 2 + item_w / 2
            y = priv.y - priv.h / 2 + item_h / 2
        elseif pos == static.POSITION.CENTER then
            x = priv.x
            y = priv.y
        else
            Log(Log.Wrn, FrameCell, 'wrong position constant.')
            x = priv.x
            y = priv.y
        end

        if item:getFollowTarget() ~= priv.owner then
            item:setFollowTarget(priv.owner)
        end
        item:setFollowOffsets(x, y)
    end
end

local private_data = {}

---@param self FrameCell
---@param owner Frame
---@return table
function private.new(self, owner)
    local priv = {
        owner = owner,
        item = nil,
        position = 8,
        x = 0,
        y = 0,
        h = 0,
        w = 0,
    }
    private_data[self] = priv
    return priv
end

---@param self FrameCell
function private.get(self)
    return private_data[self]
end

--- Returns containing frame.
---@param self FrameCell
---@return Frame
function private.free(self)
    local item = private_data[self].item
    item:setFollowTarget(nil)
    private_data[self] = nil
    return item
end

return FrameCell