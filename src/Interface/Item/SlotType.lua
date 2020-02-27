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
SlotType.countBackgroundName = 'InterfaceItemSlotBackground'
SlotType.countName = 'InterfaceItemSlotCount'

SlotType.FrameType = SimpleFrame.new(SlotType.name, true)
    SlotType.FrameType:setWidth(0.1)
    SlotType.FrameType:setHeight(0.1)
        local back_layer = SimpleLayer.new('BACKGROUND')
            local background = SimpleTexture.new(SlotType.backgroundName)
            background:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor00.blp')
        back_layer:setChildrens({background})

        local forw_layer = SimpleLayer.new('ARTWORK')
            local button = SimpleButton.new(SlotType.buttonName)
                local button_back_layer = SimpleLayer.new('BACKGROUND')
                    local icon = SimpleTexture.new(SlotType.iconName)
                    icon:setWidth(0.1)
                    icon:setHeight(0.1)
                    icon:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor01.blp')
                button_back_layer:setChildrens({icon})

                local button_forw_layer = SimpleLayer.new('ARTWORK')
                    local count_icon = SimpleTexture.new(SlotType.countBackgroundName)
                    count_icon:setAnchor('BOTTOMRIGHT', 0, 0)
                    count_icon:setWidth(0.1)
                    count_icon:setHeight(0.1)
                    count_icon:setTexture('Replaceabletextures\\Teamcolor\\Teamcolor02.blp')

                    local count = SimpleString.new(SlotType.countName)
                    count:setAnchor('BOTTOMRIGHT', 0, 0)
                    count:setWidth(0.1)
                    count:setHeight(0.1)
                    count:setFont('fonts\\nim_____.ttf', 0.009)
                button_forw_layer:setChildrens({count_icon, count})
            button:setChildrens({button_back_layer, button_forw_layer})
        forw_layer:setChildrens({button})
    SlotType.FrameType:setChildrens({back_layer, forw_layer})

return SlotType