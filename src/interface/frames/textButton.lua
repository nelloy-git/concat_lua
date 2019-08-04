---@type InterfaceFrame
local Frame = require('interface.frame')

---@class InterfaceFrameTextButton : InterfaceFrame
local textButton = {}
local textButton_meta = {__index = textButton}
setmetatable(textButton, {__index = Frame})

---@param text string
---@param x number
---@param y number
---@param parent InterfaceFrame
function textButton.new(text, x, y, parent)
    local btn = Frame.new("ScriptDialogButton", parent, 0, 0)
    setmetatable(btn, textButton_meta)

    btn:setText(text)
    btn:setAbsPoint(FRAMEPOINT_TOPLEFT, x, y)

    return btn
end

function textButton:setText(text)
    BlzFrameSetText(self.frame_obj, text)
end

return textButton