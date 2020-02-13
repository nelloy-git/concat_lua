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
---@type ItemParameterTooltipClass
local ItemParamTooltip = require('Item.ParameterTooltip')

--=======
-- Class
--=======

local ItemTooltip = Class.new('ItemTooltip', SimpleFrame)
---@class ItemTooltip : SimpleFrame
local public = ItemTooltip.public
---@class ItemTooltipClass : SimpleFrameClass
local static = ItemTooltip.static
---@type ItemTooltipClass
local override = ItemTooltip.override
local private = {}

--=========
-- Static
--=========

---@param child_instance ItemTooltip | nil
---@return ItemTooltip
function override.new(child_instance)
    local instance = child_instance or Class.allocate(ItemTooltip)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param icon string
function public:setIcon(icon)
    private.data[self].icon:setTexture(icon)
end

---@param title string
---@param red number | nil
---@param green number | nil
---@param blue number | nil
---@param alpha number | nil
function public:setTitle(title, red, green, blue, alpha)
    private.data[self].title:setText(title)
    private.data[self].title:setTextColor(red or 230, green or 230, blue or 230, alpha or 255)
end

---@param descr string | ParameterItem
---@param red number | nil
---@param green number | nil
---@param blue number | nil
---@param alpha number | nil
function public:setDescription(descr, red, green, blue, alpha)
    private.data[self].description:setText(descr)
    private.data[self].description:setTextColor(red or 230, green or 230, blue or 230, alpha or 255)
end

---@param param ParameterItem
function public:setParameters(param)
    private.data[self].params:loadParam(param)
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

private.border_ratio_x = 0.05
private.border_ratio_y = 0.05
private.space_ratio_x = 0.05
private.space_ratio_y = 0.05
private.icon_ratio = 0.15
private.descript_ratio = 0.15

private.background_type = SimpleFrameType.new('ItemTooltipTooltipBackground')
private.background_type:setTexture('war3mapImported\\Icons\\Inventory\\Background.tga')

private.icon_type = SimpleFrameType.new('ItemTooltipTooltipIcon')
private.icon_type:setTexture('war3mapImported\\Icons\\Inventory\\EmptyBag.tga')

private.title_type = SimpleTextType.new('ItemTooltipTooltipTitle')
private.title_type:setFont('fonts\\nim_____.ttf')
private.title_type:setFontSize(0.012)
private.title_type:setAnchor('CENTER')

private.description_type = SimpleTextType.new('ItemTooltipTooltipDescription')
private.description_type:setFont('fonts\\nim_____.ttf')
private.description_type:setFontSize(0.009)
private.description_type:setAnchor('CENTER')

---@param self ItemTooltip
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = private.border_ratio_x * width
    local border_y = private.border_ratio_y * height
    local space_x = private.space_ratio_x * width
    local space_y = private.space_ratio_y * width
    local icon_size = private.icon_ratio * width
    local descr_height = private.descript_ratio * height

    -- Icon
    priv.icon:setX(border_x)
    priv.icon:setY(height - border_y - icon_size)
    priv.icon:setWidth(icon_size)
    priv.icon:setHeight(icon_size)

    -- Title
    priv.title:setX(border_x + icon_size + space_x)
    priv.title:setY(height - border_y - icon_size)
    priv.title:setWidth(width - 2 * border_x - space_x - icon_size)
    priv.title:setHeight(icon_size)

    -- Description
    priv.description:setX(border_x)
    priv.description:setY(height - border_y - icon_size - descr_height)
    priv.description:setWidth(width - 2 * border_x)
    priv.description:setHeight(descr_height)

    -- Parameters
    priv.params:setX(border_x)
    priv.params:setY(border_y)
    priv.params:setWidth(width - 2 * border_x)
    priv.params:setHeight(height - 2 * border_y - icon_size - descr_height)
end

---@param self ItemTooltip
function private.newData(self)
    local icon = SimpleFrame.new(private.icon_type)
    local title = SimpleText.new(private.title_type)
    local descr = SimpleText.new(private.description_type)
    local params = ItemParamTooltip.new(7)

    local priv = {
        icon = icon,
        title = title,
        description = descr,
        params = params
    }

    icon:setParent(self)

    title:setParent(self)
    title:setText('Title')

    descr:setParent(self)
    descr:setText('Description')

    params:setParent(self)

    private.data[self] = priv
end


return static