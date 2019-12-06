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

---@type FrameSpringColumnClass
local FrameSpringColumn = newClass('FrameSpringColumn', FrameBackdrop)

---@class FrameSpringColumn : FrameBackdrop
local public = FrameSpringColumn.public
---@class FrameSpringColumnClass : FrameBackdropClass
local static = FrameSpringColumn.static
---@type table
local override = FrameSpringColumn.override
---@type table(FrameSpringColumn, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameSpringColumn
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameSpringColumn)
    instance = FrameBackdrop.new(instance)

    local priv = {
        left_offset = 0,
        right_offset = 0,
        top_offset = 0,
        bottom_offset = 0,

        rows = 1,
        is_row_fixed = {},
        row_part = {},
        row_height = {},

        elements = {}
    }
    private[instance] = priv

    private.updateRowHeight(instance)

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

function public:onRowsChange()
    private.applyAllElementsPos(self)
end

function public:onCellChange()
end

function public:onOffsetsChange()
    private.applyAllElementsPos(self)
end

function public:onRowHeightPartChange()
    private.applyAllElementsPos(self)
end

---@param rows number
---@return Frame[]
function public:setRows(rows)
    local priv = private[self]

    local free_frames = {}
    if rows < priv.rows then
        for i = rows + 1, priv.rows do
            table.insert(free_frames, #free_frames + 1, priv.elements[i])
            priv.row_part[i] = nil
            priv.row_height[i] = nil
            priv.is_row_fixed[i] = nil
            priv.elements[i] = nil
        end
    end
    priv.rows = rows

    self:onRowsChange()

    return free_frames
end

---@return number
function public:getRows()
    return private[self].rows
end

--- Function returns previous element from table.
---@param frame Frame
---@param row number
---@return Frame | nil
function public:setCell(frame, row)
    local priv = private[self]

    if row < 1 or row % 1 ~= 0 then
        Log(Log.Err, getClassName(FrameSpringColumn),
            "row must be integer more or equal 1.")
        return nil
    end

    if row > priv.rows then
        Log(Log.Err, getClassName(FrameSpringColumn),
            "row for element adding can not be greater than size.")
        return nil
    end

    local prev = priv.elements[row]
    priv.elements[row] = frame

    frame:setParent(self:getWc3Frame())
    private.applyElementPos(self, row)
    self:onCellChange()

    return prev
end

---@param row number
---@return Frame | nil
function public:getCell(row)
    return private[self].elements[row]
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
---@param row number
function public:setRowHeightPart(part, row)
    local priv = private[self]

    if part >= 0 then
        priv.is_row_fixed[row] = true
    else
        priv.is_row_fixed[row] = false
    end
    priv.row_part[row] = part
    self:onRowHeightPartChange()
end

function private.applyAllElementsPos(self)
    private.updateRowHeight(self)

    for i = 1, #private[self].elements do
        private.applyElementPos(self, i)
    end
end

---@param self FrameSpringColumn
---@param row number
function private.applyElementPos(self, row)
    local priv = private[self]

    local element = priv.elements[row]
    if not element then return nil end

    local x = priv.left_offset
    local y = priv.bottom_offset
    for i = 1, row - 1 do
        y = y + priv.row_height[i]
    end
    local w = self:getWidth() - (priv.left_offset + priv.right_offset)
    local h = priv.row_height[row]

    element:setX(x)
    element:setY(y)
    element:setWidth(w)
    element:setHeight(h)
end

---@param self FrameSpringColumn
function private.updateRowHeight(self)
    local priv = private[self]

    local fixed_rows = 0
    local fixed_height_part = 0
    for i = 1, priv.rows do
        if priv.is_row_fixed[i] then
            fixed_rows = fixed_rows + 1
            fixed_height_part = fixed_height_part + priv.row_part[i]
        end
    end

    local free_part = 1 - fixed_height_part
    if free_part < 0 then free_part = 0 end

    local free_rows = priv.rows - fixed_rows
    local free_row_part = free_part / free_rows
    local height = self:getHeight() - (priv.bottom_offset + priv.top_offset)
    for i = 1, priv.rows do
        if priv.is_row_fixed[i] then
            priv.row_height[i] = priv.row_part[i] * height
        else
            priv.row_height[i] = free_row_part * height
        end
    end
end

return FrameSpringColumn