--=========
-- Include
--=========

local Class = require('Utils.Class')

local Frame = require('Class.Frame.Frame')
local FrameType = require('Class.Frame.FrameType')

--=======
-- Class
--=======

---@class FrameBackdropClass : FrameClass
local FrameBackdrop = Class.newClass('FrameBackdrop', Frame)

---@class FrameBackdrop : Frame
local public = FrameBackdrop.public
---@type FrameBackdropClass
local static = FrameBackdrop.static
---@type FrameBackdropClass
local override = FrameBackdrop.override

local private = {}

--========
-- Static
--========

--- SimpleFrame by default
---@param frame_type FrameType | nil
---@param instance_data table | nil
---@return FrameBackdrop
function override.new(frame_type, instance_data)
    local instance = instance_data or Class.newInstanceData(FrameBackdrop)
    if not frame_type then
        frame_type = private.default_frame_type
    end
    instance = Frame.new(frame_type, instance)
    private.new(instance, frame_type)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    Frame.public.free(self)
end

---@param texture string
function public:setTexture(texture)
    private.get(self).texture = texture
    if texture then
        BlzFrameSetTexture(self:getFramehandle(), texture, 0, true)
    else
        BlzFrameSetTexture(self:getFramehandle(), private.default_texture, 0, true)
    end
end

---@return string
function public:getTexture()
    return private[self].texture
end

--=========
-- Private
--=========

local private_data = {}
---@param self FrameType
---@param frame_type FrameType
---@return FrameTypePrivate
function private.new(self, frame_type)
    local priv = {
        texture = nil,
        texture_framehandle = BlzGetFrameByName(frame_type:getTextureFramehandleName(), 0)
    }

    if not priv.texture_framehandle then
        Log(Log.Err, FrameBackdrop, 'used FrameType does not have \"Texture.name\" field.')
        return nil
    end

    private_data[self] = priv
    return priv
end

---@param self FrameType
---@return FrameTypePrivate
function private.get(self)
    return private_data[self]
end

---@param self FrameType
function private.free(self)
    private_data[self] = nil
end

--=============
-- Compiletime
--=============

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
    frame:setField(SimpleFrame.Texture, texture)

    local file = FdfFile.new('FrameBackdropDefault')
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
        Log(Log.Err, FrameBackdrop, "can not load default toc file.")
    end
end

return FrameBackdrop