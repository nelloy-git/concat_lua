--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkTypeErr = Functions.checkTypeErr
---@type ActionClass
local Action = require(lib_modname..'.Action')
--endregion

--=======
-- Class
--=======

local ActionList = Class.new('ActionList')
--region Class
---@class ActionList : Handle
local public = ActionList.public
---@class ActionListClass : HandleClass
local static = ActionList.static
---@type ActionListClass
local override = ActionList.override
local private = {}
--endregion

--========
-- Static
--========

---@param child_instance ActionList | nil
---@return ActionList
function override.new(child_instance)
    if child_instance then checkTypeErr(child_instance, ActionList, 'child_instance') end

    local instance = child_instance or Class.allocate(ActionList)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param callback Callback
---@return Action
function public:add(callback)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.actions, action)

    return action
end

---@param action Action
---@return boolean
function public:remove(action)
    checkTypeErr(action, Action, 'action')
    if action:getOwner() ~= self then return false end

    local priv = private.data[self]
    for i = 1, #priv.actions do
        if priv.actions[i] == action then
            table.remove(priv.actions, i)
            return true
        end
    end

    return false
end

---@return number
function public:count()
    return #private.data[self].actions
end

--- Remove all actions from list.
function public:clear()
    private.data[self].actions = {}
end

--- Run all actions.
function public:run(...)
    local priv = private.data[self]

    for i = 1, #priv.actions do
        priv.actions[i]:run(...)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ActionList
function private.newData(self)
    local priv = {
        actions = {}
    }
    private.data[self] = priv
end

return static