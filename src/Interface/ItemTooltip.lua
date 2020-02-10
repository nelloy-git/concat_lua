--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.Api')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleTextType = FrameAPI.SimpleTextType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleButton = FrameAPI.SimpleButton
local SimpleText = FrameAPI.SimpleText

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
function override.new(x, y, width, height, child_instance)
    local instance = child_instance or Class.allocate(InterfaceItemTooltip)
    instance = SimpleFrame.new(private.tooltip_background_type, instance)
    instance:setX(x)
    instance:setY(y)
    instance:setWidth(width)
    instance:setHeight(height)

    private.newData(instance)

    return instance
end

--========
-- Public
--========



--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.tooltip_background_type = SimpleFrameType.new('InterfaceItemTooltipTooltipBackground')
private.title_type = SimpleTextType.new('InterfaceItemTooltipTooltipTitle')
private.description = SimpleTextType.new('InterfaceItemTooltipTooltipDescription')

private.title_font = 'fonts\\nim_____.ttf'
private.title_font_size = 0.012
private.title_x = 0.05
private.title_y = 0.90

private.descr_font = 'fonts\\nim_____.ttf'
private.descr_font_size = 0.009
private.descr_x = 0.05
private.descr_y = 0.05

---@param self InterfaceItemTooltip
function private.newData(self)
    local title = SimpleText.new(private.title_type)
    local descr = SimpleText.new(private.description)
    local priv = {
        title = title,
        description = descr
    }

    title:setParent(self)
    title:setX(private.title_x * self:getWidth())
    title:setY(private.title_y * self:getHeight())
    title:setWidth(self:getWidth())
    title:setHeight(private.title_font_size)
    title:setFont(private.title_font)
    title:setFontSize(private.title_font_size)
    title:setText('Title')

    descr:setParent(self)
    descr:setX(private.descr_x * self:getWidth())
    descr:setY(private.descr_y * self:getHeight())
    title:setWidth(self:getWidth())
    title:setHeight(private.descr_font_size)
    descr:setFont(private.descr_font)
    descr:setFontSize(private.descr_font_size)
    descr:setText('Description')

    private.data[self] = priv
end


return static