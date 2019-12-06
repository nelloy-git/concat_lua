--=========
-- Include
--=========

---@type FrameBackdropClass
local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')
---@type FrameSpringColumnClass
local FrameSpringColumn = require('Class.Frame.Container.FrameStringColumn')
---@type FrameSpringRowClass
local FrameSpringRow = require('Class.Frame.Container.FrameStringRow')

--=======
-- Class
--=======

---@type FrameSpringTableClass
local FrameSpringTable = newClass('FrameSpringTable', FrameBackdrop)

---@class FrameSpringTable : FrameBackdrop
local public = FrameSpringTable.public
---@class FrameSpringTableClass : FrameBackdropClass
local static = FrameSpringTable.static
---@type table
local override = FrameSpringTable.override
---@type table(FrameSpringTable, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return FrameSpringTable
function static.new(instance_data)
    local instance = instance_data or newInstanceData(FrameSpringColumn)
    instance = FrameBackdrop.new(instance)

    local priv = {
        spring_column = FrameSpringColumn.new(),

        columns = 1,
        rows = 1
    }
    private[instance] = priv

    local spring_row = FrameSpringRow.new()
    priv.spring_column:setCell(spring_row, 1)

    return instance
end

function public:free()
    local priv = private[self]

    local free_frames = {}
    for i = 1, #priv.rows do
        local row_free_frames = priv.spring_column:free()
        for j = 1, #row_free_frames do
            table.insert(free_frames, #free_frames + 1, row_free_frames[j])
        end
    end

    private[self] = nil
    FrameBackdrop.public.free(self)

    return free_frames
end

function public:onColumnsChange()
    
end

---@param columns number
function public:setColumns(columns)
    private[self].columns = columns
    
end

return FrameSpringTable