--=========
-- Include
--=========

local Class = require('Utils.Class.API')

--=======
-- Class
--=======

local Controller3rdPerson = Class.new('Controller3rdPerson')
---@class Controller3rdPerson
local public = Controller3rdPerson.public
---@class Controller3rdPersonClass
local static = Controller3rdPerson.static
---@type Controller3rdPersonClass
local override = Controller3rdPerson.override
local private = {}

--=========
-- Static
--=========

---@param child_instance Controller3rdPerson | nil
---@return Controller3rdPerson
function override.new(child_instance)
    local instance = child_instance or Class.allocate(Controller3rdPerson)
    private.newData(instance)

    return instance
end

--========
-- Public
--========



--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Controller3rdPerson
function private.newData(self)
    local priv = {
    }
    private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(self) end
}

return static