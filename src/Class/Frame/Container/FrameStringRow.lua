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

---@class FrameSpringRow
local public = FrameSpringRow.public
---@class FrameSpringRowClass
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

        cols = 1,
        col_width = {},
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
---@return Frame | nil
function public:setCell(frame, col)
    local priv = private[self]

    local col_width = self:getWidth() / priv.cols
    local row_height = self:getHeight() / priv.rows
    local elem_width = col_width - (priv.left_offset + priv.right_offset)
    local elem_height = row_height - (priv.top_offset + priv.bottom_offset)
    frame:setParent(self:getWc3Frame())
    frame:setX(private.getColumnX(priv, col, col_width))
    frame:setY(private.getRowY(priv, row, row_height))
    frame:setWidth(elem_width)
    frame:setHeight(elem_height)

    return private.setElement(self, frame, col)
end

function public:getCell(col)
    return private[self].elements[col]
end

function public:setColumns(cols)
    private[self].cols = cols
    self:onColumnsChange()
end

function public:setOffsets(left, right, top, bottom)
    local priv = private[self]

    priv.left_offset = left
    priv.right_offset = right
    priv.top_offset = top
    priv.bottom_offset = bottom

    self:onOffsetsChange()
end

function private.setElement(self, frame, col)
    local priv = private[self]

    if col < 1 or col % 1 ~= 0 then
        Log(Log.Err, getClassName(FrameSpringRow), "column and row numbers must be integers more or equal 1.")
        return nil
    end

    local prev = priv.elements[col]
    priv.elements[col] = frame
    return prev
end

---@param priv table
---@param col number
---@return number
function private.getColumnX(priv, col)
    local x = priv.left_offset
    for i = 1, col - 1 do
        
    end

    return priv.left_offset + (col - 1) * col_width
end

---@param priv table
---@param row number
---@return number
function private.getRowY(priv, row, row_height)
    return priv.bottom_offset
end

return FrameSpringRow