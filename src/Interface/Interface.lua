---@class Interface
local Interface = {}

if not IsCompiletime() then
    InterfaceItemBag = InterfaceItemBag or require('Interface.Item.Bag')
    Interface.Bag = InterfaceItemBag.new(5, 4)
    Interface.Bag:setWidth(0.2)
    Interface.Bag:setHeight(0.16)
end

return Interface