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

---@param background Frame
---@param instance_data table | nil
---@return FrameSpringRow
function override.new(background, instance_data)
    local instance = instance_data or newInstanceData(FrameSpringRow)
    

    local priv = {
        backgroud = background,

        left_offset = 0,
        right_offset = 0,
        top_offset = 0,
        bottom_offset = 0,

        columns = 1,
        is_column_ratio = {},
        is_column_abs = {},
        column_ratio = {},
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
end

function public:onCellChange()
end

function public:onOffsetsChange()
end

function public:onColumnRatioWidthChange()
end

function public:onColumnAbsWidthChange()
end

---@param column number
---@return boolean
function public:isColumnWidthRatio(column)
    return private[self].is_column_ratio[column]
end

---@param column number
---@return boolean
function public:isColumnWidthAbs(column)
    return private[self].is_column_abs[column]
end

---@param count number
---@return Frame[]
function public:setColumns(count)
    local priv = private[self]

    if count < 1 or count % 1 ~= 0 then
        Log(Log.Err, getClassName(FrameSpringRow),
            "columns count must be integer more or equal 1.")
        return nil
    end

    local free_frames = {}
    if count < priv.columns then
        for i = priv.columns, count + 1 do
            table.insert(free_frames, 1, priv.elements[i])
            priv.column_ratio[i] = nil
            priv.column_width[i] = nil
            priv.is_column_ratio[i] = nil
            priv.is_column_abs[i] = nil
            priv.elements[i] = nil
        end
    end
    priv.columns = count

    private.applyAllElementsPos(self)
    self:onColumnsChange()

    return free_frames
end

---@return number
function public:getColumns()
    return private[self].columns
end

--- Set part < 0 for auto size.
---@param ratio number
---@param column number
function public:setColumnRatioWidth(ratio, column)
    local priv = private[self]

    if ratio >= 0 then
        priv.is_column_ratio[column] = true
        priv.is_column_abs[column] = false
        priv.column_ratio[column] = ratio
    else
        priv.is_column_ratio[column] = false
        priv.is_column_abs[column] = false
        priv.column_ratio[column] = nil
    end
    private.applyAllElementsPos(self)
    self:onColumnRatioWidthChange()
end

---@param column number
---@return number
function public:getColumnRatioWidth(column)
    local priv = private[self]

    if priv.is_column_ratio[column] then
        return priv.column_ratio[column]
    end
    return -1
end

--- Set width < 0 for auto size.
---@param width number
---@param column number
function public:setColumnAbsWidth(width, column)
    local priv = private[self]

    if width >= 0 then
        priv.is_column_ratio[column] = false
        priv.is_column_abs[column] = true
        priv.column_width[column] = width
    else
        priv.is_column_ratio[column] = false
        priv.is_column_abs[column] = false
        priv.column_ratio[column] = nil
    end
    private.applyAllElementsPos(self)
    self:onColumnAbsWidthChange()
end

---@param column number
---@return number
function public:getColumnAbsWidth(column)
    local priv = private[self]

    if priv.is_column_abs[column] then
        return priv.column_width[column]
    end
    return -1
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

    private.applyElementPos(self, column)
    self:onOffsetsChange()
end

--- Returns left, right, top and bottom offsets
---@return number, number, number, number
function public:getOffsets()
    local priv = private[self]
    return priv.left_offset, priv.right_offset, priv.top_offset, priv.bottom_offset
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

    local width = self:getWidth()
    local free_columns = priv.columns
    local free_width = width
    for i = 1, priv.columns do
        if priv.is_column_ratio[i] then
            free_columns = free_columns - 1
            priv.column_width[i] = priv.column_ratio[i] * width
            free_width = free_width - priv.column_width[i]
        elseif priv.is_column_abs[i] then
            free_columns = free_columns - 1
            free_width = free_width - priv.column_width[i]
        end
    end

    if free_columns == 0 then return nil end
    if free_width < 0 then free_width = 0 end

    local free_column_width = free_width / free_columns
    for i = 1, priv.columns do
        if not priv.is_column_ratio[i] and not priv.is_column_abs[i] then
            priv.column_width[i] = free_column_width
        end
    end
end

return FrameSpringRow