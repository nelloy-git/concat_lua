--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type Object
local Object = require('Object.Object')

local ID = ID

--=======
-- Class
--=======

local FrameObj = Class.new('FrameObj', Object)
---@class FrameObj : Object
local public = FrameObj.public
---@class FrameObjClass : ObjectClass
local static = FrameObj.static
---@type FrameObjClass
local override = FrameObj.override
local private = {}

--=========
-- Static
--=========

local gameui
if not IsCompiletime() then
    gameui = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

---@param name string
---@param is_simple boolean
---@param child_instance FrameObj | nil
---@return FrameObj
function override.new(name, is_simple, child_instance)
    local instance = child_instance or Class.allocate(FrameObj)

    local obj
    if is_simple then
        obj = BlzCreateSimpleFrame(name, gameui, 0)
    else
        obj = BlzCreateFrame(name, gameui, 0, 0)
    end

    -- TODO error if exit game without waiting
    --instance = Object.new(obj, BlzDestroyFrame, instance)
    instance = Object.new(obj, function() end, instance)

    return instance
end

return static