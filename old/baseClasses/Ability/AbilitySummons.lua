local Ability = require('baseClasses.Ability.AbilityData')
local DataBase = require('utils.DataBase')
local Unit = require('baseClasses.Unit')

---@type DataBase
local __masters = DataBase.new('Unit', 'Unit')
---@type DataBase
local __slaves = DataBase.new('Unit', 'table')

AbilitySummons = {}

local initialized = false
function AbilitySummons.init()
    if initialized then return nil end

    local death_trigger = Unit.getTrigger(EVENT_PLAYER_UNIT_DECAY)
    death_trigger:addAction(function()
        local unit = Unit.GetDecayingUnit()
        if Ability.getMaster(unit) then
            Ability.freeSlave(unit)
        end
    end)

    initialized = true
end

---@param slave Unit
---@param master Unit
function Ability.registerSlave(slave, master)
    __masters:add(slave, master)
    local slaves = __slaves:get(master)
    if not slaves then
        slaves = {}
        __slaves:add(master, slaves)
    end
    table.insert(slaves, 1, slave)
end

---@param slave Unit
---@return boolean
function Ability.freeSlave(slave)
    local master = __masters:get(slave)
    if not master then
        Debug("Ability error: unit does not have master.")
        return false
    end
    __masters:remove(slave)

    ---@type Unit[]
    local slaves = __slaves:get(master)
    if not slaves then
        Debug("Ability error: master does not have any summons.")
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
        Debug("Ability error: found master does not have unit in summons list.")
    end
    return false
end

---@param slave Unit
---@return Unit
function Ability.getMaster(slave)
    return __masters:get(slave)
end

---@param master Unit
---@return Unit[]
function Ability.getSlaves(master)
    return __slaves:get(master)
end