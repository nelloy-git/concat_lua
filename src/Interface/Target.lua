---@type ActionClass
local Action = require('Utils.Action')

---@class InterfaceTarget
local InterfaceTarget = {}

local target = nil
local actions = {}
local local_player
if not IsCompiletime() then
    local_player = GetLocalPlayer()
end

--- Applies for local player only
---@param unit Unit
function InterfaceTarget.setTarget(unit, player)
    if player == local_player then
        target = unit
        for i = 1, #actions do
            actions[i]:run()
        end
    end
end

--- Returns target for local player.
---@return Unit
function InterfaceTarget.getTarget()
    return target
end

---@param callback fun()
---@return Action
function InterfaceTarget.addOnTargetChangeAction(callback)
    local action = Action.new(callback, InterfaceTarget)
    table.insert(actions, action)
    return action
end

---@param action Action
---@return boolean
function InterfaceTarget.removeOnChangeTargetAction(action)
    for i = 1, #actions do
        if action == actions[i] then
            table.remove(actions, i)
            return true
        end
    end
    return false
end

return InterfaceTarget