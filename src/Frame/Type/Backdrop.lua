--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.FrameType')

--=======
-- Class
--=======

local BackdropType = Class.new('BackdropType', FrameType)
---@class BackdropType  : FrameType
local public = BackdropType.public
---@class BackdropTypeClass : FrameTypeClass
local static = BackdropType.static
---@type BackdropTypeClass
local override = BackdropType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param separate_file boolean
---@param child_instance BackdropType | nil
---@return BackdropType
function override.new(uniq_name, separate_file, child_instance)
    local instance = child_instance or Class.allocate(BackdropType)
    instance = FrameType.new(uniq_name, private.createFdf, separate_file, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return boolean
function public:isSimple()
    return false
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

---@param texture string
function public:setBackground(texture)
    private.data[self].background = texture

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Background, texture)
    end
end

---@param flags string
function public:setCornerFlags(flags)
    private.data[self].corner_flags = flags

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.CornerFlags, flags)
    end
end

---@param size number
function public:setCornerSize(size)
    private.data[self].corner_size = size

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.CornerSize, size)
    end
end

---@param insets number[]
function public:setInsets(insets)
    private.data[self].insets = insets

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.Insets, insets)
    end
end

---@param texture string
function public:setEdge(texture)
    private.data[self].edge = texture

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.EdgeFile, texture)
    end
end

---@param list FrameType[]
function public:setChildrens(list)
    private.data[self].childs = list

    local fdf = self:getFdf()
    if fdf then
        fdf:setField(private.Field.ChildFrames, list)
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
function public:getBackground()
    return private.data[self].background
end

---@return string
function public:getCornerFlags()
    return private.data[self].corner_flags
end

---@return number
function public:getCornerSize()
    return private.data[self].corner_size
end

---@return number[]
function public:getInsets()
    return private.data[self].insets
end

---@return string
function public:getEdge()
    return private.data[self].edge
end

---@return FrameType[]
function public:getChildrens()
    return private.data[self].childs
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleFrame
function private.newData(self)
    priv = {
        width = private.default_width,
        height = private.default_height,
        background = private.default_background,
        corner_flags = private.default_corner_flags,
        corner_size = private.default_corner_size,
        insets = private.default_insets,
        edge = private.default_edge,
        childs = {}
    }
    private.data[self] = priv
end

--=============
-- Compiletime
--=============

private.default_width = 0.03
private.default_height = 0.03
private.default_background = 'ReplaceableTextures\\CommandButtons\\BTNHeroPaladin'
private.default_corner_flags = 'UL|UR|BL|BR|T|L|B|R'
private.default_corner_size = 0.0125
private.default_insets = {0.005, 0.005, 0.005, 0.005}
private.default_edge = "UI\\Widgets\\ToolTips\\Human\\human-tooltip-border.blp"

local _ = Compiletime(function()
    ---@type FdfEdit
    local FdfEdit = require('compiletime.FdfEdit')
    private.Backdrop = FdfEdit.Backdrop
    private.Field = FdfEdit.Backdrop.Field
end)

---@param name string
---@return string
function private.createFdf(name)
    local frame = private.Backdrop.new(name)
    local field = private.Backdrop.Field

    frame:setField(field.Width, private.default_width)
    frame:setField(field.Height, private.default_height)
    frame:setField(field.Background, private.default_background)
    frame:setField(field.CornerFlags, private.default_corner_flags)
    frame:setField(field.CornerSize, private.default_corner_size)
    frame:setField(field.Insets, private.default_insets)
    frame:setField(field.EdgeFile, private.default_edge)
    frame:setField(field.ChildFrames, {})

    return frame
end

return static