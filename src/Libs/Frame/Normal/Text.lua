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

---@type FdfTextClass
local FdfText = require(lib_path..'Fdf.Normal.Text') or error('')

--=======
-- Class
--=======

local FrameNormalText = Class.new('FrameNormalText', Frame)
---@class FrameNormalText : Frame
local public = FrameNormalText.public
---@class FrameNormalTextClass : FrameClass
local static = FrameNormalText.static
---@type FrameNormalTextClass
local override = FrameNormalText.override
local private = {}

--=========
-- Static
--=========

---@param child FrameNormalText | nil
---@return FrameNormalText
function override.new(child)
    if child then isTypeErr(child, FrameNormalText, 'child') end

    local fdf = private.fdf
    local instance = child or Class.allocate(FrameNormalText)
    instance = Frame.new(fdf:getName(), fdf:isSimple())

    private.newData(instance)

    return instance
end

---@param handle framehandle
---@param child FrameNormalText
---@return FrameNormalText
function override.link(handle, child)
    isTypeErr(handle, 'framehandle', 'handle')
    if child then isTypeErr(child, FrameNormalText, 'child') end

    local instance = child or Class.allocate(FrameNormalText)
    instance = Frame.link(handle, true, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param text string
function public:setText(text)
    BlzFrameSetText(self:getData(), text)
end

--=========
-- Private
--=========

private.fdf = FdfText.new('FrameNormalTextDefault')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
private.fdf:setFont('fonts\\nim_____.ttf', 0.008)
private.fdf:setJustification('JUSTIFYCENTER', 'JUSTIFYMIDDLE')

return static