--=========
-- Include
--=========

local Class = require('Utils.Class')

local Frame = require('Class.Frame.Frame')
local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')

--=======
-- Class
--=======

---@class FrameTableClass : FrameBackdropClass
local FrameTable = Class.newClass('FrameTable', FrameBackdrop)

---@class FrameTable : FrameBackdrop
local public = FrameTable.public
---@type FrameTableClass
local static = FrameTable.static
---@type FrameTableClass
local override = FrameTable.override

local private = {}

private.index_offset = 100000

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameTable
function override.new(instance_data)
    local instance = instance_data or Class.newInstanceData(FrameTable)
    instance = FrameBackdrop.new(instance)

    local priv = {
        left_offset = 0,
        right_offset = 0,
        top_offset = 0,
        bottom_offset = 0,

        cols = 1,
        rows = 1,

        elements = {}
    }
    private[instance] = priv

    return instance
end

---@return Frame[]
function public:free()
    local priv = private[self]

    local elems = {}
    for _,frame in pairs(priv.elements) do
        frame:setParent(nil)
        table.insert(elems, 1, frame)
    end

    private[self] = nil
    FrameBackdrop.public.free(self)

    return elems
end

function public:onColumnsChange()
    self:onSizeChange()
end

function public:onRowsChange()
    self:onSizeChange()
end

function public:onOffsetsChange()
    self:onSizeChange()
end

function public:onSizeChange()
    local priv = private[self]

    -- Change background size
    Frame.public.onSizeChange(self)

    -- Change all elements position and size
    local col_width = self:getWidth() / priv.cols
    local row_height = self:getHeight() / priv.rows
    local elem_width = col_width - (priv.left_offset + priv.right_offset)
    local elem_height = row_height - (priv.top_offset + priv.bottom_offset)
    for index, frame in pairs(priv.elements) do
        local col, row = private.getColAndRow(index)
        if col <= priv.cols or row <= priv.rows then
            frame:setX(private.getColumnX(priv, col, col_width))
            frame:setY(private.getRowY(priv, row, row_height))
            frame:setWidth(elem_width)
            frame:setHeight(elem_height)
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

    local col_width = self:getWidth() / priv.cols
    local row_height = self:getHeight() / priv.rows
    local elem_width = col_width - (priv.left_offset + priv.right_offset)
    local elem_height = row_height - (priv.top_offset + priv.bottom_offset)
    frame:setParent(self:getFramehandle())
    frame:setX(private.getColumnX(priv, col, col_width))
    frame:setY(private.getRowY(priv, row, row_height))
    frame:setWidth(elem_width)
    frame:setHeight(elem_height)

    return private.setElement(self, frame, col, row)
end

function public:getCell(col, row)
    local index = private.getIndex(col, row)
    return private[self].elements[index]
end

function public:setColumns(cols)
    private[self].cols = cols
    self:onColumnsChange()
end

function public:setRows(rows)
    private[self].rows = rows
    self:onRowsChange()
end

function public:setOffsets(left, right, top, bottom)
    local priv = private[self]

    priv.left_offset = left
    priv.right_offset = right
    priv.top_offset = top
    priv.bottom_offset = bottom

    self:onOffsetsChange()
end

function private.setElement(self, frame, col, row)
    local priv = private[self]

    if col < 1 or row < 1 or col % 1 ~= 0 or row % 1 ~= 0 then
        Log(Log.Err, FrameTable, "column and row numbers must be integers more or equal 1.")
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
function private.getColumnX(priv, col, col_width)
    return priv.left_offset + (col - 1) * col_width
end

---@param priv table
---@param row number
---@return number
function private.getRowY(priv, row, row_height)
    return priv.bottom_offset + (row - 1) * row_height
end

function private.getColAndRow(index)
    local row = index % private.index_offset
    local col = (index - row) // private.index_offset
    return col, row
end

function private.getIndex(col, row)
    return col * private.index_offset + row
end

return FrameTable