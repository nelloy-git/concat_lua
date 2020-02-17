---@type InterfaceBagClass
local InterfaceBag = require('Interface.Bag.Bag')
---@type InterfaceEquipmentClass
local InterfaceEquip = require('Interface.Equipment.Equipment')
---@type ScreenUpdater
local Screen = require('Frame.Screen')

---@class Interface
local Interface = {}

if not IsCompiletime() then
    Interface.Bag = InterfaceBag.new(5, 4)
    Interface.Bag:setWidth(0.2)
    Interface.Bag:setHeight(0.16)
    Interface.Bag:setX(Screen.getRealZeroX() + Screen.getRealWidth() - 0.2)
    Interface.Bag:setY(0.2)

    InterfaceBag = Interface.Bag

    Interface.Equipment = InterfaceEquip.new()
    Interface.Equipment:setWidth
end

return Interface