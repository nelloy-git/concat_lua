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

---@type FrameTooltipClass
local FrameTooltip = newClass('FrameTooltip', FrameSpringColumn)

---@class FrameTooltip : FrameSpringColumn
local public = FrameTooltip.public
---@class FrameTooltipClass : FrameSpringColumnClass
local static = FrameTooltip.static
---@type table
local override = FrameTooltip.override
---@type table(FrameTooltip, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameTooltip
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameTooltip)
    instance = FrameSpringColumn.new(instance)

    local priv = {
        first = 

    }
    private[instance] = priv

    FrameSpringColumn.public.setCell(instance, FrameSpringRow.new(), 1)
    FrameSpringColumn.public.setCell(instance, FrameSpringRow.new(), 1)
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
    for i = cur_rows + 1, rows  do
        local row_frame = FrameSpringRow.new()
        FrameSpringColumn.public.setCell(self, row_frame, i)
        row_frame:setColumns(main_row:getColumns())
        for j = 1, main_row:getColumns() do
            row_frame:setColumnWidthPart(main_row:getColumnWidthPart(j), j)
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

function public:setRowHeightPart(part, row)
    FrameSpringColumn.public.setRowHeightPart(self, part, row)
end

function public:setColumnWidthPart(part, column)
    for i = 1, self:getRows() do
        local row_frame = self:getCell(i)
        row_frame:setColumnWidthPart(part, column)
    end
end

function public:setCell(frame, column, row)
    local row_frame = self:getCell(row)
    row_frame:setCell(frame, column)
end

return FrameTooltip