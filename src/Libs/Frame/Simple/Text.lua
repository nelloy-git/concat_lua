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

---@type FdfSimpleFrameClass
local FdfSimpleFrame = require(lib_path..'Fdf.Simple.Frame') or error('')
---@type FdfSimpleStringClass
local FdfSimpleString = require(lib_path..'Fdf.Simple.String') or error('')

---@type FrameSimpleStringClass
local FrameSimpleString = require(lib_path..'Simple.String') or error('')

--=======
-- Class
--=======

local FrameSimpleText = Class.new('FrameSimpleText', Frame)
---@class FrameSimpleText : Frame
local public = FrameSimpleText.public
---@class FrameSimpleTextClass : FrameClass
local static = FrameSimpleText.static
---@type FrameSimpleTextClass
local override = FrameSimpleText.override
local private = {}

--=========
-- Static
--=========

---@param child FrameSimpleText | nil
---@return FrameSimpleText
function override.new(child)
    if child then isTypeErr(child, FrameSimpleText, 'child') end

    local instance = child or Class.allocate(FrameSimpleText)
    instance = newFrame(private.fdf, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param text string
 function public:setText(text)
    private.data[self].string:setText(text)
 end

---@param font string
---@param size number
---@param flags number | nil
function public:setFont(font, size, flags)
    private.data[self].string:setFont(font, size, flags)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf_name = 'FrameSimpleText'
private.fdf_string_name = 'FrameSimpleTextString'

private.fdf = FdfSimpleFrame.new(private.fdf_name)
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.01)
    local fdf_string = FdfSimpleString.new(private.fdf_string_name)
    fdf_string:setFont('fonts\\nim_____.ttf', 0.008)
private.fdf:addSubframe(fdf_string)
---@param self FrameSimpleText
function private.newData(self)
    local priv = {
        string = FrameSimpleString.new(BlzGetFrameByName(private.fdf_string_name, 0)),
    }
    private.data[self] = priv
end

return static