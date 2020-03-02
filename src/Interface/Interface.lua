---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButton = FrameAPI.SimpleButton
local SimpleButtonActionType = FrameAPI.SimpleButtonEvent
---@type InterfaceInventoryBag
local InterfaceBag = require('Interface.Frame.Bag')
---@type ScreenUpdater
local Screen = require('Frame.Screen')
---@type InterfaceAbilityCastingBarClass
--local CastingBar = require('Interface.Ability.CastingBar')
---@type InterfaceAbilityBarClass
--local AbilityBar = require('Interface.Ability.Bar')
---@type UnitAPI
local UnitAPI = require('Unit.API')
---@type InterfaceItemSlotClass
local ItemSlot = require('Interface.Frame.Button')

---@class Interface
local Interface = {}

local bag_btn
local bag

function Interface.init()
    bag_btn = SimpleButton.new()
    bag_btn:setSize(0.05, 0.05)
    bag_btn:setTexture('')
    bag_btn:setPoint(FRAMEPOINT_BOTTOMRIGHT, FRAMEPOINT_BOTTOMRIGHT, Screen.getRealWidth(), 0)

    bag = InterfaceBag.new()
    bag:setParent(bag_btn)
    bag:setPoint(FRAMEPOINT_BOTTOMRIGHT, FRAMEPOINT_TOPLEFT, 0, 0)

    bag_btn:addAction(SimpleButtonActionType.MousePress, function() bag:setVisible(not bag:isVisible()) end)

--[[
    Interface.Inventory = Inventory.new()
    Interface.Inventory:setWidth(0.3)
    Interface.Inventory:setHeight(0.3)
    Interface.Inventory:setX(Screen.getRealZeroX() + Screen.getRealWidth() - Interface.Inventory:getWidth())
    Interface.Inventory:setY(0.2)

    Interface.CastingBar = CastingBar.new(1)
    Interface.CastingBar:setX(0.3)
    Interface.CastingBar:setY(0.045)
    Interface.CastingBar:setWidth(0.2)
    Interface.CastingBar:setHeight(0.02)

    Interface.AbilityBar = AbilityBar.new(10, 1)
    Interface.AbilityBar:setX(0.175)
    Interface.AbilityBar:setY(0.0)
    Interface.AbilityBar:setWidth(0.45)
    Interface.AbilityBar:setHeight(0.045)
]]
end

---@return InterfaceInventoryBag
function Interface.getBag()
    return bag
end

return Interface