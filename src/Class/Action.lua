--=======
-- Class
--=======

---@type ActionClass
local Action = newClass('Action')

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

---@param callback fun(userdata:any):nil
---@param instance_data table|nil
---@return Action
function static.new(callback, instance_data)
    local instance = instance_data or newInstanceData(Action)
    local priv = {
        ---@type fun(userdata:any):nil
        callback = callback,
        ---@type any
        userdata = userdata
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
end

function public:run()
    local priv = private[self]
    priv.callback(priv.userdata)
end

return Action