--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleTextType = FrameAPI.SimpleTextType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleButton = FrameAPI.SimpleButton
local SimpleText = FrameAPI.SimpleText
local FramePublic = Class.getPublic(FrameAPI.Frame)

--=======
-- Class
--=======

local InterfaceItemTooltip = Class.new('InterfaceItemTooltip', SimpleFrame)
---@class InterfaceItemTooltip : SimpleFrame
local public = InterfaceItemTooltip.public
---@class InterfaceItemTooltipClass : SimpleFrameClass
local static = InterfaceItemTooltip.static
---@type InterfaceItemTooltipClass
local override = InterfaceItemTooltip.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceItemTooltip | nil
---@return InterfaceItemTooltip
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceItemTooltip)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param title string
function public:setTitle(title)
    private.data[self].title:setText(title)
end

---@param descr string
function public:setDescription(descr)
    private.data[self].description:setText(descr)
end

---@param width number
function public:setWidth(width)
    FramePublic.setWidth(self, width)
    private.update(self)
end

---@param height number
function public:setHeight(height)
    FramePublic.setHeight(self, height)
    private.update(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.border_ratio = 0.08
private.space_ratio = 0.08

private.background = {}
private.background.width = 0.1
private.background.height = 0.2

private.icon = {}
private.icon.width_ratio = 0.15

private.title = {}
private.title.font = 'fonts\\nim_____.ttf'
private.title.font_size = 0.012

private.descr = {}
private.descr.font = 'fonts\\nim_____.ttf'
private.descr.font_size = 0.009

private.background_type = SimpleFrameType.new('InterfaceItemTooltipTooltipBackground')
private.background_type:setTexture('war3mapImported\\Icons\\Inventory\\Background.tga')

private.icon_type = SimpleFrameType.new('InterfaceItemTooltipTooltipIcon')
private.icon_type:setTexture('war3mapImported\\Icons\\Inventory\\EmptyBag.tga')

private.title_type = SimpleTextType.new('InterfaceItemTooltipTooltipTitle')
private.title_type:setFont('fonts\\nim_____.ttf')
private.title_type:setFontSize(0.012)

private.description_type = SimpleTextType.new('InterfaceItemTooltipTooltipDescription')
private.description_type:setFont('fonts\\nim_____.ttf')
private.description_type:setFontSize(0.009)

---@param self InterfaceItemTooltip
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border = private.border_ratio * width
    local space = private.space_ratio * width

    -- Icon
    print(self)
    local icon_size = private.icon.width_ratio * width
    priv.icon:setX(border)
    priv.icon:setY(height - border - icon_size)
    priv.icon:setWidth(icon_size)
    priv.icon:setHeight(icon_size)

    -- Title
    priv.title:setX(border + icon_size + space)
    priv.title:setY(height - border - icon_size)
    priv.title:setWidth(width - 2 * border - space - icon_size)
    priv.title:setHeight(icon_size)

    -- Description
    priv.description:setX(border + icon_size + space)
    priv.description:setY(border)
    priv.description:setWidth(width - 2 * border - space - icon_size)
    priv.description:setHeight(height - 2 * border - space - icon_size)
end

---@param self InterfaceItemTooltip
function private.newData(self)
    local icon = SimpleFrame.new(private.icon_type)
    local title = SimpleText.new(private.title_type)
    local descr = SimpleText.new(private.description_type)

    local priv = {
        icon = icon,
        title = title,
        description = descr
    }

    icon:setParent(self)

    title:setParent(self)
    title:setText('Title')

    descr:setParent(self)
    descr:setText('Description')

    private.data[self] = priv
end


return static