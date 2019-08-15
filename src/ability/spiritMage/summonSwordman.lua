---@type Unit
local Unit = require('unit.unit')
---@type UnitEvent
local UnitEvent = require('unit.unitEvent')
---@type Ability
local Ability = require('ability.ability')

local function generateAbility(name, tooltip, range, area, cast_time, cooldown)
    local id = WeObjEdit.Utils.nextAbilId()
    local order = WeObjEdit.Utils.nextOrderId()

    ---@type ChannelWeAbility
    local abil = WeObjEdit.Preset.Channel.new(id, order, 1, 'point',
                                              true, true, false, false, false)
    abil:setTooltipNormal(name, 1)
    abil:setTooltipNormalExtended(tooltip, 1)
    abil:setCastRange(range, 1)
    abil:setAreaofEffect(area, 1)

    abil:setCastingTime(0, 1)
    abil:setFollowThroughTime(cast_time, 1)
    abil:setArtDuration(cast_time, 1)

    abil:setCooldown(cooldown, 1)
    abil:setHotkeyNormal('X')
    
    return id
end

local function generateUnit(base_id, model, abilities)
    local id = WeObjEdit.Utils.nextUnitId()
    ---@type WeUnit
    local summon = WeObjEdit.Unit.Unit.new(id, base_id)
    summon:setModelFile(model)
    summon:setNormalAbilities(abilities)
    summon:setSpeedBase(1)
    return id
end


--
-- Ability data
--
local ability_name = 'Summon Swordman'
local ability_tooltip = 'Mage summons invulnerale spirit warrior.\n'
local range = 500
local area = 150
local cast_time = 0
local base_cooldown = 0
local abil_id = compiletime(generateAbility(ability_name, ability_tooltip, range, area, cast_time, base_cooldown))

local unit_model = 'war3mapImported\\units\\SwordNya.mdx'
local unit_abilities = 'Avul,Aloc'
local unit_id = compiletime( generateUnit('hfoo', unit_model, unit_abilities))
--
--
--

---@type Ability
local SummonCrystalSwordmanAbility = Ability.new(abil_id)
SummonCrystalSwordmanAbility:setName(ability_name)
SummonCrystalSwordmanAbility:setCastingTime(cast_time)

---@type table<Unit, Unit>
SummonCrystalSwordmanAbility.SlaveToMaster = {}
---@type table<Unit, Unit[]>
SummonCrystalSwordmanAbility.MasterToSlaves = {}

---@param master Unit
---@return Unit[]
function SummonCrystalSwordmanAbility.getSlaves(master)
    return SummonCrystalSwordmanAbility.MasterToSlaves[master]
end

---@param master Unit
---@param slaves Unit[]
function SummonCrystalSwordmanAbility.setSlaves(master, slaves)
    SummonCrystalSwordmanAbility.MasterToSlaves[master] = slaves
end

---@param slave Unit
---@return Unit
function SummonCrystalSwordmanAbility.getMaster(slave)
    return SummonCrystalSwordmanAbility.SlaveToMaster[slave]
end

---@param master Unit
---@param slave Unit
function SummonCrystalSwordmanAbility.setMaster(slave, master)
    SummonCrystalSwordmanAbility.SlaveToMaster[slave] = master
end

---@type AbilityFinishCallback
local finish = function(caster, target, x, y, full_time)
    Debug('finish')
    local owner = caster:getOwningPlayerIndex()
    local unit = Unit.new(owner, unit_id, x, y, caster:getFacing())
    unit:setVertexColor(1, 1, 1, 0.35)
    unit:applyTimedLife(10)

    SummonCrystalSwordmanAbility.setMaster(unit, caster)
    local slaves = SummonCrystalSwordmanAbility.getSlaves(caster)
    if slaves == nil then
        slaves = {}
    end
    table.insert(slaves, 1, unit)
    SummonCrystalSwordmanAbility.setSlaves(caster, slaves)

    unit.parameter:setAttacksPerSec(1)
end
SummonCrystalSwordmanAbility:setCallback(finish, "finish")

    
function SummonCrystalSwordmanAbility.init()
    
    UnitEvent.die:addAction(function()
            ---@type Unit
            local unit = GetDyingUnit()
            local dying_id = unit:getId()
            if dying_id == ID(unit_id) then
                local master = SummonCrystalSwordmanAbility.getMaster(unit)
                local slaves = SummonCrystalSwordmanAbility.getSlaves(master)

                
                SummonCrystalSwordmanAbility.setMaster(unit, nil)
                local changed_slaves = {}
                for i = 1, #slaves do
                    if slaves[i] ~= unit then
                        table.insert(changed_slaves, 1, slaves[i])
                    end
                end
                if #changed_slaves > 0 then
                    SummonCrystalSwordmanAbility.setSlaves(master, changed_slaves)
                else
                    SummonCrystalSwordmanAbility.setSlaves(master, nil)
                end
            end
        end)
end

--Debug(SummonCrystalSwordmanAbility)

return SummonCrystalSwordmanAbility