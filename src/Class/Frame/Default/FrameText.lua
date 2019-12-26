--=========
-- Include
--=========

local Class = require('Utils.Class')

local Frame = require('Class.Frame.Frame')
local FrameType = require('Class.Frame.FrameType')

--=======
-- Class
--=======

---@class FrameTextClass : FrameClass
local FrameText = Class.newClass('FrameText', Frame)

---@class FrameText : Frame
local public = FrameText.public
---@type FrameTextClass
local static = FrameText.static
---@type FrameTextClass
local override = FrameText.override

local private = {}

if not is_compiletime then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

--========
-- Static
--========

---@param frame_type number
---@param instance_data table | nil
---@return FrameText
function override.new(frame_type, instance_data)

    local instance = instance_data or Class.newInstanceData(FrameText)
    if frame_type then
        instance = Frame.new(frame_type, instance)
    else
        instance = Frame.new(private.default_frame_type, instance)
    end

    local priv = {
        text = "",
        font = private.default_font,
        font_height = private.default_font_size,
    }
    private[instance] = priv

    return instance
end

--========
-- Public
--========

function public:free()
    private[self] = nil
    Frame.public.free(self)
end

---@param text string
function public:setText(text)
    private[self].text = text
    BlzFrameSetText(self:getFramehandle(), text)
end

---@param text string
function public:addText(text)
    private[self].text = private[self].text..text
    BlzFrameSetText(self:getFramehandle(), private[self].text)
end

---@return string
function public:getText()
    return private[self].text
end

---@param path string
function public:setFont(path)
    local priv = private[self]

    priv.font = path
    BlzFrameSetFont(self:getFramehandle(), priv.font, priv.font_height, 0)
end

---@return string
function public:getFont()
    return private[self].font
end

--=========
-- Private
--=========

private.default_font = 'MasterFont'
private.default_font_size = 0.012
compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local FdfFile = WeObjEdit.Fdf.File
    local SimpleButton = WeObjEdit.Fdf.SimpleButton
    local SimpleString = WeObjEdit.Fdf.SimpleString

    local str = SimpleString.new('FrameTextDefaultString')
    str:setField(SimpleString.Font, {private.default_font, private.default_font_size})

    local frame = SimpleButton.new('FrameTextDefault')
    frame:setField(SimpleButton.Width, 0.05)
    frame:setField(SimpleButton.Height, 0.05)
    frame:setField(SimpleButton.String, {str})

    local file = FdfFile.new('FrameTextDefault')
    file:addObject(frame)

    private.default_frame_fdf_object = frame
    private.default_frame_fdf_file = file

    return 0
end)

private.default_frame_type_data = compiletime(function() return private.default_frame_fdf_object:toRuntime() end)
private.default_frame_file_data = compiletime(function() return private.default_frame_fdf_file:toRuntime() end)
private.default_frame_type = FrameType.load(private.default_frame_type_data, true)

if not is_compiletime then
    if not BlzLoadTOCFile(private.default_frame_file_data.toc) then
        Log(Log.Err, FrameText, "can not load default toc file.")
    end
end

return FrameText