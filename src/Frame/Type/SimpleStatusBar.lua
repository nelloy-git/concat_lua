--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

local SimpleStatusBarType = Class.new('SimpleStatusBarType', FrameType)
---@class SimpleStatusBarType
local public = SimpleStatusBarType.public
---@class SimpleStatusBarTypeClass
local static = SimpleStatusBarType.static
---@type SimpleStatusBarTypeClass
local override = SimpleStatusBarType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance SimpleStatusBarType | nil
---@return SimpleStatusBarType
function override.new(uniq_name, separate_file, child_instance)
    local instance = child_instance or Class.allocate(SimpleStatusBarType)
    instance = FrameType.new(uniq_name, private.createFdf, separate_file, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return boolean
function public:isSimple()
    return true
end

---@param width number
function public:setWidth(width)
    private.data[self].width = width

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.SimpleStatusBar.Field.Width, width)
    end
end

---@param height number
function public:setHeight(height)
    private.data[self].height = height

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.SimpleStatusBar.Field.Height, height)
    end
end

---@param texture string
function public:setBackground(texture)
    private.data[self].background = texture

    local fdf = self:getFdf()
    if fdf then
        local layers = fdf:getField(private.SimpleStatusBar.Field.ChildFrames)
        for i = 1, #layers do
            if layers[i]:getName() == 'BACKGROUND' then
                local texture_fdf = layers[i]:getField(private.SimpleLayer.Field.ChildFrames)[1]
                texture_fdf:setField(private.SimpleTexture.Field.File, texture)
                return
            end
        end
    end
end

---@param texture string
function public:setBar(texture)
    private.data[self].bar = texture

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.SimpleStatusBar.Field.BarTexture, texture)
    end
end

---@param font string
function public:setFont(font)
    private.data[self].font = font

    local fdf = self:getFdf()
    if fdf then
        local layers = fdf:getField(private.SimpleStatusBar.Field.ChildFrames)
        for i = 1, #layers do
            if layers[i]:getName() == 'ARTWORK' then
                local string_fdf = layers[i]:getField(private.SimpleLayer.Field.ChildFrames)[1]
                string_fdf:setField(private.SimpleString.Field.Font, {font, private.data[self].font_size})
                return
            end
        end
    end
end

---@param font_size number
function public:setFontSize(font_size)
    private.data[self].font_size = font_size

    local fdf = self:getFdf()
    if fdf then
        local layers = fdf:getField(private.SimpleStatusBar.Field.ChildFrames)
        for i = 1, #layers do
            if layers[i]:getName() == 'ARTWORK' then
                local string_fdf = layers[i]:getField(private.SimpleLayer.Field.ChildFrames)[1]
                string_fdf:setField(private.SimpleString.Field.Font, {private.data[self].font, font_size})
                return
            end
        end
    end
end

---@param anchor string
function public:setAnchor(anchor)
    private.data[self].anchor = anchor

    local fdf = self:getFdf()
    if fdf then
        local layers = fdf:getField(private.SimpleStatusBar.Field.ChildFrames)
        for i = 1, #layers do
            if layers[i]:getName() == 'ARTWORK' then
                local string_fdf = layers[i]:getField(private.SimpleLayer.Field.ChildFrames)[1]
                string_fdf:setField(private.SimpleString.Field.Anchor, {anchor, 0, 0})
                return
            end
        end
    end
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
end

---@return string
function public:getBackground()
    return private.data[self].background
end

---@return string
function public:getBar()
    return private.data[self].bar
end

---@return string
function public:getFont()
    return private.data[self].font
end

---@return number
function public:getFontSize()
    return private.data[self].font_size
end

---@return string
function public:getBackgroundFrameName()
    return private.getBackgroundName(self:getName())
end

---@return string
function public:getTextFrameName()
    return private.getTextName(self:getName())
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param name string
---@return string
function private.getBackgroundName(name)
    return name..'BackgroundTexture'
end

---@param name string
---@return string
function private.getTextName(name)
    return name..'Text'
end

---@param self SimpleButton
function private.newData(self)
    priv = {
        width = private.default_width,
        height = private.default_height,
        background = private.default_background_texture,
        bar = private.default_bar_texture,
        font = private.default_font_size,
        font_size = private.default_font_size,
        anchor = private.default_anchor
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

private.default_width = 0.03
private.default_height = 0.03
private.default_font = 'fonts\\nim_____.ttf'
private.default_font_size = 0.009
private.default_anchor = 'CENTER'
private.default_background_texture = 'Replaceabletextures\\Teamcolor\\Teamcolor27.blp'
private.default_bar_texture = 'Replaceabletextures\\Teamcolor\\Teamcolor00.blp'

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.File = FdfEdit.File
    private.SimpleStatusBar = FdfEdit.SimpleStatusBar
    private.SimpleLayer = FdfEdit.SimpleLayer
    private.SimpleString = FdfEdit.SimpleString
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param name string
---@return string
function private.createFdf(name)
    return private.SimpleStatusBar.new(name)
end

return static