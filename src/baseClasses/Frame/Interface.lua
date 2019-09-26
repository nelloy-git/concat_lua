local Frame = require('baseClasses.Frame.FrameData')

local Interface = {}

function Interface.init()
    BlzHideOriginFrames(true)
    Frame.WORLD_FRAME:setAllPoints(Frame.GAME_UI)

    

end

return Interface 