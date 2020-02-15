--=========
-- Include
--=========

---@type Interface
--local Interface = require('Interface.Interface')
---@type FrameAPI
local FrameAPI = require('Frame.API')

--=============
--     API
--=============

local button_type = FrameAPI.GlueButtonType.new('TestButton', true)
button_type:setWidth(0.1)
button_type:setHeight(0.1)

local backdrop_type = FrameAPI.BackdropType.new('TestBackdrop', false)
backdrop_type:setWidth(button_type:getWidth())
backdrop_type:setHeight(button_type:getHeight())

local backdrop_type2 = FrameAPI.BackdropType.new('TestBackdrop2', false)
backdrop_type2:setWidth(button_type:getWidth())
backdrop_type2:setHeight(button_type:getHeight())
backdrop_type2:setBackground("ReplaceableTextures\\\\CommandButtons\\\\BTNAdvancedMoonArmor.blp")

local backdrop_type3 = FrameAPI.BackdropType.new('TestBackdrop3', false)
backdrop_type3:setWidth(button_type:getWidth())
backdrop_type3:setHeight(button_type:getHeight())

local highlight_type = FrameAPI.HighlightType.new('TestHighlight', false)
highlight_type:setWidth(button_type:getWidth())
highlight_type:setHeight(button_type:getHeight())

button_type:setEnabledBackdrop(backdrop_type)
button_type:setPressedBackdrop(backdrop_type2)
button_type:setDisabledBackdrop(backdrop_type3)
button_type:setHoveredHighlight(highlight_type)

---@class InterfaceAPI
local InterfaceAPI = {}

--InterfaceAPI.Bag = Interface.Bag

function InterfaceAPI.init()
    --BlzHideOriginFrames(true)
    local game_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local world_handle = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameClearAllPoints(world_handle)
    BlzFrameSetAllPoints(world_handle, game_handle)

    local frame = FrameAPI.GlueButton.new(button_type)
    frame:setX(0.4)
    frame:setY(0.3)

end


return InterfaceAPI