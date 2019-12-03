--=========
-- Include
--=========

---@type FrameObjectClass
local FrameObject = require('Class.Frame.FrameObject')

--=======
-- Class
--=======

---@type FrameTextClass
local FrameText = newClass('FrameText', FrameObject)

---@class FrameText
local public = FrameText.public
---@class FrameTextClass
local static = FrameText.static
---@type table
local override = FrameText.override
---@type table(FrameText, table)
local private = {}

private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameText
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameText)
    local wc3_frame = BlzCreateFrameByType("TEXT", "TEXT", private.game_ui_frame, "", 0)
    instance = FrameObject.new(wc3_frame, instance)

    local priv = {
        text = "",
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    FrameObject.public.free(self)
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


return FrameText