--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

local SimpleButtonType = Class.new('SimpleButtonType', FrameType)
---@class SimpleButtonType
local public = SimpleButtonType.public
---@class SimpleButtonTypeClass
local static = SimpleButtonType.static
---@type SimpleButtonTypeClass
local override = SimpleButtonType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance SimpleButtonType | nil
---@return SimpleButtonType
function override.new(uniq_name, separate_file, child_instance)
    local instance = child_instance or Class.allocate(SimpleButtonType)
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
        fdf:setField(private.SimpleButton.Field.Width, width)
    end
end

---@param height number
function public:setHeight(height)
    private.data[self].height = height

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.SimpleButton.Field.Height, height)
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

---@return string
function public:getTexture()
    return private.data[self].texture
end

---@return FrameType[]
function public:getChildrens()
    return private.data[self].childrens
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleButton
function private.newData(self)
    priv = {
        width = nil,
        height = nil,
        childrens = nil
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

private.default_width = 0.03
private.default_height = 0.03
private.default_texture = 'ReplaceableTextures\\CommandButtons\\BTNHeroPaladin'

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.SimpleButton = FdfEdit.SimpleButton
    private.Field = FdfEdit.SimpleButton.Field
end)

---@param name string
---@return string
function private.createFdf(name)
    return private.SimpleButton.new(name)
end

return static