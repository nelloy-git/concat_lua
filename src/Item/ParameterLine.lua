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

--=======
-- Class
--=======

local ItemParameterLine = Class.new('ItemParameterLine', SimpleFrame)
---@class ItemParameterLine : SimpleFrame
local public = ItemParameterLine.public
---@class ItemParameterLineClass : SimpleFrameClass
local static = ItemParameterLine.static
---@type ItemParameterLineClass
local override = ItemParameterLine.override
local private = {}

--=========
-- Static
--=========

---@param child_instance ItemParameterLine | nil
---@return ItemParameterLine
function static.new(child_instance)
    local instance = child_instance or Class.allocate(ItemParameterLine)
    instance = SimpleFrame.new(private.background_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param name string
---@param red number
---@param green number
---@param blue number
function public:setName(name, red, green, blue, alpha)
    private.data[self].name:setText(name)
    private.data[self].name:setTextColor(red or 230, green or 230, blue or 230, alpha or 255)
end

---@param value number
function public:setBase(value)

    local color = private.zero_color
    if value > 0 then
        color = private.bonus_color
    elseif value < 0 then
        color = private.penalty_color
    end

    private.data[self].base:setText(tostring(value))
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

    private.data[self].mult:setText(string.format())
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

    private.data[self].addi:setText(tostring(value))
    private.data[self].addi:setTextColor(color.red, color.green, color.blue, color.alpha)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.background_type = SimpleFrameType.new('ItemParameterLineBackground')
private.background_type:setWidth(0.1)
private.background_type:setHeight(0.01)
private.background_type:setTexture(Import.InventoryBackground)

private.text_type = SimpleTextType.new('ItemParameterLineText')
private.text_type:setFont('fonts\\nim_____.ttf')
private.text_type:setFontSize(0.009)
private.text_type:setAnchor('LEFT')

private.zero_color = {red = 230, green = 230, blue = 230, alpha = 255}
private.bonus_color = {red = 50, green = 230, blue = 50, alpha = 255}
private.penalty_color = {red = 230, green = 50, blue = 50, alpha = 255}

---@param self ItemParameterLine
function private.update(self)
    local width = self:getWidth()
    local height = self:getHeight()

    local priv = private.data[self]

    priv.name:setX(0)
    priv.name:setWidth(width * 3 / 6)
    priv.name:setHeight(height)

    priv.base:setX(width * 3 / 6)
    priv.base:setWidth(width * 1 / 6)
    priv.base:setHeight(height)

    priv.mult:setX(width * 4 / 6)
    priv.mult:setWidth(width * 1 / 6)
    priv.mult:setHeight(height)

    priv.addi:setX(width * 5 / 6)
    priv.addi:setWidth(width * 1 / 6)
    priv.addi:setHeight(height)
end

---@param self ItemParameterLine
function private.newData(self)
    local priv = {
        name = SimpleText.new(private.text_type),
        base = SimpleText.new(private.text_type),
        mult = SimpleText.new(private.text_type),
        addi = SimpleText.new(private.text_type)
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

    private.update(self)
end

return static