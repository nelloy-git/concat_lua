--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')

---@type FrameCellClass
local FrameCell = require('Class.Frame.Container.FrameCell')
---@type FrameTypeClass
local FrameType = require('Class.Frame.FrameType')

--=======
-- Class
--=======

local FrameSpringColumn = Class.new('FrameSpringColumn')
---@class FrameSpringColumn : FrameBackdrop
local public = FrameSpringColumn.public
---@class FrameSpringColumnClass : FrameBackdropClass
local static = FrameSpringColumn.static
---@type FrameSpringColumnClass
local override = FrameSpringColumn.override
local private = {}

--========
-- Static
--========

--- SimpleFrame by default.
---@param owner Frame
---@param child_instance FrameSpringColumn | nil
---@return FrameSpringColumn
function static.new(owner, child_instance)
    if not owner then
        frame_type = private.default_frame_type
    end
    local instance = child_instance or Class.allocate(FrameSpringColumn)
    instance = FrameBackdrop.new(frame_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param row number
---@return boolean
function public:isRowHeightFree(row)
    local priv = private[self]
    local b = priv.is_row_abs[row] or priv.is_row_ratio[row]
    return not b
end

---@param row number
---@return boolean
function public:isRowHeightRatio(row)
    return private[self].is_row_ratio[row]
end

---@param row number
---@return boolean
function public:isRowHeightAbs(row)
    return private[self].is_row_abs[row]
end

---@param count number
---@return Frame[]
function public:setRows(count)
    local priv = private[self]

    if count < 1 or count % 1 ~= 0 then
        Log(Log.Err, FrameSpringColumn,
            "rows count must be integer more or equal 1.")
        return nil
    end

    local free_frames = {}
    if count < priv.rows then
        for i = priv.rows, count + 1 do
            table.insert(free_frames, #free_frames + 1, priv.elements[i])
            priv.row_ratio[i] = nil
            priv.row_height[i] = nil
            priv.is_row_ratio[i] = nil
            priv.elements[i] = nil
        end
    end
    priv.rows = count

    return free_frames
end

---@return number
function public:getRows()
    return private[self].rows
end

--- Set ratio < 0 for auto size.
---@param ratio number
---@param row number
function public:setRowRatioHeight(ratio, row)
    local priv = private[self]

    if ratio >= 0 then
        priv.is_row_ratio[row] = true
        priv.is_row_abs[row] = false
        priv.row_ratio[row] = ratio
    else
        priv.is_row_ratio[row] = false
        priv.is_row_abs[row] = false
        priv.row_ratio[row] = nil
    end
end

---@param row number
---@return number
function public:getRowHeightPart(row)
    local priv = private[self]

    if priv.is_row_ratio[row] then
        return priv.row_ratio[row]
    else
        return -1
    end
end

--- Set height < 0 for auto size.
---@param height number
---@param row number
function public:setRowAbsHeight(height, row)
    local priv = private[self]

    if height >= 0 then
        priv.is_row_ratio[row] = false
        priv.is_row_abs[row] = true
        priv.row_height[row] = height
    else
        priv.is_row_ratio[row] = false
        priv.is_row_abs[row] = false
        priv.row_ratio[row] = nil
    end
end

---@param row number
---@return number
function public:getRowAbsHeight(row)
    local priv = private[self]

    if priv.is_row_abs[row] then
        return priv.row_height[row]
    end
    return -1
end

--- Function returns previous element from table.
---@param frame Frame
---@param row number
---@return Frame | nil
function public:setCell(frame, row)
    local priv = private[self]

    if row < 1 or row % 1 ~= 0 then
        Log(Log.Err, FrameSpringColumn,
            "row must be integer more or equal 1.")
        return nil
    end

    if row > priv.rows then
        Log(Log.Err, FrameSpringColumn,
            "row for element adding can not be greater than size.")
        return nil
    end

    local prev = priv.elements[row]
    priv.elements[row] = frame

    if frame then
        --frame:setParent(self:getFramehandle())
    end

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
end

--- Returns left, right, top and bottom offsets
---@return number, number, number, number
function public:getOffsets()
    local priv = private[self]
    return priv.left_offset, priv.right_offset, priv.top_offset, priv.bottom_offset
end

--- Function returns removed frames.
---@return Frame[]
function public:free()
    local priv = private[self]

    local free_frames = {}
    for i = 1, #priv.elements do
        --free_frames[i]:setParent(nil)
        table.insert(free_frames, #free_frames + 1, free_frames[i])
    end

    private.freeData(self)
    FrameBackdrop.public.free(self)

    return free_frames
end

--=========
-- Private
--=========

private.SIZE_TYPE = {
    RATIO = 0,
    ABS = 1,
    FREE = 2
}

local private_data = {}

---@param self FrameSpringColumn
function private.newData(self)
    local priv = {
        border_left = 0,
        border_right = 0,
        border_top = 0,
        border_bottom = 0,

        cell_border_left = 0,
        cell_border_right = 0,
        cell_border_top = 0,
        cell_border_bottom = 0,

        cells_count = 1,
        cells = {[1] = FrameCell.new(self)},
        cells_type = {[1] = private.SIZE_TYPE.FREE},
        cells_size = {
            [private.SIZE_TYPE.RATIO] = {[1] = -1},
            [private.SIZE_TYPE.ABS] = {[1] = -1},
            RESULT = {[1] = 0}
        },
        cells_center = {[1] = 0},
    }
    private_data[self] = priv
end

---@param self FrameSpringColumn
---@return Frame[]
function private.freeData(self)
    local priv = private[self]

    local items = {}
    for i = 1, priv.cells_count do
        local it = priv.cells[i]:free()
        if it then items:insert(it) end
    end

    private_data[self] = nil

    return items
end

---@param self FrameSpringColumn
function private.applyAllElementsPos(self)
    private.updateRowHeight(self)

    for row, element in pairs(private[self].elements) do
        private.applyElementPos(self, element, row)
    end
end

---@param self FrameSpringColumn
---@param row number
function private.applyElementPos(self, element, row)
    local priv = private[self]

    --local element = priv.elements[row]
    --if not element then return nil end

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
function private.updateCells(self)
    local priv = private[self]

    private.updateResultSize(self)

    priv.row_center_x = self:getWidth() - (priv.left_offset + priv.right_offset)
    local prev_row_end = priv.bottom_offset
    for i = 1, priv.rows do
        priv.row_center_y = prev_row_end + priv.row_height / 2
        prev_row_end = prev_row_end + priv.row_height
    end
end

---@param self FrameSpringColumn
---@return number
function private.updateResultSize(self)
    local priv = private[self]

    local height = self:getHeight() - (priv.border_top + priv.border_bottom)
    local free_cells = 0
    local free_size = height

    for i = 1, priv.cells_count do
        if priv.cells_type[i] == private.SIZE_TYPE.RATIO then
            local cur_size = priv.cells_size[private.SIZE_TYPE.RATIO] * height
            free_size = free_size - cur_size
            priv.cells_size.RESULT[i] = cur_size
        elseif priv.cells_type == private.SIZE_TYPE.ABS then
            free_size = free_size - priv.cells_size[private.SIZE_TYPE.ABS]
            priv.cells_size.RESULT[i] = priv.cells_size[private.SIZE_TYPE.ABS]
        else
            free_cells = free_cells + 1
        end
    end

    if free_size < 0 then
        free_size = 0
    end

    local free_cell_size = free_size / free_cells
    for i = 1, priv.cells_count do
        if priv.cells_type[i] == private.SIZE_TYPE.FREE then
            priv.cells_size.RESULT[i] = free_cell_size
        end
    end
end

function private.updateCenters(self)
    local priv = private[self]

    local cell_left = priv.border_left
    for i = 1, #priv.cells_count do
        priv.cells_center[i] = cell_left + cell_border_left
    end
end

return FrameSpringColumn