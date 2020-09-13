--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type FrameUtils
local FrameUtils = require(lib_path..'Utils') or error('')
local newFrame = FrameUtils.newFrameFromFdf or error('')

--=======
-- Class
--=======

local FrameSimpleTexture = Class.new('FrameSimpleTexture', Frame)
---@class FrameSimpleTexture : Frame
local public = FrameSimpleTexture.public
---@class FrameSimpleTextureClass : FrameClass
local static = FrameSimpleTexture.static
---@type FrameSimpleTextureClass
local override = FrameSimpleTexture.override
local private = {}

--=========
-- Static
--=========

---@param handle framehandle
---@param child FrameSimpleTexture | nil
---@return FrameSimpleTexture
function override.new(handle, child)
    isTypeErr(handle, 'framehandle', 'handle')
    if child then isTypeErr(child, FrameSimpleTexture, 'child') end

    local instance = child or Class.allocate(FrameSimpleTexture)
    instance = Frame.new(handle, instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setTexture(tex_file, flag, blend)
    BlzFrameSetTexture(self:getData(), tex_file, flag, blend)
end

--=========
-- Private
--=========

return static