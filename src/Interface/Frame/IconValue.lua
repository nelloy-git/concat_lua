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
local SimpleButton = FrameAPI.SimpleButton
local SimpleText = FrameAPI.SimpleText
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
    BlzFrameSetSize(priv.icon, size, size)

    priv.value:setPoint(FRAMEPOINT_RIGHT, FRAMEPOINT_RIGHT, 0, 0)
    priv.value:setSize(width - size, height)
    priv.value:setFontSize(private.default_font_size * height / private.default_height)
end

---@param level number
function public:setLevel(level)
    FramePublic.setLevel(self, level)
    private.data[self].value:setLevel(level + 1)
end

---@param texture string | nil
function public:setBackground(texture)
    texture = texture or Import.TransparentTexture
    BlzFrameSetTexture(private.data[self].background, texture, 0, true)
end

---@param texture string | nil
function public:setIcon(texture)
    texture = texture or Import.TransparentTexture
    BlzFrameSetTexture(private.data[self].icon, texture, 0, true)
end

---@param text string | nil
function public:setText(text)
    if type(text) ~= 'string' then
        text = tostring(text)
    end
    private.data[self].value:setText(text)
end

---@param red number
---@param green number
---@param blue number
---@param alpha number
function public:setTextColor(red, green, blue, alpha)
    private.data[self].value:setColor(red, green, blue, alpha)
end

function public:getLevel()
    return FramePublic.getLevel(self) + 1
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.frame_type_name = tostring(InterfaceFrameIconValue)
private.suffix = {
    background = 'Background',
    icon = 'Icon',
    value = 'String'
}
private.default_width = 0.05
private.default_height = 0.01
private.default_icon_size = 0.0093
private.icon_ratio = private.default_icon_size / private.default_height
private.default_font = 'fonts\\nim_____.ttf'
private.default_font_size = 0.006

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
        forw_layer:setChildrens({icon})
        table.insert(list, forw_layer)
    private.frame_type:setChildrens(list)
end

---@param self InterfaceFrameIconValue
function private.newData(self)
    local priv = {
        background = BlzGetFrameByName(private.frame_type_name..private.suffix.background, 0),
        icon = BlzGetFrameByName(private.frame_type_name..private.suffix.icon, 0),

    }
    priv.value = SimpleText.new()
    private.data[self] = priv

    priv.value:setParent(self)
    priv.value:setPoint(FRAMEPOINT_RIGHT, FRAMEPOINT_RIGHT, 0, 0)
    priv.value:setAlignment(TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE)

    self:setSize(private.default_width, private.default_height)
    self:setLevel(1)
end

return static