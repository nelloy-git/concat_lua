--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr

---@type FrameSimpleBaseClass
local FrameSimpleBase = require(lib_modname..'.Simple.Base')

--=======
-- Class
--=======

local FrameSimpleTexture = Class.new('FrameSimpleTexture', FrameSimpleBase)
---@class FrameSimpleTexture : FrameBase
local public = FrameSimpleTexture.public
---@class FrameSimpleTextureClass : FrameBaseClass
local static = FrameSimpleTexture.static
---@type FrameSimpleTextureClass
local override = FrameSimpleTexture.override
local private = {}

--=========
-- Static
--=========

---@param handle framehandle
---@param child_instance FrameSimpleTexture | nil
---@return FrameSimpleTexture
function override.new(handle, child_instance)
    checkTypeErr(handle, 'framehandle', 'handle')
    if child_instance then
        checkTypeErr(child_instance, FrameSimpleTexture, 'child_instance')
    end

    local instance = child_instance or Class.allocate(FrameSimpleTexture)
    instance = FrameSimpleBase.new(handle, instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setFile(tex_file, flag, blend)
    BlzFrameSetTexture(self:getHandleData(), tex_file, flag, blend)
end

--=========
-- Private
--=========

return static