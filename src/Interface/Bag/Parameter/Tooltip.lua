--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

local Import = require('Resources.Import')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)

---@type ParameterAPI
local ParamAPI = require('Parameter.API')
local ParamType = ParamAPI.ParamType
local ParamValueType = ParamAPI.ValueType

---@type InterfaceItemParameterLineClass
local ParamLine = require('Interface.Bag.Parameter.Line')

--=======
-- Class
--=======

local InterfaceItemParameterTooltip = Class.new('InterfaceItemParameterTooltip', SimpleFrame)
---@class InterfaceItemParameterTooltip : SimpleFrame
local public = InterfaceItemParameterTooltip.public
---@class InterfaceItemParameterTooltipClass : SimpleFrameClass
local static = InterfaceItemParameterTooltip.static
---@type InterfaceItemParameterTooltipClass
local override = InterfaceItemParameterTooltip.override
local private = {}

--=========
-- Static
--=========

---@param max_params number
---@param child_instance InterfaceItemParameterTooltip | nil
---@return InterfaceItemParameterTooltip
function override.new(max_params, child_instance)
    local instance = child_instance or Class.allocate(InterfaceItemParameterTooltip)
    instance = SimpleFrame.new(private.background_type, instance)
    private.newData(instance, max_params)

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

---@param params ParameterItem
function public:setParameters(params)
    local priv = private.data[self]
    priv.used = 0

    for _, paramType in pairs(ParamType) do
        local base = params:get(paramType, ParamValueType.BASE)
        local mult = params:get(paramType, ParamValueType.MULT)
        local addit = params:get(paramType, ParamValueType.ADDIT)
        if base ~= 0 or mult ~= 0 or addit ~= 0 then
            priv.used = priv.used + 1
            if priv.used > priv.max then
                Log.error(self, 'got max parameters count.', 2)
            end
            ---@type InterfaceItemParameterLine
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

private.max_line_height = 0.01

private.background_type = SimpleFrameType.new('InterfaceItemParameterTooltipBackground', true)
private.background_type:setWidth(0.1)
private.background_type:setHeight(0.08)
private.background_type:setTexture(Import.TransparentTexture)

---@param self InterfaceItemParameterTooltip
function private.update(self)
    local priv = private.data[self]
    local count = priv.used
    local height = self:getHeight()
    local width = self:getWidth()
    local line_height = math.min(height / count, private.max_line_height)

    for i = 1, count do
        local line = priv.line[i]
        line:setVisible(true)
        line:setY(height - i * line_height)
        line:setHeight(line_height)
        line:setWidth(width)
    end

    for i = count + 1, priv.max do
        priv.line[i]:setVisible(false)
    end
end

---@param self InterfaceItemParameterTooltip
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

        priv.line[i] = line
    end
end

return static