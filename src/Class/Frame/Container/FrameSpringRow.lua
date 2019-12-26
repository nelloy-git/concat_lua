--=========
-- Include
--=========

local Class = require('Utils.Class')

local Frame = require('Class.Frame.Frame')
local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')

--=======
-- Class
--=======

---@class FrameSpringRowClass : FrameBackdropClass
local FrameSpringRow = Class.newClass('FrameSpringRow', FrameBackdrop)

---@class FrameSpringRow : FrameBackdrop
local public = FrameSpringRow.public
---@type FrameSpringRowClass
local static = FrameSpringRow.static
---@type table
local override = FrameSpringRow.override
---@type table(FrameSpringRow, table)
local private = {}

--===========
-- Callbacks
--===========

--- Overrides Frame.public.onSizeChange
function public:onSizeChange()
    Frame.public.onSizeChange(self)
    private.applyAllElementsPos(self)
end

function public:onColumnsChange()
    private.applyAllElementsPos(self)
end

---@param column number
function public:onCellChange(element, column)
    private.applyElementPos(self, element, column)
end

function public:onOffsetsChange()
    private.applyAllElementsPos(self)
end

function public:onColumnRatioWidthChange()
    private.applyAllElementsPos(self)
end

function public:onColumnAbsWidthChange()
    private.applyAllElementsPos(self)
end

--=========
-- Methods
--=========

---@overload fun(background_framehandle:framehandle | nil)
---@param background_framehandle framehandle | nil
---@param instance_data table | nil
---@return FrameSpringRow
function override.new(background_framehandle, is_simpleframe, instance_data)
    local instance = instance_data or Class.newInstanceData(FrameSpringRow)
    if is_simpleframe then
    else
    end
    instance = FrameBackdrop.new(background_framehandle, instance)
    private.new(instance)

    private.updateColumnsWidth(instance)

    return instance
end

--- Function returns removed frames.
---@return Frame[]
function public:free()
    local priv = private.get(self)

    local free_frames = {}
    for i = 1, #priv.elements do
        free_frames[i]:setParent(nil)
        table.insert(free_frames, #free_frames + 1, free_frames[i])
    end

    private.free(self)
    FrameBackdrop.public.free(self)

    return free_frames
end

---@param column number
---@return boolean
function public:isColumnWidthFree(column)
    local priv = private.get(self)
    local b = priv.is_column_ratio[column] or priv.is_column_abs[column]
    return not b
end

---@param column number
---@return boolean
function public:isColumnWidthRatio(column)
    return private.get(self).is_column_ratio[column]
end

---@param column number
---@return boolean
function public:isColumnWidthAbs(column)
    return private.get(self).is_column_abs[column]
end

---@param count number
---@return Frame[]
function public:setColumns(count)
    local priv = private.get(self)

    if count < 1 or count % 1 ~= 0 then
        Log(Log.Err, FrameSpringRow,
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

    self:onColumnsChange()

    return free_frames
end

---@return number
function public:getColumns()
    return private.get(self).columns
end

--- Set part < 0 for auto size.
---@param ratio number
---@param column number
function public:setColumnRatioWidth(ratio, column)
    local priv = private.get(self)

    if ratio >= 0 then
        priv.is_column_ratio[column] = true
        priv.is_column_abs[column] = false
        priv.column_ratio[column] = ratio
    else
        priv.is_column_ratio[column] = false
        priv.is_column_abs[column] = false
        priv.column_ratio[column] = nil
    end

    self:onColumnRatioWidthChange()
end

---@param column number
---@return number
function public:getColumnRatioWidth(column)
    local priv = private.get(self)

    if priv.is_column_ratio[column] then
        return priv.column_ratio[column]
    end
    return -1
end

--- Set width < 0 for auto size.
---@param width number
---@param column number
function public:setColumnAbsWidth(width, column)
    local priv = private.get(self)

    if width >= 0 then
        priv.is_column_ratio[column] = false
        priv.is_column_abs[column] = true
        priv.column_width[column] = width
    else
        priv.is_column_ratio[column] = false
        priv.is_column_abs[column] = false
        priv.column_ratio[column] = nil
    end
    
    self:onColumnAbsWidthChange()
end

---@param column number
---@return number
function public:getColumnAbsWidth(column)
    local priv = private.get(self)

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
    local priv = private.get(self)

    if column < 1 or column % 1 ~= 0 then
        Log(Log.Err, FrameSpringRow,
            "column must be integer more or equal 1.")
        return nil
    end

    if column > priv.columns then
        Log(Log.Err, FrameSpringRow,
            "column for element adding can not be greater than size.")
        return nil
    end

    local prev = priv.elements[column]
    priv.elements[column] = frame

    frame:setParent(self:getFramehandle())
    self:onCellChange(frame, column)

    return prev
end

---@param column number
---@return Frame | nil
function public:getCell(column)
    return private.get(self).elements[column]
end

---@param left number
---@param right number
---@param top number
---@param bottom number
function public:setOffsets(left, right, top, bottom)
    local priv = private.get(self)

    priv.left_offset = left
    priv.right_offset = right
    priv.top_offset = top
    priv.bottom_offset = bottom

    self:onOffsetsChange()
end

--- Returns left, right, top and bottom offsets
---@return number, number, number, number
function public:getOffsets()
    local priv = private.get(self)
    return priv.left_offset, priv.right_offset, priv.top_offset, priv.bottom_offset
end

--=========
-- Private
--=========

local class_privates = {}
---@param self FrameSpringRow
function private.new(self)
    ---@class FrameSpringRowPrivate
    local priv = {
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
    class_privates[self] = priv
end

---@param self FrameSpringRow
---@return FrameSpringRowPrivate
function private.get(self)
    return class_privates[self]
end

---@param self FrameSpringRow
function private.free(self)
    class_privates[self] = nil
end

---@param self FrameSpringRow
function private.applyAllElementsPos(self)
    private.updateColumnsWidth(self)

    for column, element in pairs(private.get(self).elements) do
        private.applyElementPos(self, element, column)
    end
end

---@param self FrameSpringRow
---@param column number
function private.applyElementPos(self, element, column)
    local priv = private.get(self)

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
    local priv = private.get(self)

    local width = self:getWidth()
    local free_columns = priv.columns
    local free_width = width - (priv.left_offset + priv.right_offset)
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