---@type InterfaceBagClass
local Bag = require('Interface.Bag')
---@type InterfaceEquipmentClass
local Equip = require('Interface.Equipment')
---@type ScreenUpdater
local Screen = require('Frame.Screen')
---@type SelectionControllerClass
local Selection = require('Controller.Selection')
---@type UnitAPI
local UnitAPI = require('Unit.API')

---@class Interface
local Interface = {}

local target = nil

local function selectTarget(player, selected, unit)
    unit = UnitAPI.Unit.getInstance(unit)
    if selected and player == GetLocalPlayer() then
        Interface.setTarget(unit, player)
    end
end

if not IsCompiletime() then
    Interface.Bag = Bag.new(5, 4)
    Interface.Bag:setWidth(0.2)
    Interface.Bag:setHeight(0.16)
    Interface.Bag:setX(Screen.getRealZeroX() + Screen.getRealWidth() - 0.2)
    Interface.Bag:setY(0.2)

    Bag = Interface.Bag

    Interface.Equipment = Equip.new()
    Interface.Equipment:setWidth(0.1)
    Interface.Equipment:setHeight(0.18)
    Interface.Equipment:setX(Screen.getRealZeroX() + Screen.getRealWidth() - 0.2)
    Interface.Equipment:setY(0.36)

    ---@param unit Unit
    function Interface.setTarget(unit, player)
        if player == GetLocalPlayer() and target ~= unit then
            target = unit
            Interface.Bag:load(unit.Bag)
            Interface.Equipment:load(unit.Equipment)
        end
    end

    --- Async
    ---@return Unit
    function Interface.getTarget()
        return target
    end

    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        Selection.addAction(Player(i), true, selectTarget)
    end
end

return Interface