--=========
-- Include
--=========

local Class = require('Utils.Class.API')

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

---@type InterfaceParameterLineClass
local ParamLine = require('Interface.Parameter.Line')

--=======
-- Class
--=======

local InterfaceParameterTooltip = Class.new('InterfaceParameterTooltip', SimpleFrame)
---@class InterfaceParameterTooltip : SimpleFrame
local public = InterfaceParameterTooltip.public
---@class InterfaceParameterTooltipClass : SimpleFrameClass
local static = InterfaceParameterTooltip.static
---@type InterfaceParameterTooltipClass
local override = InterfaceParameterTooltip.override
local private = {}

--=========
-- Static
--=========

---@param max_params number
---@param child_instance InterfaceParameterTooltip | nil
---@return InterfaceParameterTooltip
function override.new(max_params, child_instance)
    local instance = child_instance or Class.allocate(InterfaceParameterTooltip)
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

---@param unit Unit
function public:setUnit(unit)
    local priv = private.data[self]
    priv.used = 0

    local unit_params = unit:getParameters()

    local BASE = ParamValueType.BASE
    local MULT = ParamValueType.MULT
    local ADDIT = ParamValueType.ADDIT

    for _, param in pairs(ParamType) do
        local base = unit_params:get(param, BASE)
        local mult = unit_params:get(param, MULT)
        local addit = unit_params:get(param, ADDIT)
        local res = unit_params:getResult(param)

        priv.used = priv.used + 1
        if priv.used > priv.max then
            Logger.error(self, 'got max parameters count.', 2)
        end

        ---@type InterfaceParameterLine
        local line = priv.line[priv.used]
        line:setName(ParamAPI.getShortName(param))
        line:setBase(base)
        line:setMult(mult)
        line:setAddit(addit)
        line:setRes(res)
    end

    private.update(self)
end

---@param item Item
---@param unit Unit
function public:setItem(item, unit)
    local priv = private.data[self]
    priv.used = 0

    local item_params = item:getParameters()
    local unit_params = unit:getParameters()
    local cur_item_params = private.getCurItemParams(unit, item:getType())

    local mathParam = ParamAPI.mathParameter
    local BASE = ParamValueType.BASE
    local MULT = ParamValueType.MULT
    local ADDIT = ParamValueType.ADDIT

    for _, param in pairs(ParamType) do
        local base = unit_params:get(param, BASE) - cur_item_params:get(param, BASE) + item_params:get(param, BASE)
        local mult = unit_params:get(param, MULT) - cur_item_params:get(param, MULT) + item_params:get(param, MULT)
        local addit = unit_params:get(param, ADDIT) - cur_item_params:get(param, ADDIT) + item_params:get(param, ADDIT)
        local res = mathParam(param, base, mult, addit)

        if res ~= unit_params:getResult(param) then
            priv.used = priv.used + 1
            if priv.used > priv.max then
                Logger.error(self, 'got max parameters count.', 2)
            end

            ---@type InterfaceParameterLine
            local line = priv.line[priv.used]
            line:setName(ParamAPI.getShortName(param))
            line:setBase(item_params:get(param, BASE))
            line:setMult(item_params:get(param, MULT))
            line:setAddit(item_params:get(param, ADDIT))
            line:setRes(res, true)
        end
    end

    private.update(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.max_line_height = 0.007
private.zero_item_params = ParamAPI.Item.new()

private.background_type = SimpleFrameType.new('InterfaceParameterTooltipBackground', true)
private.background_type:setWidth(0.1)
private.background_type:setHeight(0.08)
private.background_type:setTexture(Import.TransparentTexture)

---@param unit Unit
---@param item_type ItemTypeEnum
function private.getCurItemParams(unit, item_type)
    local cur_item = unit:getEquipment():get(item_type)
    if cur_item then
        return cur_item:getParameters()
    else
        return private.zero_item_params
    end
end

---@param self InterfaceParameterTooltip
function private.update(self)
    local priv = private.data[self]
    local count = priv.used
    local height = self:getHeight()
    local width = self:getWidth()
    local line_height = math.max(height / count, private.max_line_height)

    for i = 1, count do
        local line = priv.line[i]
        line:setVisible(true)
        line:setX(0)
        line:setY(height - i * line_height)
        line:setHeight(line_height)
        line:setWidth(width)
    end

    for i = count + 1, priv.max do
        priv.line[i]:setVisible(false)
    end
end

---@param self InterfaceParameterTooltip
---@param max_lines number
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