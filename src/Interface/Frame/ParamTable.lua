--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type InterfaceFrameIconValueClass
local IconValue = require('Interface.Frame.IconValue')
---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButton = FrameAPI.SimpleButton
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleLayerType = FrameAPI.SimpleLayerType
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleTextureType = FrameAPI.SimpleTextureType
local SimpleStringType = FrameAPI.SimpleStringType
local SimpleStatusBarType = FrameAPI.SimpleStatusBarType
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type ParameterAPI
local ParameterAPI = require('Parameter.API')
local ParamType = ParameterAPI.ParamType
local BASE = ParameterAPI.ValueType.BASE
local ADDIT = ParameterAPI.ValueType.ADDIT
local MULT = ParameterAPI.ValueType.MULT
local isMagic = ParameterAPI.isMagic
local isPhysic = ParameterAPI.isPhysic

--=======
-- Class
--=======

local InterfaceFrameParamTable = Class.new('InterfaceFrameParamTable', SimpleButton)
---@class InterfaceFrameParamTable : SimpleButton
local public = InterfaceFrameParamTable.public
---@class InterfaceFrameParamTableClass :SimpleButtonClass
local static = InterfaceFrameParamTable.static
---@type InterfaceFrameParamTableClass
local override = InterfaceFrameParamTable.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceFrameParamTable | nil
---@return InterfaceFrameParamTable
function override.new(child_instance)
    if child_instance and not Class.type(child_instance, InterfaceFrameParamTable) then
        Log.error(InterfaceFrameParamTable, '\"child_instance\" must be InterfaceFrameParamTable or nil', 2)
    end

    local instance = child_instance or Class.allocate(InterfaceFrameParamTable)
    instance = SimpleButton.new(private.frame_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Autosizing frame. Disabled function
---@param width number
---@param height number
function public:setSize(width, height)
    Log(Log.Wrn, self, 'Autosizing frame. Disabled function.', 2)
end

---@param level number
function public:setLevel(level)
    FramePublic.setLevel(self, level)
end

---@param texture string | nil
function public:setBackground(texture)
    texture = texture or Import.TransparentTexture
    BlzFrameSetTexture(private.data[self].background, texture, 0, true)
end

---@param unit_params ParameterUnit
function public:setUnit(unit_params)
    local priv = private.data[self]

    priv.used_util = {}
    priv.used_magic = {}
    priv.used_phys = {}

    for i = 1, #private.params_queue do
        local param_type = private.params_queue[i]

        local base = unit_params:get(param_type, BASE)
        local addit = unit_params:get(param_type, ADDIT)
        local mult = unit_params:get(param_type, MULT)
        local res = unit_params:getResult(param_type)

        local list = (isMagic(param_type) and priv.used_magic) or
                     (isPhysic(param_type) and priv.used_phys) or
                     priv.used_util
        table.insert(list, param_type)

        priv.param[param_type]:setText(res)
        -- TODO tooltips
    end

    private.updatePositions(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.param_width = 0.08
private.param_height = 0.02
private.default_font = 'fonts\\nim_____.ttf'
private.default_font_size = 0.008

private.name = tostring(InterfaceFrameParamTable)

private.params_queue = {
    ParamType.Str, ParamType.Agi, ParamType.Int, ParamType.MS,
    ParamType.Dodge, ParamType.CdReduc, ParamType.CritCh, ParamType.CritDmg,

    ParamType.PDmg, ParamType.ASpd, ParamType.Armor,
    ParamType.PDmgReduc, ParamType.Health, ParamType.Regen,

    ParamType.MDmg, ParamType.CSpd, ParamType.Resist,
    ParamType.MDmgReduc, ParamType.Mana, ParamType.Recov,
}

---@param self InterfaceFrameBag
function private.updatePositions(self)
    local priv = private.data[self]

    local count = 0
    for i = 1, #priv.used_util do
        local row, mod = math.modf(count / 2)

        local param = priv.param[priv.used_util[i]]
        local point = mod == 0 and FRAMEPOINT_TOPLEFT or FRAMEPOINT_TOPRIGHT
        param:setVisible(true)
        param:setPoint(point, point, 0, row * private.param_height)
        count = count + 1
    end

    for i = 1, #private.params_queue do
        local param_type = private.params_queue[i]
        if isMagic(param_type) or isPhysic(param_type) then
            priv.param[param_type]:setVisible(false)
        end
    end

    if #priv.used_magic == 0 and #priv.used_phys == 0 then
        priv.magic_text:setVisible(false)
        priv.phys_text:setVisible(false)
        return
    end

    local y_offset = math.modf(count) + 1
    local text_y = y_offset * private.param_height
    priv.magic_text:setVisible(true)
    priv.magic_text:setPoint(FRAMEPOINT_TOPRIGHT, FRAMEPOINT_TOPRIGHT, 0, text_y)
    priv.phys_text:setVisible(true)
    priv.phys_text:setPoint(FRAMEPOINT_TOPLEFT, FRAMEPOINT_TOPLEFT, 0, text_y)

    for i = 1, #priv.used_phys do
        local param = priv.param[priv.used_phys[i]]
        param:setVisible(true)
        param:setPoint(FRAMEPOINT_TOPLEFT, FRAMEPOINT_TOPLEFT, 0, text_y + i * private.param_height)
    end

    for i = 1, #priv.used_magic do
        local param = priv.param[priv.used_phys[i]]
        param:setVisible(true)
        param:setPoint(FRAMEPOINT_TOPRIGHT, FRAMEPOINT_TOPRIGHT, 0, text_y + i * private.param_height)
    end

    FramePublic.setSize(2 * private.param_width,
                        y_offset + (math.max(#priv.used_phys, #priv.used_magic) + 1) * private.param_height)
end

-- Frame type
do
    local name = private.name
    private.frame_type = SimpleButtonType.new(name, true)
    private.frame_type:setWidth(0.01)
    private.frame_type:setHeight(0.01)
        local background = SimpleTextureType.new(name..'Background', false)
        background:setAllPoints()

        local magicText = SimpleStringType.new(name..'MagicText', false)
        magicText:setAnchor('TOPRIGHT', 0 , 0)
        magicText:setFont(private.default_font, private.default_font_size)
        magicText:setText('Magical')

        local physText = SimpleStringType.new(name..'PhysText', false)
        physText:setAnchor('TOPLEFT', 0 , 0)
        physText:setFont(private.default_font, private.default_font_size)
        physText:setText('Physical')

    private.frame_type:setChildrens({background, magicText, physText})
end

---@param self InterfaceFrameParamTable
function private.newData(self)
    local priv = {
        background = BlzGetFrameByName(private.name..'Background', 0),
        magic_text = BlzGetFrameByName(private.name..'MagicText', 0),
        phys_text = BlzGetFrameByName(private.name..'PhysText', 0),
        param = {},

        show_all = false,
        used_util = {},
        used_phys = {},
        used_magic = {},
    }
    private.data[self] = priv

    for _, param_type in pairs(ParamType) do
        local value = IconValue.new()
        value:setSize(private.param_width, private.param_height)
        value:setIcon(ParameterAPI.getIcon(param_type))
        value:setVisible(false)

        priv.param[param_type] = value
    end
end

return static