---@type InterfaceInventoryClass
local Inventory = require('Interface.Inventory')
---@type ScreenUpdater
local Screen = require('Frame.Screen')
---@type SelectionControllerClass
local Selection = require('Controller.Selection')
---@type UnitAPI
local UnitAPI = require('Unit.API')

---@class Interface
local Interface = {}

local target = nil
local local_player = nil

local function selectTarget(player, selected, unit)
    unit = UnitAPI.Unit.getInstance(unit)
    if selected and player == local_player then
        Interface.setTarget(unit, player)
    end
end

if not IsCompiletime() then
    local_player = GetLocalPlayer()

    Interface.Inventory = Inventory.new()
    Interface.Inventory:setX(Screen.getRealZeroX() + Screen.getRealWidth() - 0.2)
    Interface.Inventory:setY(0.2)
    Interface.Inventory:setWidth(0.2)
    Interface.Inventory:setHeight(0.3)

    ---@param unit Unit
    function Interface.setTarget(unit, player)
        if player == local_player and target ~= unit then
            target = unit
            Interface.Inventory:load(unit)
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