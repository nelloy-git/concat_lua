---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButton = FrameAPI.SimpleButton
local SimpleButtonEvent = FrameAPI.SimpleButtonEvent
---@type InterfaceFrameBag
local InterfaceBag = require('Interface.Frame.Bag')
---@type InterfaceFrameEquipment
local InterfaceEquipment = require('Interface.Frame.Equipment')
---@type InterfaceFrameIconValueClass
local InterfaceIconValue = require('Interface.Frame.IconValue')
---@type ScreenUpdater
local Screen = require('Frame.Screen')
---@type InterfaceFrameButtonClass
local Button = require('Interface.Frame.Button')
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

local inventory_btn
local bag
local equipment

function Interface.init()
    inventory_btn = Button.new()
    inventory_btn:setIcon('ReplaceableTextures\\CommandButtons\\BTNDust')
    inventory_btn:setPoint(FRAMEPOINT_BOTTOMRIGHT, FRAMEPOINT_BOTTOMLEFT,
                     Screen.getRealZeroX() + Screen.getRealWidth(), 0)

    bag = InterfaceBag.new()
    bag:setTexture('')
    bag:setColumns(8)
    bag:setVisible(true)
    bag:setParent(inventory_btn)
    bag:setPoint(FRAMEPOINT_BOTTOMRIGHT, FRAMEPOINT_TOPLEFT, 0, 0)
    inventory_btn:addAction(SimpleButtonEvent.MousePress, function() bag:setVisible(not bag:isVisible()) end)

    equipment = InterfaceEquipment.new()
    equipment:setTexture('')
    equipment:setParent(bag)
    equipment:setVisible(true)
    equipment:setPoint(FRAMEPOINT_BOTTOMRIGHT, FRAMEPOINT_TOPRIGHT, 0, 0)
    --inventory_btn:addAction(SimpleButtonEvent.MousePress, function() equipment:setVisible(not equipment:isVisible()) end)

    --bag_btn:addAction(SimpleButtonEvent.MousePress, function() print('azaza') end)
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

---@return InterfaceFrameBag
function Interface.getBag()
    return bag
end

---@return InterfaceFrameBag
function Interface.getEquipment()
    return equipment
end

return Interface