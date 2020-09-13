--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsFunctions
local Functions = require(lib_path..'Functions') or error('')
local isTypeErr = Functions.isTypeErr or error('')
---@type UtilsSettings
local Settings = require(lib_path..'Settings') or error('')
local Log = Settings.default_logger or error('')

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
---@param child Action | nil
---@return Action
function override.new(callback, owner, child)
    isTypeErr(callback, 'function', 'callback')
    if child then isTypeErr(child, 'Action', 'child') end

    local instance = child or Class.allocate(Action)
    private.newData(instance, callback, owner)

    return instance
end

--========
-- Public
--========

---@return any
function public:run(...)
    if Settings.debug then
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