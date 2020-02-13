--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

local Import = require('Resources.Import')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleTextType = FrameAPI.SimpleTextType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleButton = FrameAPI.SimpleButton
local SimpleText = FrameAPI.SimpleText
local FramePublic = Class.getPublic(FrameAPI.Frame)

---@type ParameterAPI
local ParamAPI = require('Parameter.API')
local ParamType = ParamAPI.ParamType
local ParamValueType = ParamAPI.ValueType

---@type ItemParameterLineClass
local ParamLine = require('Item.ParameterLine')

--=======
-- Class
--=======

local ItemParameterTooltip = Class.new('ItemParameterTooltip', SimpleFrame)
---@class ItemParameterTooltip : SimpleFrame
local public = ItemParameterTooltip.public
---@class ItemParameterTooltipClass : SimpleFrameClass
local static = ItemParameterTooltip.static
---@type ItemParameterTooltipClass
local override = ItemParameterTooltip.override
local private = {}

--=========
-- Static
--=========

---@param max_params number
---@param child_instance ItemParameterTooltip | nil
---@return ItemParameterTooltip
function static.new(max_params, child_instance)
    local instance = child_instance or Class.allocate(ItemParameterTooltip)
    instance = SimpleFrame.new(private.background_type)
    private.newData(instance, max_params)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    FramePublic.setWidth(self, width)

    local priv = private.data[self]
    for i = 1, priv.max do
        priv.line[i]:setWidth(width)
    end
end

---@param height number
function public:setHeight(height)
    FramePublic.setHeight(self, height)
    private.update(self)
end

---@param param ParameterItem
function public:loadParam(param)
    local priv = private.data[self]
    priv.used = 0

    for _, paramType in pairs(ParamType) do
        local base = param:get(paramType, ParamValueType.BASE)
        local mult = param:get(paramType, ParamValueType.MULT)
        local addit = param:get(paramType, ParamValueType.ADDIT)
        if base ~= 0 or mult ~= 0 or addit ~= 0 then
            priv.used = priv.used + 1
            if priv.used > priv.max then
                Log.error(self, 'got max parameters count.', 2)
            end
            ---@type ItemParameterLine
            local line = priv.line[priv.used]
            line:setName(ParamAPI.getShortName(paramType))
            line:setBase(base)
            line:setMult(mult)
            line:setAddit(addit)
        end
    end

    private.update(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.background_type = SimpleFrameType.new('ItemParameterTooltipBackground')
private.background_type:setWidth(0.08)
private.background_type:setHeight(0.1)
private.background_type:setTexture(Import.TransparentTexture)

---@param self ItemParameterTooltip
function private.update(self)
    local priv = private.data[self]
    local count = priv.used
    local height = self:getHeight()
    local line_height = height / count

    for i = 1, count do
        local line = priv.line[i]
        line:setVisible(true)
        line:setY((i - 1) * line_height)
        line:setHeight(line_height)
    end

    for i = count + 1, priv.max do
        priv.line[i]:setVisible(false)
    end
end

---@param self ItemParameterTooltip
function private.newData(self, max_lines)
    local priv = {
        max = max_lines,
        used = 0,
        line = {}
    }
    private.data[self] = priv

    for i = 1, max_lines do
        local line = ParamLine.new()
        line:setParent(self)
        line:setX(0)
        line:setWidth(self:getWidth())
        line:setVisible(false)
    end
end

return static