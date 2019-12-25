--=========
-- Include
--=========

---@type FrameClass
local Frame = require('Class.Frame.Frame')
---@type FrameTypeClass
local FrameType = require('Class.Frame.FrameType')

--=======
-- Class
--=======

---@type FrameBackdropClass
local FrameBackdrop = newClass('FrameBackdrop', Frame)

---@class FrameBackdrop : Frame
local public = FrameBackdrop.public
---@class FrameBackdropClass : FrameClass
local static = FrameBackdrop.static
---@type table
local override = FrameBackdrop.override
---@type table(FrameBackdrop, table)
local private = {}

--========
-- Static
--========

--- SimpleFrame by default
---@param frame_type FrameType | nil
---@param instance_data table | nil
---@return FrameBackdrop
function override.new(frame_type, instance_data)
    local instance = instance_data or newInstanceData(FrameBackdrop)

    if frame_type then
        instance = Frame.new(frame_type, instance)
    else
        instance = Frame.new(private.default_frame_type, instance)
    end

    local priv = {
        texture = nil,
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

function public:onTextureChange()
    local priv = private[self]
    if priv.texture then
        BlzFrameSetTexture(self:getFramehandle(self), priv.texture, 0, true)
    else
        BlzFrameSetTexture(self:getFramehandle(self), 'war3mapImported\\frameFiles\\Transparent32x32.tga', 0, true)
    end
end

---@param texture string
function public:setTexture(texture)
    private[self].texture = texture
    self:onTextureChange()
end

---@return string
function public:getTexture()
    return private[self].texture
end

--=========
-- Private
--=========

private.default_texture = 'war3mapImported\\frameFiles\\Transparent32x32.tga'
compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local FdfFile = WeObjEdit.Fdf.File
    local SimpleFrame = WeObjEdit.Fdf.SimpleFrame
    local SimpleTexture = WeObjEdit.Fdf.SimpleTexture

    local texture = SimpleTexture.new('FrameBackdropDefaultTexture')
    texture:setField(SimpleTexture.File, private.default_texture)

    local frame = SimpleFrame.new('FrameBackdropDefault')
    frame:setField(SimpleFrame.Width, 0.05)
    frame:setField(SimpleFrame.Height, 0.05)
    frame:setField(SimpleFrame.Texture, {texture})

    local file = FdfFile.new('FrameBackdropDefault')
    file:addObject(frame)

    private.default_frame_fdf_object = frame
    private.default_frame_fdf_file = file

    return 0
end)

private.default_frame_type_data = compiletime(function() return private.default_frame_fdf_object:toRuntime() end)
private.default_frame_file_data = compiletime(function() return private.default_frame_fdf_file:toRuntime() end)
private.default_frame_type = FrameType.new(private.default_frame_type_data, true)

if not is_compiletime then
    if not BlzLoadTOCFile(private.default_frame_file.toc) then
        Log(Log.Err, getClassName(FrameBackdrop), "can not load default toc file.")
    end
end

return FrameBackdrop