--=========
-- Include
--=========

---@type FrameClass
local Frame = require('Class.Frame.Frame')

--=======
-- Class
--=======

---@type FrameTextClass
local FrameText = newClass('FrameText', Frame)

---@class FrameText
local public = FrameText.public
---@class FrameTextClass
local static = FrameText.static
---@type table
local override = FrameText.override
---@type table(FrameText, table)
local private = {}

if not is_compiletime then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameText
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameText)
    local wc3_frame = BlzCreateFrameByType("TEXT", "TEXT", private.game_ui_frame, "", 0)
    instance = Frame.new(wc3_frame, instance)

    local priv = {
        text = "",
        font = "MasterFont",
        font_height = 0.012
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    Frame.public.free(self)
end

---@param text string
function public:setText(text)
    private[self].text = text
    BlzFrameSetText(self:getWc3Frame(), text)
end

---@return string
function public:getText()
    return private[self].text
end

---@param path string
function public:setFont(path)
    local priv = private[self]

    priv.font = path
    BlzFrameSetFont(self:getWc3Frame(), priv.font, priv.font_height, 0)
end

---@return string
function public:getFont()
    return private[self].font
end

---@param height number
function public:setFontHeight(height)
    local priv = private[self]

    priv.font_height = height
    BlzFrameSetFont(self:getWc3Frame(), priv.font, priv.font_height, 0)
end

---@return number
function public:getFontHeight()
    return private[self].font_height
end



return FrameText