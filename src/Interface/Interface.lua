---@type InterfaceItemBag
local InterfaceItemBag = require('Interface.Item.Bag')
---@type ScreenUpdater
local Screen = require('Frame.Screen')

---@class Interface
local Interface = {}

if not IsCompiletime() then
    Interface.Bag = InterfaceItemBag.new(5, 4)
    Interface.Bag:setWidth(0.2)
    Interface.Bag:setHeight(0.16)
    Interface.Bag:setX(Screen.getRealZeroX() + Screen.getRealWidth() - 0.2)
    Interface.Bag:setY(0)

    InterfaceBag = Interface.Bag
end

return Interface