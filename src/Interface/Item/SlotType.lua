---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrame = FrameAPI.SimpleFrameType
local SimpleButton = FrameAPI.SimpleButtonType
local SimpleLayer = FrameAPI.SimpleLayerType
local SimpleTexture = FrameAPI.SimpleTextureType
local SimpleString = FrameAPI.SimpleStringType

local SlotType = {}

SlotType.name = 'InterfaceItemSlot'
SlotType.backgroundName = 'InterfaceItemSlotBackground'
SlotType.buttonName = 'InterfaceItemSlotButton'
SlotType.iconName = 'InterfaceItemSlotIcon'
SlotType.countName = 'InterfaceItemSlotCount'

SlotType.FrameType = SimpleFrame.new(SlotType.name, true)
    SlotType.FrameType:setWidth(0.1)
    SlotType.FrameType:setHeight(0.1)
        local back_layer = SimpleLayer.new('BACKGROUND')
            local background = SimpleTexture.new(SlotType.backgroundName)
            background:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor01.blp')
        back_layer:setChildrens({background})

        local button = SimpleButton.new(SlotType.buttonName)
            local forw_layer = SimpleLayer.new('ARTWORK')
                local icon = SimpleTexture.new(SlotType.iconName)
                icon:setAnchor('CENTER', 0, 0)
                icon:setWidth(0.1)
                icon:setHeight(0.1)
                icon:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor00.blp')

                local count = SimpleString.new(SlotType.countName)
                count:setAnchor('BOTTOMRIGHT', 0, 0)
                count:setWidth(0.1)
                count:setHeight(0.1)
                count:setFont('fonts\\nim_____.ttf', 0.009)
            forw_layer:setChildrens({icon, count})
        button:setChildrens({forw_layer})
    SlotType.FrameType:setChildrens({back_layer, button})

return SlotType