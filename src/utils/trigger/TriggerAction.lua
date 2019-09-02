---@class TriggerAction
local TriggerAction = {}
local TriggerAction_meta = {
    __index = TriggerAction,
    __gc = TriggerAction.destroy
}

---@param callback fun()
---@param data any
---@return TriggerAction
function TriggerAction.new(callback, data)
    ---@type TriggerAction
    local action = {
        __callback = callback,
        __data = data
    }
    setmetatable(action, TriggerAction_meta)
    return  action
end

function TriggerAction:destroy()
    self.__callback = nil
    self.__data = nil
end

function TriggerAction:run()
    self.__callback(self.__data)
end

---@return fun()
function TriggerAction:getCallback()
    return self.__callback
end

---@return any
function TriggerAction:getData()
    return self.__data
end

return TriggerAction