--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Obj
local Object = require(__TimerLib..'Obj')

--=======
-- Class
--=======

local FrameObj = Class.new('FrameObj', Object)
---@class FrameObj : Obj
local public = FrameObj.public
---@class FrameObjClass : ObjClass
local static = FrameObj.static
---@type FrameObjClass
local override = FrameObj.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param is_simple boolean
---@param child_instance FrameObj | nil
---@return FrameObj
function override.new(name, is_simple, child_instance)
    local instance = child_instance or Class.allocate(FrameObj)

    local obj
    if is_simple then
        obj = BlzCreateSimpleFrame(name, nil, 0)
    else
        obj = BlzCreateFrame(name, nil, 0, 0)
    end

    return Object.new(obj, BlzDestroyFrame, instance)
end

return static