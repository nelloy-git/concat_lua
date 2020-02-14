require('Utils.Globals')

--local Log = require('Utils.Log')

---@type UnitClass
local Unit = require('Unit.Unit')
---@type UnitAnimationClass
local Animation = require('Unit.Animation')
---@type UnitTypeClass
local UnitType = require('Unit.Type')
---@type ParameterAPI
local ParamAPI = require('Parameter.API')

---@type AbilityType
local ExampleAbility = require('Ability.Example')

local footman_type = UnitType.new('Footman', UnitType.UnitTypeClassification.Unit)

---@type ItemAPI
local ItemAPI = require('Item.API')
local it_model_type = ItemAPI.newItemModelType('Test', ItemAPI.ItemModelType.POWER_UP)

---@type InterfaceAPI
local InterfaceAPI = require('Interface.API')

---@type Unit
--u = nil
---@type Unit
--u2 = nil
if not IsCompiletime() then
    --local frame = GlueButton.new(btn_type)
    --frame:setX(0.3)
    --frame:setY(0.3)
    --frame:setWidth(0.05)
    --frame:setHeight(0.05)
--
    --print(BlzFrameGetWidth(frame:getFramehandle()), BlzFrameGetHeight(frame:getFramehandle()))
--
    --frame:setTexture('ReplaceableTextures\\CommandButtons\\BTNHeroPaladin')
    --frame:setPushedTexture('ReplaceableTextures\\CommandButtons\\DISBTNHeroPaladin')

    ---@type Unit
    u = Unit.new(Player(0), footman_type:getId(), -200, -500, 0)
    UnitAddAbility(u:getObj(), ExampleAbility:getId())
    u.Animation:add(Animation.AnimationType.WALK, 6)
    u.Animation:add(Animation.AnimationType.STAND, 0)
    --print(Param.ParamType.Health)
    --u.Param:set(Param.ParamType.Health, Param.ValueType.BASE, 1000)
    
    u2 = Unit.new(Player(1), 'hfoo', 0, 0, 0)
    --UnitAddAbility(u:getObj(), ExampleAbility:getId())
    --u2:destroy()
    --u2.Param:set(Param.ParamType.Health, Param.ValueType.BASE, 1000)

    --u2 = nil

    it = ItemAPI.newItem()
    it.Param:set(ParamAPI.ParamType.PDmg, ParamAPI.ValueType.BASE, 10)
    it.Param:set(ParamAPI.ParamType.PDmg, ParamAPI.ValueType.MULT, 0.1)
    it.Param:set(ParamAPI.ParamType.Armor, ParamAPI.ValueType.ADDIT, 5)

    it_model = ItemAPI.newItemModel(it_model_type, 0, 0)

    it:setModel(it_model)

    InterfaceAPI.init()
    InterfaceAPI.target = u

    --it2 = ItemAPI.newItem(0, 0)
    --it3 = ItemAPI.newItem(0, 0)

    --ItemFrame.new(0.4, 0.3, 0.1, 0.1)
end


--print(btn:getControlDisabledName())
