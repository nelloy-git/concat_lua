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
---@type FrameCellClass
local override = FrameCell.override

local private = {}

--=========
-- Static
--=========

---@alias FrameCellItemPosition number

---@type FrameCellItemPosition[]
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

---@param owner Frame
---@param child_instance FrameCell | nil
---@return FrameCell
function static.new(owner, child_instance)
    local instance = child_instance or Class.allocate(FrameCell)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@param x number
function public:setCenterX(x)
    private[self].x = x
    private.updateItemPos(self)
end

---@param y number
function public:setCenterY(y)
    private[self].y = y
    private.updateItemPos(self)
end

---@param width number
function public:setWidth(width)
    private[self].w = width
    private.updateItemPos(self)
end

---@param height number
function public:setHeight(height)
    private[self].h = height
    private.updateItemPos(self)
end

---@param position FrameCellItemPosition
function public:setPosition(position)
    local found = false
    for k,v in pairs(static.POSITION) do
        if position == v then
            found = true
            break
        end
    end

    if not found then
        Log.error(FrameCell, 'wrong position.', 2)
        return
    end

    private[self].position = position
    private.updateItemPos(self)
end

---@param item Frame
---@return Frame | nil
function public:setItem(item)
    private[self].item = item
    private.updateItemPos(self)
end

---@retrun Frame
function public:getItem()
    return private[self].item
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

---@param self FrameCell
function private.updateItemPos(self)
    local priv = private[self]

    if not priv.item then
        return
    end

    local x, y = private.getOffsets(self)

    local item = priv.item
    if item:getFollowTarget() ~= priv.owner then
        item:setFollowTarget(priv.owner)
    end
    item:setFollowOffsets(x, y)
end

function private.getOffsets(self)
    local priv = private[self]
    local pos = priv.pos
    local item_w = priv.item:getWidth()
    local item_h = priv.item:getHeight()

    local x, y
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
    end

    return x, y
end

---@param self FrameCell
---@param owner Frame
---@return table
function private.newData(self, owner)
    local priv = {
        owner = owner,
        item = nil,
        position = 8,
        x = 0,
        y = 0,
        h = 0,
        w = 0,
    }
    private[self] = priv
    return priv
end


---@param self FrameCell
function private.freeData(self)
    private[self].item:setFollowTarget(nil)
    private[self] = nil
end

return FrameCell