--=========
-- Include
--=========

---@type Widget
local Widget = require('Class.Widget.Main')
require('Class.Widget.Subframe')

--========
-- Module
--========

-- Module must return table to run init function.
FrameUpdateModule = {}

local initialized = false
function FrameUpdateModule.init()
    if initialized then return nil end

    -- Window resize correction.
    update_ui()

    initialized = true
end

function Widget:update()
    local parent = self:getParent()
    local offset = 0
    if parent == Widget.GAME_UI then offset = Widget.getScreenXOffset() end
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
    local changed = Widget.updateScreen()
    if changed then
        Debug("Global update", Widget.getScreenWidth(), Widget.getScreenHeight())
        local childrens = Widget.GAME_UI:getChildrens()
        for i = 1, #childrens do
            childrens[i]:update()
        end
    end
    glTimer:addAction(update_period, update_ui)
end

return FrameUpdateModule