--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib)
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame) or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local Param = ParamLib.Enum or error('')
local Parameter = ParamLib.Parameter or error('')
local ParamUnitContainer = ParamLib.UnitContainer or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local InterfaceUnitParams = Class.new('InterfaceUnitParams', Frame)
---@class InterfaceUnitParams : Frame
local public = InterfaceUnitParams.public
---@class InterfaceUnitParamsClass : FrameClass
local static = InterfaceUnitParams.static
---@type InterfaceUnitParamsClass
local override = InterfaceUnitParams.override
local private = {}

--=========
-- Static
--=========

---@return InterfaceUnitParams
function override.new()
    local instance = Class.allocate(InterfaceUnitParams)
    instance = Frame.new(private.fdf_background:getName(),
                         private.fdf_background:isSimple(),
                         instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:setPos(x, y)
    FramePublic.setPos(self, x, y)
    private.updatePos(self)
end

---@param width number
---@param height number
function public:setSize(width, height)
    FramePublic.setSize(self, width, height)
    private.updatePos(self)
end

---@param flag number
function public:setVisible(flag)
    FramePublic.setVisible(self, flag)
    local priv = private.data[self]

    for i = 1, #private.params_order do
        priv.names[i]:setVisible(flag)
        priv.values[i]:setVisible(flag)
    end
end

---@param param Parameter
---@param value number
function public:setValue(param, value)
    isTypeErr(param, Parameter, 'param')
    isTypeErr(value, 'number', 'value')

    local priv = private.data[self]

    local i = 1
    local pos
    while not pos and i <= #private.params_order do
        if private.params_order[i] == param then
            pos = i
        end
        i = i + 1
    end

    value = math.tointeger(value)
    priv.values[pos]:setText(tostring(value))
end

---@param value_list ParameterValueList
function public:setAllValues(value_list)
    isTypeErr(value_list, ParamUnitContainer, 'value_list')

    local count = #private.params_order
    for i = 1, count do
        local param = ParamLib.AllParameters[i]
        self:setValue(param, value_list:getResult(param))
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf_background = FrameLib.Fdf.Normal.Backdrop.new('InterfaceUnitParametersBackground')
private.fdf_background:setWidth(0.04)
private.fdf_background:setHeight(0.04)
private.fdf_background:setBackgroundTileMode(true)
private.fdf_background:setBackgroundTileSize(0.2)
private.fdf_background:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf_background:setInsets(0.005, 0.005, 0.005, 0.005)
private.fdf_background:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf_background:setCornerSize(0.0125)
private.fdf_background:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

private.font = 'fonts\\nim_____.ttf'

---@type table<number, Parameter>
private.params_order = {}
table.insert(private.params_order, Param.PDMG)
table.insert(private.params_order, Param.MDMG)
table.insert(private.params_order, Param.PDEF)
table.insert(private.params_order, Param.MDEF)
table.insert(private.params_order, Param.PRES)
table.insert(private.params_order, Param.MRES)
table.insert(private.params_order, Param.LIFE)
table.insert(private.params_order, Param.REGEN)
table.insert(private.params_order, Param.MANA)
table.insert(private.params_order, Param.RECOV)
table.insert(private.params_order, Param.ASPD)
table.insert(private.params_order, Param.CDR)
table.insert(private.params_order, Param.DCH)
table.insert(private.params_order, Param.CRCH)
table.insert(private.params_order, Param.CRES)
table.insert(private.params_order, Param.MSPD)

---@param self InterfaceUnitParams
function private.newData(self)
    local priv = {
        names = {},
        values = {}
    }
    private.data[self] = priv

    local count = #private.params_order
    if count ~= #ParamLib.AllParameters then
        Log:wrn(tostring(InterfaceUnitParams)..': does not use all parameters. Chech \'private.params_order\'')
    end

    for i = 1, count do
        ---@type Parameter
        local param = private.params_order[i]

        local name = FrameLib.Simple.Text.new()
        name:setText(param:getShortName())
        table.insert(priv.names, #priv.names + 1, name)

        local value = FrameLib.Simple.Text.new()
        value:setText('0')
        table.insert(priv.values, #priv.values + 1, value)
    end

    private.updatePos(self)
end

---@param self InterfaceUnitParams
function private.updatePos(self)
    local priv = private.data[self]

    local x = self:getAbsX()
    local y = self:getAbsY()
    local width = self:getWidth()
    local height = self:getHeight()

    local x_border = 0.05 * width   --Insets
    local y_border = 0.05 * height  --Insets

    local count = #private.params_order
    local w_name = 3 * (width - 2 * x_border) / 4
    local w_value = (width - 2 * x_border) / 4
    local h = (height - 2 * y_border) / count
    local font_size = 0.9 * h

    for i = 1, count do
        ---@type FrameSimpleText
        local name = priv.names[i]
        name:setPos(x + x_border, y + y_border + (i - 1) * h)
        name:setSize(w_name, h)
        name:setFont(private.font, font_size)
        name:setVisible(self:isVisible())

        ---@type FrameSimpleText
        local value = priv.values[i]
        value:setPos(x + width - x_border - w_value, y + y_border + (i - 1) * h)
        value:setSize(w_value, h)
        value:setFont(private.font, font_size)
        value:setVisible(self:isVisible())
    end
end

return static