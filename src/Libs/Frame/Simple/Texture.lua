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
local Log = UtilsLib.Log or error('')

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

---@param name string
---@param child FrameSimpleTexture | nil
---@return FrameSimpleTexture
function override.new(name, child)
    Log:err(tostring(FrameSimpleTexture)..': can not be created manually.')
end

---@param handle framehandle
---@param child FrameSimpleTexture | nil
---@return FrameSimpleTexture
function override.link(handle, child)
    isTypeErr(handle, 'framehandle', 'handle')
    if child then isTypeErr(child, FrameSimpleTexture, 'child') end

    local instance = child or Class.allocate(FrameSimpleTexture)
    instance = Frame.link(handle, true, instance)

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