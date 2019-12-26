--=======
-- Class
--=======

---@type any
local Action = Class.newClass('Action')

---@class Action
local public = Action.public
---@class ActionClass
local static = Action.static
---@type table
local override = Action.override
---@type table(DataBase, table)
local private = {}

--=========
-- Methods
--=========

---@param callback fun():any
---@param instance_data table|nil
---@return Action
function static.new(callback, instance_data)
    local instance = instance_data or Class.newInstanceData(Action)
    local priv = {
        callback = callback,
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    freeInstanceData(self)
end

---@return any
function public:run()
    local priv = private[self]
    return savetyRun(priv.callback)
end

return Action