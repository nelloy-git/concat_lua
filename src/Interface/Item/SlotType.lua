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
        local back_layer = SimpleLayer.new('BACKGROUND')
            local background = SimpleTexture.new(SlotType.backgroundName)
        back_layer:setChildrens({background})

        local button = SimpleButton.new(SlotType.buttonName)
        button:setAllPoints()
            local forw_layer = SimpleLayer.new('ARTWORK')
                local icon = SimpleTexture.new(SlotType.iconName)
                icon:setAnchor('CENTER', 0, 0)

                local count = SimpleString.new(SlotType.countName)
                count:setAnchor('BOTTOMRIGHT', 0, 0)
                count:setFont('fonts\\nim_____.ttf', 0.009)
            forw_layer:setChildrens({icon, count})
        button:setChildrens({forw_layer})
    SlotType.FrameType:setChildrens({back_layer, button})

return SlotType