--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type ActionClass
local Action = require('Utils.Action')

--=======
-- Class
--=======

local ActionList = Class.new('ActionList')
---@class ActionList
local public = ActionList.public
---@class ActionListClass
local static = ActionList.static
---@type ActionListClass
local override = ActionList.override
local private = {}

--=========
-- Static
--=========

---@param child_instance ActionList | nil
---@return ActionList
function override.new(child_instance)
    local instance = child_instance or Class.allocate(ActionList)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param callback fun(vararg:any)
---@return Action
function public:add(callback)
    local action = Action.new(callback, self)
    table.insert(private.data[self].list, action)
    return action
end

---@param action Action
function public:remove(action)
    if action:getOwner() ~= self then
        Log.error(self, 'list is not an owner of removing action.', 2)
    end

    local list = private.data[self].list
    for i = 1, #list do
        if list[i] == action then
            table.remove(list, i)
            return true
        end
    end
    return false
end

function public:run(...)
    local list = private.data[self].list
    for i = 1, #list do
        list[i]:run(...)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ActionList
function private.newData(self)
    local priv = {
        list = {}
    }
    private.data[self] = priv
end

return static