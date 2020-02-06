--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

--=======
-- Class
--=======

local Object = Class.new('Object')
---@class Object
local public = Object.public
---@class ObjectClass
local static = Object.static
---@type ObjectClass
local override = Object.override
local private = {}

--=========
-- Static
--=========

---@param child_instance Object | nil
---@return Object
function static.new(child_instance)
    if not child_instance then
        Log.error(Object, 'can not create instance of abstract class.', 2)
    end

    local instance = child_instance
    return instance
end

--========
-- Public
--========

function public:getObj()
    Log.error(Object, 'can not call virtual function.', 2)
end

function public:destroy()
    Log.error(Object, 'can not call virtual function.', 2)
end

return static