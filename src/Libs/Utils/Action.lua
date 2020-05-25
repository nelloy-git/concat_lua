--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type LoggerClass
local Logger = require(__UtilsLib..'Logger')
local Log = Logger.getDefault()
---@type UtilsFunctions
local Functions = require(__UtilsLib..'Functions')
local checkType = Functions.checkType

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
function override.new(callback, owner, child_instance)
    checkType(callback, 'function', 'callback')
    checkType(owner, 'player', 'owner')
    if child_instance then
        checkType(child_instance, 'Action', 'child_instance')
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
            Log:err(result)
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