--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleLayerType = FrameAPI.SimpleLayerType
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleTextureType = FrameAPI.SimpleTextureType
local SimpleStringType = FrameAPI.SimpleStringType
local SimpleButton = FrameAPI.SimpleButton
local FramePublic = Class.getPublic(FrameAPI.Frame)

--=======
-- Class
--=======

local InterfaceFrameIconValue = Class.new('InterfaceFrameIconValue', SimpleButton)
---@class InterfaceFrameIconValue : Frame
local public = InterfaceFrameIconValue.public
---@class InterfaceFrameIconValueClass : FrameClass
local static = InterfaceFrameIconValue.static
---@type InterfaceFrameIconValueClass
local override = InterfaceFrameIconValue.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceFrameIconValue | nil
---@return InterfaceFrameIconValue
function override.new(child_instance)
    if child_instance and not Class.type(child_instance, InterfaceFrameIconValue) then
        Log.error(InterfaceFrameIconValue, '\"child_instance\" must be InterfaceFrameIconValue or nil', 2)
    end

    local instance = child_instance or Class.allocate(InterfaceFrameIconValue)
    instance = SimpleButton.new(private.frame_type, instance)
    private.newData(instance)

    return instance
end

---@return number
function override.getDefaultSize()
    return private.default_size
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    FramePublic.setSize(self, width, height)

    local priv = private.data[self]
    local size = height * private.icon_ratio

    BlzFrameSetSize(priv.background, width, height)

    BlzFrameClearAllPoints(priv.icon)
    BlzFrameSetPoint(priv.icon, FRAMEPOINT_LEFT,
                     priv.background, FRAMEPOINT_LEFT,
                     (height - size) / 2, 0)
    BlzFrameSetSize(priv.icon, size, size)

    BlzFrameClearAllPoints(priv.str)
    BlzFrameSetPoint(priv.str, FRAMEPOINT_RIGHT,
                     priv.background, FRAMEPOINT_RIGHT,
                     (height - size) / 2, 0)
    BlzFrameSetSize(priv.str, width - 2 * (height - size) - priv.icon_tex and size or 0, size)
    BlzFrameSetFont(priv.str, priv.font, private.default_font_size * height / private.default_height, 0)
end

---@param texture string | nil
function public:setBackground(texture)
    local priv = private.data[self]
    texture = texture or Import.TransparentTexture
    BlzFrameSetTexture(priv.background, texture, 0, true)
end

---@param texture string | nil
function public:setIcon(texture)
    local priv = private.data[self]
    priv.icon_tex = texture or Import.TransparentTexture
    BlzFrameSetTexture(priv.icon, priv.icon_tex, 0, true)
end

---@param text string | nil
---@param red number | nil
---@param green number | nil
---@param blue number | nil
---@param alpha number | nil
function public:setText(text, red, green, blue, alpha)
    if not text then
        text = ''
    end

    red = math.max(math.min(red or 255, 255), 1)
    green = math.max(math.min(green or 255, 255), 1)
    blue = math.max(math.min(blue or 255, 255), 1)
    alpha = math.max(math.min(alpha or 255, 255), 1)

    local color = string.format('|c%x%x%x%x', alpha, red, green, blue)
    BlzFrameSetText(private.data[self].str, color..text..'|r')
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.frame_type_name = tostring(InterfaceFrameIconValue)
private.suffix = {
    background = 'Background',
    icon = 'Icon',
    str = 'String'
}
private.default_width = 0.006
private.default_height = 0.003
private.default_icon_size = 0.0025
private.icon_ratio = private.default_icon_size / private.default_height
private.default_font = 'fonts\\nim_____.ttf'
private.default_font_size = 0.008

-- Frame type
do
    local name = private.frame_type_name
    local width = private.default_width
    local height = private.default_height
    local size = private.default_icon_size

    private.frame_type = SimpleButtonType.new(name, true)
    private.frame_type:setWidth(width)
    private.frame_type:setHeight(height)
        local list = {}

        local back_layer = SimpleLayerType.new('BACKGROUND', false)
            local background = SimpleTextureType.new(name..private.suffix.background, false)
            background:setAnchor('CENTER', 0, 0)
            background:setWidth(width)
            background:setHeight(height)
            background:setTexture('ui\\widgets\\console\\human\\infocard-attack-siege')
            background:setTexCoord(31/64, 33/64, 1, 1)
        back_layer:setChildrens({background})
        table.insert(list, back_layer)

        local forw_layer = SimpleLayerType.new('ARTWORK', false)
            local icon = SimpleTextureType.new(name..private.suffix.icon, false)
            icon:setAnchor('LEFT', (height - size) / 2 , 0)
            icon:setWidth(size)
            icon:setHeight(size)
            icon:setTexture(Import.TransparentTexture)

            local str = SimpleStringType.new(name..private.suffix.str, false)
            str:setAnchor('RIGHT', - (height - size) / 2, 0)
            str:setWidth(width - 2 * (height - size) - size)
            str:setHeight(size)
            str:setFont(private.default_font, private.default_font_size)
            str:setText('0')
        forw_layer:setChildrens({icon, str})
        table.insert(list, forw_layer)
    private.frame_type:setChildrens(list)
end

---@param self InterfaceFrameIconValue
function private.newData(self)
    local priv = {
        background = BlzGetFrameByName(private.frame_type_name..private.suffix.background, 0),
        icon = BlzGetFrameByName(private.frame_type_name..private.suffix.icon, 0),
        str = BlzGetFrameByName(private.frame_type_name..private.suffix.str, 0),

        icon_tex = nil,
        font = private.default_font,
    }
    private.data[self] = priv
end

return static