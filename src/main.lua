require('Utils.Globals')

---@type UnitAPI
local UnitAPI = require('Unit.API')
local UnitType = UnitAPI.Type
local UnitTypeClass = UnitAPI.UnitTypeClass
local Unit = UnitAPI.Unit

---@type ItemAPI
ItemAPI = require('Item.API')
---@type InterfaceAPI
InterfaceAPI = require('Interface.API')
---@type ParameterAPI
ParamAPI = require('Parameter.API')

require('Event.Item')

footman_type = UnitType.new('Footman', UnitTypeClass.UNIT)

if not IsCompiletime() then
    u = Unit.new(footman_type, Player(0), -200, -500)
    --UnitAddAbility(u:getObj(), ExampleAbility:getId())
    --u.Animation:add(Animation.AnimationType.WALK, 6)
    --u.Animation:add(Animation.AnimationType.STAND, 0)
    --print(Param.ParamType.Health)
    --u.Param:set(Param.ParamType.Health, Param.ValueType.BASE, 1000)

    u2 = Unit.new(footman_type, Player(1), 0, 0)
    --UnitAddAbility(u:getObj(), ExampleAbility:getId())
    --u2:destroy()
    --u2.Param:set(Param.ParamType.Health, Param.ValueType.BASE, 1000)

    --u2 = nil

    it = ItemAPI.Item.new(ItemAPI.ItemType.BELT)
    it:getParameters():set(ParamAPI.ParamType.PDmg, ParamAPI.ValueType.BASE, 10)
    it:getParameters():set(ParamAPI.ParamType.PDmg, ParamAPI.ValueType.MULT, 0.1)
    it:getParameters():set(ParamAPI.ParamType.Armor, ParamAPI.ValueType.ADDIT, 5)

    it_model = ItemAPI.ItemModel.new(0, 0)
    it:setModel(it_model)

    InterfaceAPI.init()
    InterfaceAPI.Bag:loadBag(u.Bag)

    --it2 = ItemAPI.newItem(0, 0)
    --it3 = ItemAPI.newItem(0, 0)

    --ItemFrame.new(0.4, 0.3, 0.1, 0.1)
end


--print(btn:getControlDisabledName())
