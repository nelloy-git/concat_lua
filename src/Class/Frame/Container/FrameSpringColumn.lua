--=========
-- Include
--=========

---@type FrameClass
local Frame = require('Class.Frame.Frame')
---@type FrameTypeClass
local FrameType = require('Class.Frame.FrameType')
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

--========
-- Static
--========

---@param frame_type FrameType | nil
---@param instance_data table | nil
---@return FrameSpringColumn
function override.new(frame_type, instance_data)
    local instance = instance_data or newInstanceData(FrameSpringColumn)

    if frame_type then
        instance = Frame.new(frame_type, instance)
    else
        instance = Frame.new(private.default_frame_type, instance)
    end
    private.new(instance)

    private.updateRowHeight(instance)

    return instance
end

--========
-- Public
--========

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

---@param row number
---@return boolean
function public:isRowHeightFree(row)
    local priv = private.get(self)
    local b = priv.is_row_abs[row] or priv.is_row_ratio[row]
    return not b
end

---@param row number
---@return boolean
function public:isRowHeightRatio(row)
    return private.get(self).is_row_ratio[row]
end

---@param row number
---@return boolean
function public:isRowHeightAbs(row)
    return private.get(self).is_row_abs[row]
end

---@param count number
---@return Frame[]
function public:setRows(count)
    local priv = private.get(self)

    if count < 1 or count % 1 ~= 0 then
        Log(Log.Err, getClassName(FrameSpringColumn),
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
    return private.get(self).rows
end

--- Set ratio < 0 for auto size.
---@param ratio number
---@param row number
function public:setRowRatioHeight(ratio, row)
    local priv = private.get(self)

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
    local priv = private.get(self)

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
    local priv = private.get(self)

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
    local priv = private.get(self)

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
    local priv = private.get(self)

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

    if frame then
        frame:setParent(self:getFramehandle())
    end

    return prev
end

---@param row number
---@return Frame | nil
function public:getCell(row)
    return private.get(self).elements[row]
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
---@param self FrameSpringColumn
function private.new(self)
    ---@class FrameSpringColumnPrivate
    local priv = {
        left_offset = 0,
        right_offset = 0,
        top_offset = 0,
        bottom_offset = 0,

        rows = 1,
        is_row_ratio = {},
        is_row_abs = {},
        row_ratio = {},
        row_height = {},
        row_center_x = 0,
        row_center_y = {},

        elements = {}
    }
    class_privates[self] = priv
end

---@param self FrameSpringColumn
---@return FrameSpringColumnPrivate
function private.get(self)
    return class_privates[self]
end

---@param self FrameSpringColumn
function private.free(self)
    class_privates[self] = nil
end

---@param self FrameSpringColumn
function private.applyAllElementsPos(self)
    private.updateRowHeight(self)

    for row, element in pairs(private.get(self).elements) do
        private.applyElementPos(self, element, row)
    end
end

---@param self FrameSpringColumn
---@param row number
function private.applyElementPos(self, element, row)
    local priv = private.get(self)

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
function private.updateRowHeight(self)
    local priv = private.get(self)

    local height = self:getHeight()
    local free_rows = priv.rows
    local free_height = height - (priv.top_offset + priv.bottom_offset)
    for i = 1, priv.rows do
        if priv.is_row_ratio[i] then
            free_rows = free_rows - 1
            priv.row_height[i] = priv.row_ratio[i] * height
            free_height = free_height - priv.row_height[i]
        elseif priv.is_row_abs[i] then
            free_rows = free_rows - 1
            free_height = free_height - priv.row_height[i]
        end
    end

    if free_rows == 0 then return nil end
    if free_height < 0 then free_height = 0 end

    local free_row_height = free_height / free_rows
    for i = 1, priv.rows do
        if not priv.is_row_abs[i] and not priv.is_row_ratio[i] then
            priv.row_height[i] = free_row_height
        end
    end

    priv.row_center_x = self:getWidth() - (priv.left_offset + priv.right_offset)
    local prev_row_end = priv.bottom_offset
    for i = 1, priv.rows do
        priv.row_center_y = prev_row_end + priv.row_height / 2
        prev_row_end = prev_row_end + priv.row_height
    end
end

return FrameSpringColumn