--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type FrameUtils
local FrameUtils = require(lib_path..'Utils') or error('')
local newFrame = FrameUtils.newFrameFromFdf or error('')

--=======
-- Class
--=======

local FrameSimpleString = Class.new('FrameSimpleString', Frame)
---@class FrameSimpleString : Frame
local public = FrameSimpleString.public
---@class FrameSimpleStringClass : FrameClass
local static = FrameSimpleString.static
---@type FrameSimpleStringClass
local override = FrameSimpleString.override
local private = {}

--=========
-- Static
--=========

---@param handle framehandle
---@param child FrameSimpleString | nil
---@return FrameSimpleString
function override.new(handle, child)
    isTypeErr(handle, 'framehandle', 'handle')
    if child then isTypeErr(child, FrameSimpleString, 'child') end

    local instance = child or Class.allocate(FrameSimpleString)
    instance = Frame.new(handle, instance)

    return instance
end

--========
-- Public
--========

---@param text string
function public:setText(text)
    BlzFrameSetText(self:getData(), text)
end

---@param font string
---@param size number
---@param flags number | nil
function public:setFont(font, size, flags)
    BlzFrameSetFont(self:getData(), font, size, flags or 0)
end

--=========
-- Private
--=========

return static