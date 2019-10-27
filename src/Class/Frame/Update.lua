--=========
-- Include
--=========

---@type Frame
local Frame = require('Class.Frame.Main')

require('Class.Frame.Position')
require('Class.Frame.Subframe')

--========
-- Module
--========

FrameUpdateModule = {}

local initialized = false
function FrameUpdateModule.init()
    if initialized then return nil end

    Frame.init()
    Frame.GAME_UI.update = function() Debug("Frame.GAME_UI can not be updated.") end
    Frame.GAME_UI.getX = function() return 0 end --Frame.getScreenXOffset() end
    Frame.GAME_UI.getY = function() return 0.6 end --Frame.getScreenYOffset() end
    Frame.GAME_UI.getWidth = function() return 0.8 end --Frame.getScreenWidth() end
    Frame.GAME_UI.getHeight = function() return 0.6 end --Frame.getScreenHeight() end

    update_ui()

    initialized = true
end

function Frame:update()
    local parent = self:getParent()
    local offset = 0
    if parent == Frame.GAME_UI then offset = Frame.getScreenXOffset() end
    BlzFrameSetPoint(self:getObj(), FRAMEPOINT_TOPLEFT,
                     parent:getObj(), FRAMEPOINT_TOPLEFT,
                     self:getX() + offset, -self:getY())
    BlzFrameSetSize(self:getObj(), self:getWidth(), self:getHeight())

    Debug(self:getX(), self:getY(), self:getWidth(), self:getHeight())

    local childrens = self:getChildrens()
    for i = 1, #childrens do
        childrens[i]:update()
    end
end

--- Seconds
local update_period = 3
update_ui = function()
    local changed = Frame.updateScreen()
    if changed then
        Debug("Global update", Frame.getScreenWidth(), Frame.getScreenHeight())
        local childrens = Frame.GAME_UI:getChildrens()
        for i = 1, #childrens do
            childrens[i]:update()
        end
    end
    glTimer:addAction(update_period, update_ui)
end

return FrameUpdateModule