--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.Api')
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleButton = FrameAPI.SimpleButton
---@type InterfaceItemTooltipClass
local ItemTooltip = require('Interface.ItemTooltip')

--=======
-- Class
--=======

local InterfaceUnitBagSlot = Class.new('InterfaceUnitBagSlot', SimpleButton)
---@class InterfaceUnitBagSlot
local public = InterfaceUnitBagSlot.public
---@class InterfaceUnitBagSlotClass
local static = InterfaceUnitBagSlot.static
---@type InterfaceUnitBagSlotClass
local override = InterfaceUnitBagSlot.override
local private = {}

--=========
-- Static
--=========

---@param x number
---@param y number
---@param width number
---@param height number
---@param child_instance InterfaceUnitBagSlot | nil
---@return InterfaceUnitBagSlot
function override.new(x, y, width, height, child_instance)
    local instance = child_instance or Class.allocate(InterfaceUnitBagSlot)
    instance = SimpleButton.new(private.icon_type, instance)
    instance:setX(x)
    instance:setY(y)
    instance:setWidth(width)
    instance:setHeight(height)

    private.newData(instance, x, y, width, height)

    return instance
end

--========
-- Public
--========



--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.icon_type = SimpleButtonType.new('InterfaceUnitBagSlotIcon')

---@param self InterfaceUnitBagSlot
function private.newData(self, x, y, width, height)
    local tooltip = ItemTooltip.new(x - width, y - height, width, height)
    local priv = {
        tooltip = tooltip
    }
    self:setTooltip(tooltip)

    private.data[self] = priv
end


return static