--=========
-- Include
--=========

local Class = require('utils.Class.Class')

--=======
-- Class
--=======

local Action = Class.new('Action')
---@class Action
local public = Action.public
---@class ActionClass
local static = Action.static
---@type ActionClass
local override = Action.override
local private = {}

--========
-- Static
--========

---@alias Callback fun():any

---@param callback Callback
---@param owner any
---@param child_insatnce Action | nil
---@return Action
function static.new(callback, owner, child_insatnce)
    local instance = child_insatnce or Class.allocate(Action)
    private.newData(instance, callback, owner)

    return instance
end

function static.getRunningAction()
end

--========
-- Public
--========

local savetyRun = savetyRun
---@return any
function public:run()
    local prev = static.getRunningAction
    static.getRunningAction = function() return self end
    local res = savetyRun(private.data[self].callback)
    static.getRunningAction = prev
    return res
end

---@return any
function public:getOwner()
    return private.data[self].owner
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Action
---@param callback Callback
function private.newData(self, callback, owner)
    local priv = {
        callback = callback,
        owner = owner
    }
    private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(self) end
}

return static