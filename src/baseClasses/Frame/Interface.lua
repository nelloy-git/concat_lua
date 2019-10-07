local Frame = require('baseClasses.Frame.FrameData')
local FrameOrigins = require('baseClasses.Frame.Origin')
local Inventory = require('baseClasses.Frame.Inventory.Inventory')
local InventoryEvent = require('baseClasses.Frame.Inventory.InventoryEvent')

local Interface = {}

local initialized = false
function Interface.init()
    if initialized then return nil end

    FrameOrigins.init()

    BlzHideOriginFrames(true)
    FrameOrigins.WORLD_FRAME:setPosition(0, 0)
    FrameOrigins.WORLD_FRAME:setSize(Frame:getScreenWidth(), Frame:getScreenHeight())

    Frame.INVENTORY = Inventory.new()
    Frame.INVENTORY:setPosition(0.2, 0.1)
    Frame.INVENTORY:setSize(0.2, 0.3)

    initialized = true
end

return Interface