---@type InterfaceInventoryClass
--local Inventory = require('Interface.Inventory')
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

Interface.target = nil

function Interface.init()
    local test = ItemSlot.new()
    test:setX(0.4)
    test:setY(0.3)
    --test:setWidth(0.05)
    --test:setHeight(0.05)
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

--- Should be used async.
---@param unit Unit
function Interface.setTarget(unit)
    if Interface.target ~= unit then
        Interface.target = unit
        Interface.Inventory:load(unit)
        Interface.AbilityBar:load(unit)
    end
end

--- Async
---@return Unit
function Interface.getTarget()
    return Interface.target
end

return Interface