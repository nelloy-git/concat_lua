local Frame = require('baseClasses.Frame.FrameData')
local FrameOrigins = require('baseClasses.Frame.FrameOrigin')
local Inventory = require('baseClasses.Frame.Inventory')

local Interface = {}

local initialized = false
function Interface.init()
    if initialized then return nil end

    Frame.init()
    FrameOrigins.init()
    Inventory.init()

    --BlzHideOriginFrames(true)
    Frame.WORLD_FRAME:setAllPoints(Frame.GAME_UI)

    initialized = true
end

return Interface