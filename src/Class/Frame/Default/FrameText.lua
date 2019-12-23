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

---@param font_size number
---@param instance_data table | nil
---@return FrameText
function override.new(font_size, instance_data)
    local instance = instance_data or newInstanceData(FrameText)
    local wc3_frame = BlzCreateFrame(private.fdf_size_names[(font_size * 1000) // 1], private.game_ui_frame, 0, 0)
    instance = Frame.new(wc3_frame, instance)

    local priv = {
        text = "",
        font = "MasterFont",
        font_height = font_size,
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

---@param text string
function public:addText(text)
    private[self].text = private[self].text..text
    BlzFrameSetText(self:getWc3Frame(), private[self].text)
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

private.fdf_size_names = {'font_1','font_2','font_3','font_4','font_5','font_6','font_7','font_8','font_9','font_10','font_11','font_12','font_13','font_14','font_15','font_16','font_17','font_18','font_19','font_20','font_21','font_22','font_23','font_24','font_25','font_26','font_27','font_28','font_29','font_30'}
private.fdf_data = compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local File = WeObjEdit.Fdf.File
    local Text = WeObjEdit.Fdf.Text

    local out = File.new(getClassName(FrameText))
    for i = 1, 30 do
        local size = Text.new(private.fdf_size_names[i])
        size:setField(Text.DecorateFileNames)
        size:setField(Text.FontFlags, "FIXEDSIZE")
        size:setField(Text.FrameFont, {"MasterFont", 0.001 * i, ""})
        size:setField(Text.FontColor, {1.0, 1.0, 1.0, 1.0})
        size:setField(Text.FontShadowColor, {0.0, 0.0, 0.0, 0.9})
        size:setField(Text.FontShadowOffset, {0.001, -0.001})

        out:addObject(size)
    end

    return out:toRuntime()
end)

if not is_compiletime then
    private.game_ui_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    if not BlzLoadTOCFile(private.fdf_data.toc) then
        Log(Log.Err, getClassName(FrameText), "can not load toc file.")
    end
end


return FrameText