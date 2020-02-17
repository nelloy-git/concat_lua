--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

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

---@alias Callback fun(vararg:any[]):any

---@param callback Callback
---@param owner any
---@param child_instance Action | nil
---@return Action
function static.new(callback, owner, child_instance)
    if type(callback) ~= 'function' then
        Log(Log.Err, Action, 'got nil callback.')
    end
    local instance = child_instance or Class.allocate(Action)
    private.newData(instance, callback, owner)

    return instance
end

--========
-- Public
--========

function public:run(...)
    if private.debug then
        local success, result = pcall(private.data[self].callback, ...)
        if success then
            return result
        else
            Log(Log.Err, '', result)
        end
    else
        return private.data[self].callback(...)
    end
end

---@return any
function public:getOwner()
    return private.data[self].owner
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.debug = true

---@param self Action
---@param callback Callback
---@param owner any
function private.newData(self, callback, owner)
    local priv = {
        callback = callback,
        owner = owner
    }
    private.data[self] = priv
end

return static