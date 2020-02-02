--=========
-- Include
--=========

local Class = require('utils.Class.Class')

--=======
-- Class
--=======

local className = Class.new('className')
---@class className
local public = className.public
---@class classNameClass
local static = className.static
---@type classNameClass
local override = className.override
local private = {}

--=========
-- Static
--=========

---@param child_instance className | nil
---@return className
function static.new(child_instance)
    local instance = child_instance or Class.allocate(className)
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

---@param instance className
function private.newData(instance)
    local priv = {
    }
    private.data[instance] = setmetatable(priv, private.metadata)
end

private.metatable = {
    __gc = function(self) end
}

return static