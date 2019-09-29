---@type Frame
local Frame = require('baseClasses.Frame.FrameData')

---@class ParameterTooltipFrame:Frame
local ParameterTooltipFrame = {
    __type = 'ParameterTooltipFrame'..'Class'
}
setmetatable(ParameterTooltipFrame, {__index = Frame})

local ParameterTooltipFrame_meta = {
    __type = 'ParameterTooltipFrame',
    __index = ParameterTooltipFrame,
}

local offset_x = 0.001
local offset_y = 0.001

local icon_size = 0.3

local initialized = false
function ParameterTooltipFrame.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

function ParameterTooltipFrame.new(parent)
    local frame = Frame.new("ParameterTooltipBackground", parent)
    setmetatable(frame, ParameterTooltipFrame_meta)

    frame.__icon = Frame.new("ParameterTooltipBackground", frame)
    --frame.__title = Frame.new("ParameterTooltipTitle", frame)
    --frame.__text = Frame.new("ParameterTooltipText", frame)
    frame.__title = Frame.new("ParameterTooltipTitle", frame)
    frame.__text = Frame.new("ParameterTooltipText", frame)

    frame:update()
    return frame
end

function ParameterTooltipFrame:update()
    local w = self:getWidth()
    local h = self:getHeight()
    local size = icon_size * w

    self:applyMainFramePos()

    self.__icon:setPosition(offset_x, offset_y)
    self.__icon:setSize(size, size)

    self.__title:setPosition(2 * offset_x + size, offset_y + size / 2 - 0.007)
    self.__title:setSize(w - (3 * offset_x + size), 0.015)

    self.__text:setPosition(offset_x, 2 * offset_y + size)
    self.__text:setSize(w - 2 * offset_x, h - (3 * offset_y + size))
end

function ParameterTooltipFrame:setTitle(title)
    BlzFrameSetText(self.__title:getObj(), title)
end

function ParameterTooltipFrame:setText(title)
    BlzFrameSetText(self.__text:getObj(), title)
end

function ParameterTooltipFrame:setIcon(icon)
    BlzFrameSetTexture(self.__icon:getObj(), icon, 0, true)
end

return ParameterTooltipFrame