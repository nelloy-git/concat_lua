--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

local Import = require('Resources.Import')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleTextType = FrameAPI.SimpleTextType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleText = FrameAPI.SimpleText
local FramePublic = Class.getPublic(FrameAPI.Frame)

local fmt = string.format

--=======
-- Class
--=======

local InterfaceParameterLine = Class.new('InterfaceParameterLine', SimpleFrame)
---@class InterfaceParameterLine : SimpleFrame
local public = InterfaceParameterLine.public
---@class InterfaceParameterLineClass : SimpleFrameClass
local static = InterfaceParameterLine.static
---@type InterfaceParameterLineClass
local override = InterfaceParameterLine.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceParameterLine | nil
---@return InterfaceParameterLine
function override.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceParameterLine)
    instance = SimpleFrame.new(private.background_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

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

---@param name string
function public:setName(name)
    private.data[self].name:setText(name)
end

---@param value number
function public:setBase(value)

    local color = private.zero_color
    if value > 0 then
        color = private.bonus_color
    elseif value < 0 then
        color = private.penalty_color
    end

    private.data[self].base:setText(fmt('%.1f', value))
    private.data[self].base:setTextColor(color.red, color.green, color.blue, color.alpha)
end

---@param value number
function public:setMult(value)

    local color = private.zero_color
    if value > 0 then
        color = private.bonus_color
    elseif value < 0 then
        color = private.penalty_color
    end

    private.data[self].mult:setText(fmt('%.1f%%', 100 * value))
    private.data[self].mult:setTextColor(color.red, color.green, color.blue, color.alpha)
end

---@param value number
function public:setAddit(value)

    local color = private.zero_color
    if value > 0 then
        color = private.bonus_color
    elseif value < 0 then
        color = private.penalty_color
    end

    private.data[self].addi:setText(fmt('%.1f', value))
    private.data[self].addi:setTextColor(color.red, color.green, color.blue, color.alpha)
end

---@param value number
---@param use_plus boolean
function public:setRes(value, use_plus)
    local first = ''
    local color = private.zero_color
    if value > 0 then
        first = '+'
        color = private.bonus_color
    elseif value < 0 then
        first = '-'
        color = private.penalty_color
    end

    if not use_plus then
        first = ''
    end

    private.data[self].res:setText(fmt(first..'%.1f', value))
    private.data[self].res:setTextColor(color.red, color.green, color.blue, color.alpha)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.name_ratio = 1 / 3
private.value_ratio = 1 / 6

private.background_type = SimpleFrameType.new('InterfaceParameterLineBackground', true)
private.background_type:setWidth(0.1)
private.background_type:setHeight(0.01)
private.background_type:setTexture(Import.TransparentTexture)

private.text_type = SimpleTextType.new('InterfaceParameterLineText', true)
private.text_type:setFont('fonts\\nim_____.ttf')
private.text_type:setFontSize(0.009)
private.text_type:setAnchor('LEFT')

private.zero_color = {red = 230, green = 230, blue = 230, alpha = 255}
private.bonus_color = {red = 50, green = 230, blue = 50, alpha = 255}
private.penalty_color = {red = 230, green = 50, blue = 50, alpha = 255}

---@param self InterfaceParameterLine
function private.update(self)
    local priv = private.data[self]

    local width = self:getWidth()
    local height = self:getHeight()
    local name_width = width * private.name_ratio
    local value_width = width * private.value_ratio

    priv.name:setX(0)
    priv.name:setWidth(name_width)
    priv.name:setHeight(height)

    priv.base:setX(name_width)
    priv.base:setWidth(value_width)
    priv.base:setHeight(height)

    priv.mult:setX(name_width + value_width)
    priv.mult:setWidth(value_width)
    priv.mult:setHeight(height)

    priv.addi:setX(name_width + 2 * value_width)
    priv.addi:setWidth(value_width)
    priv.addi:setHeight(height)

    priv.res:setX(name_width + 3 * value_width)
    priv.res:setWidth(value_width)
    priv.res:setHeight(height)
end

---@param self InterfaceParameterLine
function private.newData(self)
    local priv = {
        name = SimpleText.new(private.text_type),
        base = SimpleText.new(private.text_type),
        mult = SimpleText.new(private.text_type),
        addi = SimpleText.new(private.text_type),
        res = SimpleText.new(private.text_type),
    }
    private.data[self] = priv

    priv.name:setParent(self)
    priv.name:setY(0)

    priv.base:setParent(self)
    priv.base:setY(0)

    priv.mult:setParent(self)
    priv.mult:setY(0)

    priv.addi:setParent(self)
    priv.addi:setY(0)

    priv.res:setParent(self)
    priv.res:setY(0)

    private.update(self)
end

return static