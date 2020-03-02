--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleButton = FrameAPI.SimpleButton
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleTextureType = FrameAPI.SimpleTextureType
local SimpleStringType = FrameAPI.SimpleStringType
local SimpleStatusBarType = FrameAPI.SimpleStatusBarType

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

static.cornerName = {
    'TOPLEFT',
    'TOP',
    'TOPRIGHT',
    'LEFT',
    'CENTER',
    'RIGHT',
    'BOTTOMLEFT',
    'BOTTOM',
    'BOTTOMRIGHT',
}

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

---@param corner string | 'TOPLEFT' | 'TOP' | 'TOPRIGHT' | 'LEFT' | 'CENTER' | 'RIGHT' | 'BOTTOMLEFT' | 'BOTTOM' | 'BOTTOMRIGHT'
---@param text string | nil
---@param red number | nil
---@param green number | nil
---@param blue number | nil
---@param alpha number | nil
function public:setCornerText(corner, text, red, green, blue, alpha)
    if not text then
        BlzFrameSetVisible(private.data[self].corner[corner], false)
        return
    end

    red = math.max(math.min(red or 255, 255), 1)
    green = math.max(math.min(green or 255, 255), 1)
    blue = math.max(math.min(blue or 255, 255), 1)
    alpha = math.max(math.min(alpha or 255, 255), 1)

    local color = string.format('|c%x%x%x%x', alpha, red, green, blue)
    BlzFrameSetText(private.data[self].corner_string[corner], color..text..'|r')
end

---@param corner string | 'TOPLEFT' | 'TOP' | 'TOPRIGHT' | 'LEFT' | 'CENTER' | 'RIGHT' | 'BOTTOMLEFT' | 'BOTTOM' | 'BOTTOMRIGHT'
---@param texture string
function public:setCornerBackground(corner, texture)
    if not texture then
        texture = Import.TransparentTexture
    end
    BlzFrameSetTexture(private.data[self].corner_background[corner], texture, 0, true)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.default_size = 0.05

local name = 'InterfaceFrameButton'
local suffix = {
    background = 'Background',
    icon = 'Icon',
    progress = 'Progress',
    corner = {
        'TOPLEFT',
        'TOP',
        'TOPRIGHT',
        'LEFT',
        'CENTER',
        'RIGHT',
        'BOTTOMLEFT',
        'BOTTOM',
        'BOTTOMRIGHT'
    },
    corner_background = 'Background',
    corner_string = 'String'
}

-- Frame type
do
    local size = private.default_size
    private.frame_type = SimpleButtonType.new(name, true)
    private.frame_type:setWidth(size)
    private.frame_type:setHeight(size)
        local list = {}

        local background = SimpleTextureType.new(name..suffix.background, false)
        background:setAnchor('CENTER', 0, 0)
        background:setWidth(size)
        background:setHeight(size)
        background:setTexture('ui\\console\\human\\humanuitile03')
        background:setTexCoord(3/512, 283/512, 78/512, 356/512)
        table.insert(list, background)

        local icon = SimpleTextureType.new(name..suffix.icon, false)
        icon:setAnchor('CENTER', 0, 0)
        icon:setWidth(0.8 * size)
        icon:setHeight(0.8 * size)
        icon:setTexture(Import.TransparentTexture)
        table.insert(list, icon)

        local progress = SimpleStatusBarType.new(name..suffix.progress, false)
        progress:setTexture(Import.HalfTransparentTexture)
        table.insert(list, progress)

        for i = 1, #suffix.corner do
            local corner_name = name..suffix.corner[i]
            local corner = SimpleFrameType.new(corner_name, false)
                local corner_background = SimpleTextureType.new(corner_name..suffix.corner_background, false)
                corner_background:setAnchor(suffix.corner[i], 0, 0)
                corner_background:setWidth(0.2 * size)
                corner_background:setHeight(0.2 * size)
                corner_background:setTexture('ui\\widgets\\console\\human\\infocard-attack-siege')
                corner_background:setTexCoord(31/64, 33/64, 1, 1)

                local corner_string = SimpleStringType.new(corner_name..suffix.corner_string, false)
                corner_string:setAnchor(suffix.corner[i], 0, 0)
                corner_string:setWidth(0.2 * size)
                corner_string:setHeight(0.2 * size)
                corner_string:setFont('fonts\\nim_____.ttf', 0.008)
                corner_string:setText('0')
            corner:setChildrens({corner_background, corner_string})
            table.insert(list, corner)
        end
    private.frame_type:setChildrens(list)
end

---@param self InterfaceFrameButton
function private.newData(self)
    local priv = {
        background = BlzGetFrameByName(name..suffix.background, 0),
        icon = BlzGetFrameByName(name..suffix.icon, 0),
        progress = BlzGetFrameByName(name..suffix.progress, 0),

        corner = {},
        corner_background = {},
        corner_string = {},
    }
    for i = 1, #suffix.corner do
        local corner_name = name..suffix.corner[i]
        priv.corner[suffix.corner[i]] = BlzGetFrameByName(corner_name, 0)
        priv.corner_background[suffix.corner[i]] = BlzGetFrameByName(corner_name..suffix.corner_background, 0)
        priv.corner_string[suffix.corner[i]] = BlzGetFrameByName(corner_name..suffix.corner_string, 0)

        BlzFrameSetVisible(priv.corner[suffix.corner[i]], false)
    end
    private.data[self] = priv

    BlzFrameSetValue(priv.progress, 0)
end

return static