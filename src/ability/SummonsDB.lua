---@type DataBase
local DataBase = require('utils.DataBase')

---@class SummonsDB
local SummonsDB = {
    __masters = DataBase.new('userdata', 'userdata'),
    __slaves = DataBase.new('userdata', 'table')
}

local MastersDB = {}
local SlavesDB = {}

---@param slave unit
---@param master unit
function SummonsDB.addSlave(slave, master)
    SummonsDB.__masters:add(slave, master)
    local slaves = SummonsDB.__slaves:get(master)
    if not slaves then
        slaves = {}
        SummonsDB.__slaves:add(master, slaves)
    end
    table.insert(slaves, 1, slave)
end

---@param slave unit
---@return boolean
function SummonsDB.rmSlave(slave)
    local master = SummonsDB.__masters:get(slave)
    if not master then
        Debug("SummonDB error: summoned unit does not have master.")
        return false
    end
    SummonsDB.__masters:remove(slave)

    local slaves = SummonsDB.__slaves:get(master)
    if not slaves then
        Debug("SummonDB error: found master does not have any summons.")
        return false
    end
    local pos = -1
    for i = 0, #slaves do
        if slaves[i] == slave then
            pos = i
            break
        end
    end

    if pos > 0 then
        table.remove(slaves, pos)
        return true
    else
        Debug("SummonsDB error: found master does not have unit in summons list.")
    end
    return false
end

---@param slave unit
---@return unit
function SummonsDB.getMaster(slave)
    return SummonsDB.__masters:get(slave)
end

---@param master unit
---@return unit[]
function SummonsDB.getSlaves(master)
    return SummonsDB.__slaves:get(master)
end

return SummonsDB