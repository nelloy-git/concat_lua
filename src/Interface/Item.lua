--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.Api')
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleButton = FrameAPI.SimpleButton
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)

--=======
-- Class
--=======

local InterfaceItem = Class.new('InterfaceItem', SimpleFrame)
---@class InterfaceItem
local public = InterfaceItem.public
---@class InterfaceItemClass
local static = InterfaceItem.static
---@type InterfaceItemClass
local override = InterfaceItem.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceItem | nil
---@return InterfaceItem
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceItem)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance)

    return instance
end

function static.getDefaultSize()
    return private.background_size
end

--========
-- Public
--========

---@param icon string
function public:setItemIcon(icon)
    local priv = private.data[self]
    if icon then
        priv.icon:setTexture(icon)
        priv.icon:setVisible(true)
    else
        priv.icon:setVisible(false)
    end
end

---@param tooltip Frame
function public:setTooltip(tooltip)
    private.data[self].icon:setTooltip(tooltip)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.icon_size = 0.034
private.background_size = 0.040
private.border = (private.background_size - private.icon_size) / 2

private.icon_type = SimpleButtonType.new('InterfaceItemSlotIcon')
private.icon_type:setWidth(private.icon_size)
private.icon_type:setHeight(private.icon_size)
private.icon_type:setTexture('war3mapImported\\Icons\\Transparent32x32.tga')

private.background_type = SimpleFrameType.new('InterfaceItemSlotBackground')
private.background_type:setWidth(private.background_size)
private.background_type:setHeight(private.background_size)
private.background_type:setTexture('war3mapImported\\Icons\\Inventory\\EmptyBag.tga')

---@param self InterfaceItem
function private.newData(self)
    local icon = SimpleButton.new(private.icon_type)
    local priv = {
        icon = icon,
    }

    icon:setParent(self)
    icon:setX(private.border)
    icon:setY(private.border)
    icon:setVisible(false)

    private.data[self] = priv
end


return static