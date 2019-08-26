---@class SummonDB
local SummonDB = {}

local MastersDB = {}
local SlavesDB = {}

---@param slave wc3_Unit
---@param master wc3_Unit
function SummonDB.addSlave(slave, master)
    SlavesDB[slave] = master
    if not MastersDB[master] then
        MastersDB[master] = {}
    end
    table.insert(MastersDB[master], 1, slave)
end

---@param slave wc3_Unit
---@return boolean
function SummonDB.rmSlave(slave)
    local master = SlavesDB[slave]
    if not master then
        Debug("SummonDB: error trying to remove non summon unit.")
        return false
    end
    SlavesDB[slave] = nil
    local slaves = MastersDB[master]

    if #slaves == 1 then
        MastersDB[master] = nil
        return true
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
    end
    return false
end

---@param slave wc3_Unit
---@return wc3_Unit
function SummonDB.getMaster(slave)
    return SlavesDB[slave]
end

---@param master wc3_Unit
---@return wc3_Unit
function SummonDB.getSlaves(master)
    return MastersDB[master]
end

return SummonDB