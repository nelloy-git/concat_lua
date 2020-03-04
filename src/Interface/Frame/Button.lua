--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButton = FrameAPI.SimpleButton
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleLayerType = FrameAPI.SimpleLayerType
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleTextureType = FrameAPI.SimpleTextureType
local SimpleStringType = FrameAPI.SimpleStringType
local SimpleStatusBarType = FrameAPI.SimpleStatusBarType
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type InterfaceFrameIconValueClass
local IconValue = require('Interface.Frame.IconValue')

--=======
-- Class
--=======

local InterfaceFrameButton = Class.new('InterfaceFrameButton', SimpleButton)
---@class InterfaceFrameButton : SimpleButton
local public = InterfaceFrameButton.public
---@class InterfaceFrameButtonClass :SimpleButtonClass
local static = InterfaceFrameButton.static
---@type InterfaceFrameButtonClass
local override = InterfaceFrameButton.override
local private = {}

--=========
-- Static
--=========

---@alias InterfaceFrameButtonValuePos number

---@type table<string, InterfaceFrameButtonValuePos>
static.ValuePos = {}
---@type InterfaceFrameButtonValuePos
static.ValuePos.TOPLEFT = 1
---@type InterfaceFrameButtonValuePos
static.ValuePos.TOP = 2
---@type InterfaceFrameButtonValuePos
static.ValuePos.TOPRIGHT = 3
---@type InterfaceFrameButtonValuePos
static.ValuePos.LEFT = 4
---@type InterfaceFrameButtonValuePos
static.ValuePos.CENTER = 5
---@type InterfaceFrameButtonValuePos
static.ValuePos.RIGHT = 6
---@type InterfaceFrameButtonValuePos
static.ValuePos.BOTTOMLEFT = 7
---@type InterfaceFrameButtonValuePos
static.ValuePos.BOTTOM = 8
---@type InterfaceFrameButtonValuePos
static.ValuePos.BOTTOMRIGHT = 9

---@param child_instance InterfaceFrameButton | nil
---@return InterfaceFrameButton
function override.new(child_instance)
    if child_instance and not Class.type(child_instance, InterfaceFrameButton) then
        Log.error(InterfaceFrameButton, '\"child_instance\" must be InterfaceFrameButton or nil', 2)
    end

    local instance = child_instance or Class.allocate(InterfaceFrameButton)
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
    local ratio_w = width / self:getWidth()
    local ratio_h = height / self:getHeight()
    FramePublic.setSize(self, width, height)

    local priv = private.data[self]
    BlzFrameSetSize(priv.icon, private.icon_ratio * width, private.icon_ratio * height)
    for _, val_pos in pairs(static.ValuePos) do
        local value = priv.value[val_pos]
        value:setSize(ratio_w * value:getWidth(), ratio_h * value:getHeight())
    end
end

---@param level number
function public:setLevel(level)
    local priv = private.data[self]

    FramePublic.setLevel(self, level)
    BlzFrameSetLevel(priv.progress, level + 1)

    for _, val_pos in pairs(static.ValuePos) do
        priv.value[val_pos]:setLevel(level + 1)
    end
end

---@param texture string | nil
function public:setBackground(texture)
    texture = texture or Import.TransparentTexture
    BlzFrameSetTexture(private.data[self].icon, texture, 0, true)
end

---@param texture string | nil
function public:setIcon(texture)
    if not texture then
        texture = Import.TransparentTexture
        self:enableActions(false)
    else
        self:enableActions(true)
    end
    BlzFrameSetTexture(private.data[self].icon, texture, 0, true)
end

---@param value number
function public:setProgress(value)
    local priv = private.data[self]

    if not value then
        BlzFrameSetVisible(priv.progress, false)
        return
    end
    BlzFrameSetValue(priv.progress, value)
    BlzFrameSetVisible(priv.progress, true)
end

---@return number
function public:getLevel()
    return FramePublic.getLevel(self) + 1
end

---@param val_pos InterfaceFrameButtonValuePos
---@return InterfaceFrameIconValue
function public:getIconValue(val_pos)
    return private.data[self].value[val_pos]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.default_size = 0.035
private.icon_ratio = 0.8

local name = 'InterfaceFrameButton'
private.suffix = {
    background = 'Background',
    icon = 'Icon',
    progress = 'Progress',
}

private.framepoint = {
    [static.ValuePos.TOPLEFT] = FRAMEPOINT_TOPLEFT,
    [static.ValuePos.TOP] = FRAMEPOINT_TOP,
    [static.ValuePos.TOPRIGHT] = FRAMEPOINT_TOPRIGHT,
    [static.ValuePos.LEFT] = FRAMEPOINT_LEFT,
    [static.ValuePos.CENTER] = FRAMEPOINT_CENTER,
    [static.ValuePos.RIGHT] = FRAMEPOINT_RIGHT,
    [static.ValuePos.BOTTOMLEFT] = FRAMEPOINT_BOTTOMLEFT,
    [static.ValuePos.BOTTOM] = FRAMEPOINT_BOTTOM,
    [static.ValuePos.BOTTOMRIGHT] = FRAMEPOINT_BOTTOMRIGHT,
}

-- Frame type
do
    local size = private.default_size
    private.frame_type = SimpleButtonType.new(name, true)
    private.frame_type:setWidth(size)
    private.frame_type:setHeight(size)
        local list = {}

        local back_layer = SimpleLayerType.new('BACKGROUND', false)
            local background = SimpleTextureType.new(name..private.suffix.background, false)
            background:setAnchor('CENTER', 0, 0)
            background:setWidth(size)
            background:setHeight(size)
            background:setTexture('ui\\console\\human\\humanuitile03')
            background:setTexCoord(3/512, 283/512, 78/512, 356/512)
        back_layer:setChildrens({background})
        table.insert(list, back_layer)

        local forw_layer = SimpleLayerType.new('ARTWORK', false)
            local icon = SimpleTextureType.new(name..private.suffix.icon, false)
            icon:setAnchor('CENTER', 0, 0)
            icon:setWidth(private.icon_ratio * size)
            icon:setHeight(private.icon_ratio * size)
            icon:setTexture(Import.TransparentTexture)
        forw_layer:setChildrens({icon})
        table.insert(list, forw_layer)

        local progress = SimpleStatusBarType.new(name..private.suffix.progress, false)
        progress:setTexture(Import.HalfTransparentTexture)
        table.insert(list, progress)
    private.frame_type:setChildrens(list)
end

---@param self InterfaceFrameButton
function private.newData(self)
    local priv = {
        background = BlzGetFrameByName(name..private.suffix.background, 0),
        icon = BlzGetFrameByName(name..private.suffix.icon, 0),
        progress = BlzGetFrameByName(name..private.suffix.progress, 0),

        value = {},
    }
    for _, val_pos in pairs(static.ValuePos) do
        local value = IconValue.new()
        value:setParent(self)
        value:setPoint(private.framepoint[val_pos], private.framepoint[val_pos], 0, 0)
        value:setVisible(false)
        priv.value[val_pos] = value
    end
    private.data[self] = priv

    self:setLevel(1)
    BlzFrameSetValue(priv.progress, 0)
end

return static