--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

local SimpleFrameType = Class.new('SimpleFrameType', FrameType)
---@class SimpleFrameType  : FrameType
local public = SimpleFrameType.public
---@class SimpleFrameTypeClass : FrameTypeClass
local static = SimpleFrameType.static
---@type SimpleFrameTypeClass
local override = SimpleFrameType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance SimpleFrameType | nil
---@return SimpleFrameType
function override.new(uniq_name, separate_file, child_instance)
    local instance = child_instance or Class.allocate(SimpleFrameType)
    instance = FrameType.new(uniq_name, private.createFdf, separate_file, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return boolean
function public:isSimple()
    return true
end

---@param width number
function public:setWidth(width)
    private.data[self].width = width

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Width, width)
    end
end

---@param height number
function public:setHeight(height)
    private.data[self].height = height

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Height, height)
    end
end

---@param list FrameType[]
function public:setChildrens(list)
    for i = 1, #list do
        if not list[i]:isSimple() then
            Log.error(self, 'Normal frame can not be a child of simple frame.', 2)
        end
    end

    private.data[self].childrens = list
    local fdf = self:getFdf()
    if fdf then
        local fdf_list = {}
        for i = 1, #list do
            table.insert(fdf_list, list[i]:getFdf())
        end
        fdf:setField(private.Field.ChildFrames, fdf_list)
    end
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
end

---@return FrameType[]
function public:getChildrens()
    return private.data[self].childrens
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleFrame
function private.newData(self)
    priv = {
        width = 0,
        height = 0,
        childrens = {},
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.File = FdfEdit.File
    private.SimpleFrame = FdfEdit.SimpleFrame
    private.Field = FdfEdit.SimpleFrame.Field
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param name string
---@return string
function private.createFdf(name)
    return private.SimpleFrame.new(name)
end

return static