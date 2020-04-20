--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type Object
local Object = require('Object.Object')

local ID = ID

--=======
-- Class
--=======

local TimerObj = Class.new('TimerObj', Object)
---@class TimerObj : Object
local public = TimerObj.public
---@class TimerObjClass : ObjectClass
local static = TimerObj.static
---@type TimerObjClass
local override = TimerObj.override
local private = {}

--=========
-- Static
--=========

local function destroy(obj)
    PauseTimer(obj)
    DestroyTimer(obj)
end

---@param child_instance TimerObj | nil
---@return TimerObj
function override.new(child_instance)
    local instance = child_instance or Class.allocate(TimerObj)

    local obj = CreateTimer()
    instance = Object.new(obj, destroy, instance)

    return instance
end

return static