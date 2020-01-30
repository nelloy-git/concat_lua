--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

---@type FrameClass
local Frame = require('Class.Frame.Frame')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

local FrameGluebutton = Class.new('FrameGluebutton', Frame)
---@class FrameGluebutton : Frame
local public = FrameGluebutton.public
---@class FrameGluebuttonClass : FrameClass
local static = FrameGluebutton.static
---@type FrameGluebuttonClass
local override = FrameGluebutton.override

local private = {}

--========
-- Static
--========

--- SimpleFrame by default
---@param button_type ButtonType
---@param child_instance FrameGluebutton
---@return FrameGluebutton
function override.new(button_type, child_instance)
    local instance = child_instance or Class.allocate(FrameGluebutton)
    instance = Frame.new(button_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========


--=========
-- Private
--=========

local private_data = {}
---@param self FrameGluebutton
---@param frame_type FrameType
---@return table
function private.new(self, frame_type)
    local priv = {
        texture_framehandle = BlzGetFrameByName(frame_type:getTextureFramehandleName(), 0)
    }

    if not priv.texture_framehandle then
        Log(Log.Err, FrameGluebutton, 'used FrameType does not have \"Texture\" field.')
        return nil
    end

    private_data[self] = priv
    return priv
end

---@param self FrameGluebutton
---@return table
function private.get(self)
    return private_data[self]
end

---@param self FrameGluebutton
function private.free(self)
    private_data[self] = nil
end

--=============
-- Compiletime
--=============

private.default_texture = 'war3mapImported\\frameFiles\\Transparent32x32.tga'
Compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local FdfFile = WeObjEdit.Fdf.File
    local SimpleButton = WeObjEdit.Fdf.SimpleButton
    local SimpleTexture = WeObjEdit.Fdf.SimpleTexture

    local texture = SimpleTexture.new('FrameGluebuttonDefaultTexture')
    texture:setField(SimpleTexture.File, private.default_texture)

    local frame = SimpleButton.new('FrameGluebuttonDefault')
    frame:setField(SimpleButton.Width, 0.05)
    frame:setField(SimpleButton.Height, 0.05)
    frame:setField(SimpleButton.Texture, texture)

    local file = FdfFile.new('FrameGluebuttonDefault')
    file:addObject(frame)

    private.default_frame_fdf_object = frame
    private.default_frame_fdf_file = file

    return 0
end)

private.default_frame_type_data = Compiletime(function() return private.default_frame_fdf_object:toRuntime() end)
private.default_frame_file_data = Compiletime(function() return private.default_frame_fdf_file:toRuntime() end)
private.default_frame_type = FrameType.load(private.default_frame_type_data, true)

if not IsCompiletime() then
    if not BlzLoadTOCFile(private.default_frame_file_data.toc) then
        Log(Log.Err, FrameGluebutton, "can not load default toc file.")
    end
end

return FrameGluebutton