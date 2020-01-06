--=========
-- Include
--=========

local Class = require('utils.Class')

--=======
-- Class
--=======

local Action = Class.newClass('Action')
---@class Action
local public = Action.public
---@class ActionClass
local static = Action.static
local override = Action.override
local private = {}

--========
-- Static
--========

---@alias Callback fun():any

---@param callback Callback
---@param child_data Action | nil
---@return Action
function static.new(callback, child_data)
    local instance = Class.newInstanceData(Action, child_data)
    local priv = {
        callback = callback,
    }
    private[instance] = priv

    return instance
end

--========
-- Public
--========

---@return any
function public:run()
    local priv = private[self]
    return savetyRun(priv.callback)
end

function public:free()
    private[self] = nil
    Class.freeInstanceData(self)
end

--=========
-- Private
--=========

---@param instance Action
---@param callback Callback
function private.newData(instance, callback)
    local priv = {
        callback = callback,
    }
    private[instance] = priv
end

function private.freeData(self)
    private[self] = nil
end

return Action