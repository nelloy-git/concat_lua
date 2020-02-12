--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleButton = FrameAPI.SimpleButton
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)

--=======
-- Class
--=======

local ItemFrame = Class.new('ItemFrame', SimpleFrame)
---@class ItemFrame : SimpleFrame
local public = ItemFrame.public
---@class ItemFrameClass : SimpleFrameClass
local static = ItemFrame.static
---@type ItemFrameClass
local override = ItemFrame.override
local private = {}

--=========
-- Static
--=========

---@param child_instance ItemFrame | nil
---@return ItemFrame
function override.new(child_instance)
    local instance = child_instance or Class.allocate(ItemFrame)
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

private.background_type = SimpleFrameType.new('ItemFrameSlotBackground')
private.background_type:setWidth(private.background_size)
private.background_type:setHeight(private.background_size)
private.background_type:setTexture('war3mapImported\\Icons\\Inventory\\EmptyBag.tga')

private.icon_type = SimpleButtonType.new('ItemFrameSlotIcon')
private.icon_type:setWidth(private.icon_size)
private.icon_type:setHeight(private.icon_size)
private.icon_type:setTexture('war3mapImported\\Icons\\Transparent32x32.tga')

---@param self ItemFrame
function private.newData(self)
    local priv = {
        icon = SimpleButton.new(private.icon_type),
    }
    private.data[self] = priv

    local icon = priv.icon
    icon:setParent(self)
    icon:setX(private.border)
    icon:setY(private.border)
    icon:setVisible(false)
end


return static