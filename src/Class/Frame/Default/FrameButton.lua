--=========
-- Include
--=========

---@type Frame
local Frame = require('Class.Frame.Frame')
---@type FrameTypeClass
local FrameType = require('Class.Frame.FrameType')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

---@type FrameButtonClass
local FrameButton = newClass('FrameButton', Frame)

---@class FrameButton
local public = FrameButton.public
---@class FrameButtonClass
local static = FrameButton.static
---@type table
local override = FrameButton.override
---@type table(FrameButton, table)
local private = {}

--========
-- Static
--========

--- SimpleFrame by default
---@param frame_type FrameType | nil
---@param instance_data table | nil
---@return FrameButton
function override.new(frame_type, instance_data)
    local instance = instance_data or newInstanceData(FrameButton)

    if frame_type then
        instance = Frame.new(frame_type, instance)
    else
        instance = Frame.new(private.default_frame_type, instance)
    end

    local priv = {
        texture = nil,
        tooltip = nil,

        on_press_trigger = nil,
        on_press_action = nil,
    }
    private[instance] = priv

    return instance
end

--========
-- Public
--========

function public:free()
    local priv = private[self]
    if priv.on_press_trigger then priv.on_press_trigger:free() end
    if priv.on_press_action then priv.on_press_action:free() end

    private[self] = nil
    Frame.public.free(self)
end

---@param texture string
function public:setTexture(texture)
    private[self].texture = texture
    BlzFrameSetTexture(self:getFramehandle(), texture, 0, true)
end

---@return string
function public:getTexture()
    return private[self].texture
end

---@param frame Frame
---@return Frame | nil
function public:setTooltip(frame)
    local priv = private[self]

    if self:isSimpleframe() ~= frame:isSimpleframe() then
        local msg = ('simple and normal frames can not be tooltips for each other. \"setTooltip\" ignored.')
        Log(Log.Err, getClassName(Frame), msg)
        return nil
    end

    local cur = priv.tooltip
    priv.tooltip = frame
    if frame then
        BlzFrameSetTooltip(self:getFramehandle(), frame:getFramehandle())
        if frame:isSimple() then
            frame:setVisible(false)
        end
    else
        BlzFrameSetTooltip(self:getFramehandle(), nil)
    end

    return cur
end

---@return string
function public:getTooltip()
    return private[self].tooltip
end

---@param callback callback
function public:setPressCallback(callback)
    local priv = private[self]

    if not priv.on_press_trigger then
        priv.on_press_trigger = Trigger.new()
        priv.on_press_trigger:addFrameEvent(self:getFramehandle(), FRAMEEVENT_CONTROL_CLICK)
    end

    if priv.on_press_action then
        priv.on_press_trigger:removeAction(priv.on_press_action)
    end
    priv.on_press_action = priv.on_press:addAction(callback)
end

--=========
-- Private
--=========

private.default_texture = ''--1 'war3mapImported\\frameFiles\\Transparent32x32.tga'
compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local FdfFile = WeObjEdit.Fdf.File
    local SimpleButton = WeObjEdit.Fdf.SimpleButton
    local SimpleTexture = WeObjEdit.Fdf.SimpleTexture

    local texture = SimpleTexture.new('FrameButtonDefaultTexture')
    texture:setField(SimpleTexture.File, private.default_texture)

    local frame = SimpleButton.new('FrameButtonDefault')
    frame:setField(SimpleButton.Width, 0.05)
    frame:setField(SimpleButton.Height, 0.05)
    frame:setField(SimpleButton.Texture, {texture})

    local file = FdfFile.new('FrameButtonDefault')
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
        Log(Log.Err, getClassName(FrameButton), "can not load default toc file.")
    end
end

return FrameButton