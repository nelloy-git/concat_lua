--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Obj
local Obj = require(__TimerLib..'Obj')

--=======
-- Class
--=======

local TriggerObj = Class.new('TriggerObj', Obj)
---@class TriggerObj : Obj
local public = TriggerObj.public
---@class TriggerObjClass : ObjClass
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
    instance = Obj.new(obj, DestroyTrigger, instance)

    return instance
end

return static