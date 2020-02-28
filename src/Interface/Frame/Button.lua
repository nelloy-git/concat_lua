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
local SimpleLayerType = FrameAPI.SimpleLayerType
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleTextureType = FrameAPI.SimpleTextureType
local SimpleStringType = FrameAPI.SimpleStringType
local SimpleStatusBarType = FrameAPI.SimpleStatusBarType

--=======
-- Class
--=======

local InterfaceFrameButton = Class.new('InterfaceFrameButton', SimpleButton)
---@class InterfaceItemButtonType : SimpleButton
local public = InterfaceFrameButton.public
---@class InterfaceItemButtonTypeClass :SimpleButtonClass
local static = InterfaceFrameButton.static
---@type InterfaceItemButtonTypeClass
local override = InterfaceFrameButton.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceItemButtonType | nil
---@return InterfaceItemButtonType
function static.new(child_instance)
    if child_instance and not Class.type(child_instance, InterfaceFrameButton) then
        Log.error(InterfaceFrameButton, '\"child_instance\" must be InterfaceFrameButton or nil', 2)
    end

    local instance = child_instance or Class.allocate(InterfaceFrameButton)
    instance = SimpleButton.new(private.frame_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========



--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

local name = 'InterfaceFrameButton'
local suffix = {
    background = 'Background',
    icon = 'Icon',
    progress = 'Progress',
    corner = {
        'TOPLEFT',
        'TOP',
        'RIGHTTOP',
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
    private.frame_type = SimpleButtonType.new(name, true)
    private.frame_type:setWidth(0.1)
    private.frame_type:setHeight(0.1)
        local list = {}

        local background = SimpleTextureType.new(name..suffix.background, false)
        background:setWidth(0.1)
        background:setHeight(0.1)
        -- TODO TexCoord of default inventory
        background:setTexture(Import.Icon.Empty)
        table.insert(list, background)

        local icon = SimpleTextureType.new(name..suffix.icon, false)
        background:setWidth(0.08)
        background:setHeight(0.08)
        icon:setTexture(Import.Icon.Bag)
        table.insert(list, icon)

        local progress = SimpleStatusBarType.new(name..suffix.progress, false)
        progress:setAllPoints()
        progress:setTexture(Import.HalfTransparentTexture)
        table.insert(list, progress)

        for i = 1, #suffix.corner do
            local corner_name = name..suffix.corner[i]
            local corner = SimpleFrameType.new(corner_name, false)
            corner:setWidth(0.02)
            corner:setHeight(0.02)
            corner:setAnchor(suffix.corner[i], 0, 0)
                local corner_background = SimpleTextureType.new(corner_name..suffix.corner_background, false)
                corner_background:setTexture(Import.Icon.Empty)

                local corner_string = SimpleStringType.new(corner_name..suffix.corner_string, false)
                corner_string:setFont('fonts\\nim_____.ttf', 0.008)
                corner_string:setText('0')
            corner:setChildrens({corner_background, corner_string})
            table.insert(list, corner)
        end
    private.frame_type:setChildrens(list)
end


---@param self InterfaceItemButtonType
function private.newData(self)
    local priv = {
        background = BlzGetFrameByName(name..suffix.background, 0),
        icon = BlzGetFrameByName(name..suffix.icon, 0),
        progress = BlzGetFrameByName(name..suffix.progress, 0),

        corner = {},
        corner_background = {},
        corner_string = {}
    }
    for i = 1, suffix.corner do
        local corner_name = name..suffix.corner[i]
        priv.corner[i] = BlzGetFrameByName(corner_name, 0)
        priv.corner_background[i] = BlzGetFrameByName(corner_name..suffix.corner_background, 0)
        priv.corner_string[i] = BlzGetFrameByName(corner_name..suffix.corner_string, 0)
    end
    private.data[self] = priv
end

return static