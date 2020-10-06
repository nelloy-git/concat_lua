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

---@type FdfSimpleFrameClass
local FdfSimpleFrame = require(lib_path..'Fdf.Simple.Frame') or error('')
---@type FdfSimpleLayerClass
local FdfSimpleLayer = require(lib_path..'Fdf.Simple.Layer') or error('')
---@type FdfSimpleStatusBarClass
local FdfSimpleStatusBar = require(lib_path..'Fdf.Simple.StatusBar') or error('')
---@type FdfSimpleStringClass
local FdfSimpleString = require(lib_path..'Fdf.Simple.String') or error('')
---@type FdfTextureClass
local FdfSimpleTexture = require(lib_path..'Fdf.Simple.Texture') or error('')

---@type FrameSimpleStringClass
local FrameSimpleString = require(lib_path..'Simple.String') or error('')
---@type FrameSimpleTextureClass
local FrameSimpleTexture = require(lib_path..'Simple.Texture') or error('')

--=======
-- Class
--=======

local FrameSimpleStatusBar = Class.new('FrameSimpleStatusBar', Frame)
---@class FrameSimpleStatusBar : Frame
local public = FrameSimpleStatusBar.public
---@class FrameSimpleStatusBarClass : FrameClass
local static = FrameSimpleStatusBar.static
---@type FrameSimpleStatusBarClass
local override = FrameSimpleStatusBar.override
local private = {}

--=========
-- Static
--=========

---@param child FrameSimpleStatusBar | nil
---@return FrameSimpleStatusBar
function override.new(child)
    if child then isTypeErr(child, FrameSimpleStatusBar, 'child') end

    local fdf = private.fdf
    local instance = child or Class.allocate(FrameSimpleStatusBar)
    instance = Frame.new(fdf:getName(), fdf:isSimple(), instance)

    private.newData(instance)

    return instance
end

---@param handle framehandle
---@param child FrameSimpleStatusBar
---@return FrameSimpleStatusBar
function override.link(handle, child)
    isTypeErr(handle, 'framehandle', 'handle')
    if child then isTypeErr(child, FrameSimpleStatusBar, 'child') end

    local instance = child or Class.allocate(FrameSimpleStatusBar)
    instance = Frame.link(handle, true, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number | nil
---@param blend boolean | nil
function public:setBackground(tex_file, flag, blend)
    private.data[self].texture:setTexture(tex_file, flag or 0, blend or true)
end

---@param tex_file string
---@param flag number | nil
---@param blend boolean | nil
function public:setBar(tex_file, flag, blend)
    BlzFrameSetTexture(self:getData(), tex_file, flag or 0, blend or true)
end

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setBorder(tex_file, flag, blend)
    private.data[self].border:setTexture(tex_file, flag, blend)
end

---@param font string
---@param size number
---@param flags number | nil
function public:setFont(font, size, flags)
    private.data[self].string:setFont(font, size, flags)
end

---@param text string
 function public:setText(text)
    private.data[self].string:setText(text)
 end

 --- [0, 1]
 ---@param value number
 function public:setProgress(value)
    value = value < 0 and 0 or value > 1 and 0 or value
    BlzFrameSetValue(self:getData(), value * 100)
 end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf = FdfSimpleStatusBar.new('FrameSimpleStatusBar')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.01)
private.fdf:setBarTexture('Replaceabletextures\\Teamcolor\\Teamcolor00.blp')
    private.fdf_layer_back = FdfSimpleLayer.new('BACKGROUND')
        private.fdf_background = FdfSimpleTexture.new('FrameSimpleStatusBarTexture')
        private.fdf_background:setFile('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
    private.fdf_layer_back:addSubframe(private.fdf_background)
private.fdf:addSubframe(private.fdf_layer_back)
    private.fdf_forw = FdfSimpleFrame.new('FrameSimpleStatusBarForward')
    private.fdf_forw:setAllPoints(true)
        private.fdf_layer_forw = FdfSimpleLayer.new('ARTWORK')
            private.fdf_string = FdfSimpleString.new('FrameSimpleStatusBarString')
            private.fdf_string:setFont('fonts\\nim_____.ttf', 0.008)
            private.fdf_string:setColor(1.0, 1.0, 1.0, 1.0)
            private.fdf_string:setText('')
        private.fdf_layer_forw:addSubframe(private.fdf_string)
            private.fdf_border = FdfSimpleTexture.new('FrameSimpleStatusBarBorder')
            private.fdf_border:setFile('UI\\Feedback\\XPBar\\human-xpbar-border.blp') -- from UI/war3skins.txt
        private.fdf_layer_forw:addSubframe(private.fdf_border)
    private.fdf_forw:addSubframe(private.fdf_layer_forw)
private.fdf:addSubframe(private.fdf_forw)

---@param self FrameSimpleStatusBar
function private.newData(self)
    local h_border = BlzGetFrameByName(private.fdf_border:getName(), 0)
    local h_string = BlzGetFrameByName(private.fdf_string:getName(), 0)
    local h_texture = BlzGetFrameByName(private.fdf_background:getName(), 0)

    local priv = {
        border = FrameSimpleTexture.link(h_border),
        string = FrameSimpleString.link(h_string),
        texture = FrameSimpleTexture.link(h_texture),
    }
    private.data[self] = priv
end

return static