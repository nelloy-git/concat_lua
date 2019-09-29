---@type Frame
local Frame = require('baseClasses.Frame.FrameData')
---@type ParameterTooltipFrame
local ParameterTooltip = require('baseClasses.Frame.Inventory.Parameter.Tooltip')

---@class ParameterFrame
local ParameterFrame = {
    __type = 'FrameParameterClass'
}
setmetatable(ParameterFrame, {__index = Frame})

local ParameterFrame_meta = {
    __type = 'FrameParameter',
    __index = ParameterFrame,
}

local offset_x = 0.001
local offset_y = 0.001

local initialized = false
function ParameterFrame.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end
    
    initialized = true
end

---@param parent Frame
---@return ParameterFrame
function ParameterFrame.new(parent)
    local frame = Frame.new("ParameterBackground", parent)
    setmetatable(frame, ParameterFrame_meta)

    frame.__icon = Frame.new("ParameterBackground", frame)
    frame.__text = Frame.new("ParameterText", frame)
    frame.__hover = Frame.new("FRAME", frame)
    frame.__tooltip = ParameterTooltip.new(frame)
    
    BlzFrameSetTooltip(frame.__hover:getObj(), frame.__tooltip:getObj())

    return frame
end

function ParameterFrame:update()
    local w = self:getWidth()
    local h = self:getHeight()
    local size = h - 2 * offset_y

    self:applyMainFramePos()

    self.__hover:setPosition(0, 0)
    self.__hover:setSize(w, h)

    self.__icon:setPosition(offset_x, offset_y)
    self.__icon:setSize(size, size)

    self.__text:setPosition(2 * offset_x + size, h/2 - 0.006)
    self.__text:setSize(w - 3 * offset_x - size, size)

    self.__tooltip:setPosition(0, h)
    self.__tooltip:setSize(w, self.__tooltop_height or w)
end

---@param icon string
---@param value string
---@param title string
---@param text string
---@param height string
function ParameterFrame:set(icon, value, title, text, height)
    self:setIcon(icon)
    self:setValue(value)
    self:setTooltipIcon(icon)
    self:setTooltipTitle(title)
    self:setTooltipText(text)
    self:setTooltipHeight(height)
end

function ParameterFrame:setIcon(icon)
    BlzFrameSetTexture(self.__icon:getObj(), icon, 0, true)
end

function ParameterFrame:setValue(value)
    BlzFrameSetText(self.__text:getObj(), value)
end

function ParameterFrame:setTooltipIcon(icon)
    self.__tooltip:setIcon(icon)
end

function ParameterFrame:setTooltipTitle(title)
    self.__tooltip:setTitle(title)
end

function ParameterFrame:setTooltipText(text)
    self.__tooltip:setText(text)
end

function ParameterFrame:setTooltipHeight(height)
    self.__tooltop_height = height
end

return ParameterFrame