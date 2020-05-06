--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Object
local Object = require('Object.Object')

local ID = ID

--=======
-- Class
--=======

local TriggerObj = Class.new('TriggerObj', Object)
---@class TriggerObj : Object
local public = TriggerObj.public
---@class TriggerObjClass : ObjectClass
local static = TriggerObj.static
---@type TriggerObjClass
local override = TriggerObj.override
local private = {}

--=========
-- Static
--=========

---@param child_instance TriggerObj | nil
---@return TriggerObj
function override.new(child_instance)
    local instance = child_instance or Class.allocate(TriggerObj)

    local obj = CreateTrigger()
    instance = Object.new(obj, DestroyTrigger, instance)

    return instance
end

return static