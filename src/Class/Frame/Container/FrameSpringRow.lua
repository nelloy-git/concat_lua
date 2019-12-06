--=========
-- Include
--=========

---@type FrameClass
local Frame = require('Class.Frame.Frame')
---@type FrameBackdropClass
local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')

--=======
-- Class
--=======

---@type FrameSpringRowClass
local FrameSpringRow = newClass('FrameSpringRow', FrameBackdrop)

---@class FrameSpringRow : FrameBackdrop
local public = FrameSpringRow.public
---@class FrameSpringRowClass : FrameBackdropClass
local static = FrameSpringRow.static
---@type table
local override = FrameSpringRow.override
---@type table(FrameSpringRow, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameSpringRow
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameSpringRow)
    instance = FrameBackdrop.new(instance)

    local priv = {
        left_offset = 0,
        right_offset = 0,
        top_offset = 0,
        bottom_offset = 0,

        columns = 1,
        is_column_fixed = {},
        column_part = {},
        column_width = {},

        elements = {}
    }
    private[instance] = priv

    private.updateColumnsWidth(instance)

    return instance
end

--- Function returns removed frames.
---@return Frame[]
function public:free()
    local priv = private[self]

    local free_frames = {}
    for i = 1, #priv.elements do
        free_frames[i]:setParent(nil)
        table.insert(free_frames, #free_frames + 1, free_frames[i])
    end

    private[self] = nil
    FrameBackdrop.public.free(self)

    return free_frames
end

--- Overrides Frame.public.onSizeChange
function public:onSizeChange()
    Frame.public.onSizeChange(self)
    private.applyAllElementsPos(self)
end

function public:onColumnsChange()
    private.applyAllElementsPos(self)
end

function public:onCellChange()
end

function public:onOffsetsChange()
    private.applyAllElementsPos(self)
end

function public:onColumnWidthPartChange()
    private.applyAllElementsPos(self)
end

---@param columns number
---@return Frame[]
function public:setColumns(columns)
    local priv = private[self]

    local free_frames = {}
    if columns < priv.columns then
        for i = columns + 1, priv.columns do
            table.insert(free_frames, #free_frames + 1, priv.elements[i])
            priv.column_part[i] = nil
            priv.column_width[i] = nil
            priv.is_column_fixed[i] = nil
            priv.elements[i] = nil
        end
    end
    priv.columns = columns

    self:onColumnsChange()

    return free_frames
end

---@return number
function public:getColumns()
    return private[self].columns
end

--- Function returns previous element from table.
---@param frame Frame
---@param column number
---@return Frame | nil
function public:setCell(frame, column)
    local priv = private[self]

    if column < 1 or column % 1 ~= 0 then
        Log(Log.Err, getClassName(FrameSpringRow),
            "column must be integer more or equal 1.")
        return nil
    end

    if column > priv.columns then
        Log(Log.Err, getClassName(FrameSpringRow),
            "column for element adding can not be greater than size.")
        return nil
    end

    local prev = priv.elements[column]
    priv.elements[column] = frame

    frame:setParent(self:getWc3Frame())
    private.applyElementPos(self, column)
    self:onCellChange()

    return prev
end

---@param column number
---@return Frame | nil
function public:getCell(column)
    return private[self].elements[column]
end

---@param left number
---@param right number
---@param top number
---@param bottom number
function public:setOffsets(left, right, top, bottom)
    local priv = private[self]

    priv.left_offset = left
    priv.right_offset = right
    priv.top_offset = top
    priv.bottom_offset = bottom

    self:onOffsetsChange()
end

--- Returns left, right, top and bottom offsets
---@return number, number, number, number
function public:getOffsets()
    local priv = private[self]
    return priv.left_offset, priv.right_offset, priv.top_offset, priv.bottom_offset
end

--- Set part < 0 for auto size.
---@param part number
---@param column number
function public:setColumnWidthPart(part, column)
    local priv = private[self]

    if part >= 0 then
        priv.is_column_fixed[column] = true
    else
        priv.is_column_fixed[column] = false
    end
    priv.column_part[column] = part
    self:onColumnWidthPartChange()
end

function private.applyAllElementsPos(self)
    private.updateColumnsWidth(self)

    for i = 1, #private[self].elements do
        private.applyElementPos(self, i)
    end
end

---@param self FrameSpringRow
---@param column number
function private.applyElementPos(self, column)
    local priv = private[self]

    local element = priv.elements[column]
    --if not element then return nil end

    local x = priv.left_offset
    for i = 1, column - 1 do
        x = x + priv.column_width[i]
    end
    local y = priv.bottom_offset
    local w = priv.column_width[column]
    local h = self:getHeight() - (priv.bottom_offset + priv.top_offset)

    element:setX(x)
    element:setY(y)
    element:setWidth(w)
    element:setHeight(h)
end

---@param self FrameSpringRow
function private.updateColumnsWidth(self)
    local priv = private[self]

    local fixed_columns = 0
    local fixed_width_part = 0
    for i = 1, priv.columns do
        if priv.is_column_fixed[i] then
            fixed_columns = fixed_columns + 1
            fixed_width_part = fixed_width_part + priv.column_part[i]
        end
    end

    local free_part = 1 - fixed_width_part
    if free_part < 0 then free_part = 0 end

    local free_columns = priv.columns - fixed_columns
    local free_column_part = free_part / free_columns
    local width = self:getWidth() - (priv.left_offset + priv.right_offset)
    for i = 1, priv.columns do
        if priv.is_column_fixed[i] then
            priv.column_width[i] = priv.column_part[i] * width
        else
            priv.column_width[i] = free_column_part * width
        end
    end
end

return FrameSpringRow