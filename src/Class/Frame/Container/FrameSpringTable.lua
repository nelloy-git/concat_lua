--=========
-- Include
--=========

---@type FrameSpringColumnClass
local FrameSpringColumn = require('Class.Frame.Container.FrameSpringColumn')
---@type FrameSpringRowClass
local FrameSpringRow = require('Class.Frame.Container.FrameSpringRow')

--=======
-- Class
--=======

---@type FrameSpringTableClass
local FrameSpringTable = newClass('FrameSpringTable', FrameSpringColumn)

---@class FrameSpringTable : FrameSpringColumn
local public = FrameSpringTable.public
---@class FrameSpringTableClass : FrameSpringColumnClass
local static = FrameSpringTable.static
---@type table
local override = FrameSpringTable.override
---@type table(FrameSpringTable, table)
local private = {}

--=========
-- Methods
--=========

---@param custom_backdrop_frame framehandle | nil
---@param instance_data table | nil
---@return FrameSpringTable
function override.new(custom_backdrop_frame, instance_data)
    local instance = instance_data or newInstanceData(FrameSpringTable)
    instance = FrameSpringColumn.new(custom_backdrop_frame, instance)
    FrameSpringColumn.public.setCell(instance, FrameSpringRow.new(), 1)

    return instance
end

function public:free()
    local free_frames = {}
    local free_rows = FrameSpringColumn.public.free(self)
    for i = 1, #free_rows do
        local row_free_frames = free_rows:free()
        for j = 1, #row_free_frames do
            table.insert(free_frames, #free_frames + 1, row_free_frames[j])
        end
    end

    return free_frames
end

function public:setRows(rows)
    local free_frames = {}
    local cur_rows = self:getRows()
    local free_rows = FrameSpringColumn.public.setRows(self, rows)

    for i = 1, #free_rows do
        local row_free_frames = free_rows:free()
        for j = 1, #row_free_frames do
            table.insert(free_frames, #free_frames + 1, row_free_frames[j])
        end
    end

    local main_row = self:getCell(1)
    local columns = main_row:getColumns()
    for i = cur_rows + 1, rows  do
        local row_frame = FrameSpringRow.new()
        FrameSpringColumn.public.setCell(self, row_frame, i)
        row_frame:setColumns(columns)
        for j = 1, main_row:getColumns() do
            if main_row:isColumnWidthAbs(j) then
                local w = main_row:getColumnAbsWidth(j)
                row_frame:setColumnAbsWidth(w, j)
            elseif main_row:isColumnWidthRatio(j) then
                local r = main_row:getColumnRatioWidth(j)
                row_frame:setColumnRatioWidth(r, j)
            end
        end
    end

    return free_frames
end

function public:setColumns(columns)
    local free_frames = {}
    for i = 1, self:getRows() do
        local row_frame = self:getCell(i)
        local free_row_frames = row_frame:setColumns(columns)
        for j = 1, #free_row_frames do
            table.insert(free_frames, #free_frames + 1, free_row_frames[j])
        end
    end

    return free_frames
end

function public:setColumnRatioWidth(ratio, column)
    for i = 1, self:getRows() do
        local row_frame = self:getCell(i)
        row_frame:setColumnRatioWidth(ratio, column)
    end
end

function public:setColumnAbsWidth(width, column)
    for i = 1, self:getRows() do
        local row_frame = self:getCell(i)
        row_frame:setColumnAbsWidth(width, column)
    end
end

function public:setCell(frame, column, row)
    local row_frame = self:getCell(row)
    row_frame:setCell(frame, column)
end

return FrameSpringTable