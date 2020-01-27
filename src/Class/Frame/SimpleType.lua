--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type CompiletimeDataClass
local CompiletimeData = require('Class.CompiletimeData')

--=======
-- Class
--=======

local FrameSimpleType = Class.new('FrameSimpleType')
---@class FrameSimpleType
local public = FrameSimpleType.public
---@class FrameSimpleClassType
local static = FrameSimpleType.static
---@type FrameSimpleClassType
local override = FrameSimpleType.override
local private = {}

--=========
-- Static
--=========

---@alias FrameSimpleTypeBase string
---@type FrameSimpleTypeBase[]
static.Type = {
    FRAME = 1,
    BUTTON = 2,
}

---@param uniq_name string
---@param base_frame FrameSimpleTypeBase
---@param child_instance FrameSimpleType | nil
---@return FrameSimpleType
function static.new(uniq_name, base_frame, child_instance)
    local instance = child_instance or Class.allocate(FrameSimpleType)
    private.newData(instance, uniq_name, base_frame)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private[self].name
end

---@return FrameSimpleTypeBase
function public:getBase()
    return private[self].base
end

---@return string
function public:getTextureFrameName()
    return private[self].texture_name
end

---@return string
function public:getStringFrameName()
    return private[self].string_name
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('number', FrameSimpleType)
private.compiletime_data = CompiletimeData.new(FrameSimpleType)
private.default_texture = 'war3mapImported\\frameFiles\\Transparent32x32.tga'
local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.File = FdfEdit.File
    private.SimpleFrame = FdfEdit.SimpleFrame
    private.SimpleButton = FdfEdit.SimpleButton
    private.SimpleString = FdfEdit.SimpleString
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param base any
---@return boolean
function private.isSimpleBase(base)
    for _, v in pairs(static.Type) do
        if base == v then
            return true
        end
    end
    return false
end

function private.createWc3SimpleFrame(name, base)
    if not private.isSimpleBase(base) then
        Log.error(FrameSimpleType, 'wrong simple frame base.', 3)
    end

    local texture = private.SimpleTexture.new(name..'Texture')
    texture:setField(private.SimpleTexture.Field.File, private.default_texture)
    local string = private.SimpleString.new(name..'String')
    string:setField(private.SimpleString.Field.Font, {'fonts\\nim_____.ttf', 0.009})
    string:setField(private.SimpleString.Field.Anchor, {'TOPLEFT', 0, 0})
    --string:setField(private.SimpleString.Field.Font, {'InfoPanelTextFont', 0.009})
    --tring:setField(private.SimpleString.Field.Width, 0.05)
    --string:setField(private.SimpleString.Field.Height, 0.05)

    local frame
    local fields
    if base == static.Type.FRAME then
        frame = private.SimpleFrame.new(name)
        fields = private.SimpleFrame.Field
    elseif base == static.Type.BUTTON then
        frame = private.SimpleButton.new(name)
        fields = private.SimpleButton.Field
    end

    --frame:setField(fields.DecorateFileNames)
    frame:setField(fields.Width, 0.05)
    frame:setField(fields.Height, 0.05)
    frame:setField(fields.Texture, {texture})
    frame:setField(fields.String, {string})

    local file = private.File.new(name)
    file:addObject(frame)

    return file:toRuntime()
end

--private.test = private.createWc3SimpleFrame('Test', static.Base.FRAME)

---@param instance FrameSimpleType
function private.newData(instance, uniq_name, base_frame)
    local priv = {
        name = uniq_name,
        base = base_frame,
        texture_name = uniq_name..'Texture',
        string_name = uniq_name..'String',
    }

    if IsCompiletime() then
        if private.compiletime_data:get(uniq_name) then
            Log.error(FrameSimpleType, 'name is not unique.', 3)
        end
        priv.file = private.createWc3SimpleFrame(uniq_name, base_frame)
        private.compiletime_data:set(uniq_name, priv.file.toc)
    end

    priv.toc = private.compiletime_data:get(uniq_name)

    if not IsCompiletime() then
        BlzLoadTOCFile(priv.toc)
    end

    private[instance] = priv
end

---@param instance FrameSimpleType
function private.freeData(instance)
    private[instance] = nil
end

return static