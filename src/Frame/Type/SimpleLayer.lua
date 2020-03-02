--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

local SimpleLayerType = Class.new('SimpleLayerType', FrameType)
---@class SimpleLayerType  : FrameType
local public = SimpleLayerType.public
---@class SimpleLayerTypeClass : FrameTypeClass
local static = SimpleLayerType.static
---@type SimpleLayerTypeClass
local override = SimpleLayerType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance SimpleLayerType | nil
---@return SimpleLayerType
function override.new(uniq_name, separate_file, child_instance)
    if FrameType.isExist(uniq_name) then
        Log.error(SimpleLayerType, '\"uniq_name\" must be unique.', 2)
    end

    if type(separate_file) ~= 'boolean' then
        Log.error(SimpleLayerType, '\"separate_file\" must be boolean.', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleLayerType) then
        Log.error(SimpleLayerType, '\"child_instance\" must be SimpleLayerType or nil.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleLayerType)
    instance = FrameType.new(uniq_name, private.createFdf, separate_file, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

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
        childrens = {}
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.SimpleLayer = FdfEdit.SimpleLayer
    private.Field = FdfEdit.SimpleLayer.Field
end)

---@param name string
---@return string
function private.createFdf(name)
    return private.SimpleLayer.new(name)
end

return static