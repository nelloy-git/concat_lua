--=========
-- Include
--=========

---@type FrameSpringTableClass
local FrameSpringTable = require('Class.Frame.Container.FrameSpringTable')

--=======
-- Class
--=======

---@type FrameStatsTableClass
local FrameStatsTable = newClass('FrameStatsTable', FrameSpringTable)

---@class FrameStatsTable : FrameSpringTable
local public = FrameStatsTable.public
---@class FrameStatsTableClass : FrameSpringTableClass
local static = FrameStatsTable.static
---@type table
local override = FrameStatsTable.override
---@type table(FrameStatsTable, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FrameStatsTable
function static.new(instance_data)
    local instance = instance_data or newInstanceData(FrameStatsTable)
    instance = FrameSpringTable(nil, instance)
    local priv = private.new(instance)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

--=========
-- Private
--=========

local private_data = {}
---@param self FrameStatsTable
---@return FrameStatsTablePrivate
function private.new(self)
    ---@class FrameStatsTablePrivate
    local priv = {
    }
    private_data[self] = priv

    self:setRows(10)
    self:setColumns(4)

    return priv
end

---@param self FrameStatsTable
---@return FrameStatsTablePrivate
function private.get(self)
    return private_data[self]
end

---@param self FrameStatsTable
function private.free(self)
    private_data[self] = nil
end

return FrameStatsTable