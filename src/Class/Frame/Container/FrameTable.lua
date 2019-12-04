--=========
-- Include
--=========

---@type FrameClass
local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')

--=======
-- Class
--=======

---@type FrameTableClass
local FrameTable = newClass('FrameTable', FrameBackdrop)

---@class FrameTable
local public = FrameTable.public
---@class FrameTableClass
local static = FrameTable.static
---@type table
local override = FrameTable.override
---@type table(FrameTable, table)
local private = {}

private.index_offset = 100000

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameTable
function override.new(cols, rows, instance_data)
    local instance = instance_data or newInstanceData(FrameTable)
    instance = FrameBackdrop.new(instance)

    local priv = {
        left_offset = 0,
        right_offset = 0,
        top_offset = 0,
        bottom_offset = 0,

        cols = cols,
        rows = rows,

        elements = {}
    }
    private[instance] = priv

    return instance
end

function public:free()
    private[self] = nil
    FrameBackdrop.public.free(self)
end

function public:onSizeChange()
    local priv = private[self]

    -- Change background size
    FrameBackdrop.public.onSizeChange(self)

    -- Change all elements position and size
    local col_width = self:getWidth() / priv.cols
    local row_height = self:getHeight() / priv.rows
    for index, frame in pairs(priv.elements) do
        local col, row = private.getColAndRow(index)
        if col <= priv.cols or row <= priv.rows then
            frame:setX(private.getColumnX(self, col))
            frame:setY(private.getRowY(self, row))
            frame:setWidth(col_width)
            frame:setHeight(row_height)
        end
    end
end

--- Function returns previous element from table.
---@param frame Frame
---@param col number
---@param row number
---@return Frame | nil
function public:setCell(frame, col, row)
    local priv = private[self]

    private.updateElement(self, frame, col, row, true, true, true, true, true)
    return private.setElement(self, frame, col, row)
end

function public:setOffsets(left, right, top, bottom)
end

function private.setElement(self, frame, col, row)
    local priv = private[self]

    if col < 1 or row < 1 or col % 1 ~= 0 or row % 1 ~= 0 then
        Log(Log.Err, getClassName(FrameTable), "column and row numbers must be integers more or equal 1.")
        return nil
    end

    local index = private.getIndex(col, row)
    local prev = priv.elements[index]
    priv.elements[index] = frame
    return prev
end

---@param priv table
---@param col number
---@return number
function private.getColumnX(priv, col)
    return priv.left_offset + (col - 1) * priv.col_width
end

---@param priv table
---@param row number
---@return number
function private.getRowY(priv, row)
    return priv.botton_offset + (row - 1) * priv.row_height
end

function private.getColAndRow(index)
    local row = index % private.index_offset
    local col = (index - row) // private.index_offset
    return col, row
end

function private.getIndex(col, row)
    return col * private.index + row
end

return FrameTable