--=========
-- Include
--=========

local Class = require('Utils.Class.API')

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
    if FrameType.isExist(uniq_name) then
        Log.error(SimpleFrameType, '\"uniq_name\" must be unique.', 2)
    end

    if type(separate_file) ~= 'boolean' then
        Log.error(SimpleFrameType, '\"separate_file\" must be boolean.', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleFrameType) then
        Log.error(SimpleFrameType, '\"child_instance\" must be SimpleFrameType or nil.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleFrameType)
    instance = FrameType.new(uniq_name, private.createFdf, separate_file, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Can not be used with width, height and anchor parameters.
function public:setAllPoints()
    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.SetAllPoints, '')
    end
end

---@param anchor string | 'TOPLEFT' | 'TOP' | 'TOPRIGHT' | 'LEFT' | 'CENTER' | 'RIGHT' | 'BOTTOMLEFT' | 'BOTTOM' | 'RIGHT'
---@param offset_x number
---@param offset_y number
function public:setAnchor(anchor, offset_x, offset_y)
    private.data[self].anchor = anchor
    private.data[self].anchor_x = offset_x
    private.data[self].anchor_y = offset_y

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Anchor, {anchor, offset_x, offset_y})
    end
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
    local fdf = self:getFdf()
    if fdf then
        private.data[self].childrens = list

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

---@param self SimpleFrameType
function private.newData(self)
    local priv = {
        width = nil,
        height = nil,

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
    private.SimpleFrame = FdfEdit.SimpleFrame
    private.Field = FdfEdit.SimpleFrame.Field
end)

---@param name string
---@return string
function private.createFdf(name)
    return private.SimpleFrame.new(name)
end

return static