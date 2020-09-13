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

    local instance = child or Class.allocate(FrameSimpleStatusBar)
    instance = newFrame(private.fdf, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setBackground(tex_file, flag, blend)
    private.data[self].texture:setTexture(tex_file, flag, blend)
end

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setBar(tex_file, flag, blend)
    BlzFrameSetTexture(self:getData(), tex_file, flag, blend)
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

private.fdf_name = 'FrameSimpleStatusBar'
private.fdf_forw_name = 'FrameSimpleStatusBarForward'
private.fdf_string_name = 'FrameSimpleStatusBarString'
private.fdf_texture_name = 'FrameSimpleStatusBarTexture'
private.fdf_border_name = 'FrameSimpleStatusBarBorder'

private.fdf = FdfSimpleStatusBar.new(private.fdf_name)
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.01)
private.fdf:setBarTexture('Replaceabletextures\\Teamcolor\\Teamcolor00.blp')

    local fdf_layer_back = FdfSimpleLayer.new('BACKGROUND')
        local fdf_texture = FdfSimpleTexture.new(private.fdf_texture_name)
        fdf_texture:setFile('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
    fdf_layer_back:addSubframe(fdf_texture)
private.fdf:addSubframe(fdf_layer_back)

    local fdf_forw = FdfSimpleFrame.new(private.fdf_forw_name)
    fdf_forw:setAllPoints(true)
        local fdf_layer_forw = FdfSimpleLayer.new('ARTWORK')
            local fdf_string = FdfSimpleString.new(private.fdf_string_name)
            fdf_string:setFont('fonts\\nim_____.ttf', 0.008)
            fdf_string:setColor(1.0, 1.0, 1.0, 1.0)
            fdf_string:setText('Azaza')
        fdf_layer_forw:addSubframe(fdf_string)
            local fdf_border = FdfSimpleTexture.new(private.fdf_border_name)
            fdf_border:setFile('UI\\Feedback\\XPBar\\human-xpbar-border.blp') -- from UI/war3skins.txt
        fdf_layer_forw:addSubframe(fdf_border)
    fdf_forw:addSubframe(fdf_layer_forw)
private.fdf:addSubframe(fdf_forw)

---@param self FrameSimpleStatusBar
function private.newData(self)
    local priv = {
        border = FrameSimpleTexture.new(BlzGetFrameByName(private.fdf_border_name, 0)),
        string = FrameSimpleString.new(BlzGetFrameByName(private.fdf_string_name, 0)),
        texture = FrameSimpleTexture.new(BlzGetFrameByName(private.fdf_texture_name, 0)),
    }
    private.data[self] = priv
end

return static