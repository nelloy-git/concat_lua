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
                                              true, false, false, false, false)
    abil:setTooltipNormal(name, 1)
    abil:setTooltipNormalExtended(tooltip, 1)
    abil:setCastRange(range, 1)
    abil:setAreaofEffect(area, 1)

    abil:setCastingTime(0, 1)
    abil:setFollowThroughTime(cast_time, 1)
    abil:setArtDuration(cast_time, 1)

    abil:setCooldown(cooldown, 1)
    
    return id
end

local function generateUnit(base_id, model, abilities)
    local id = WeObjEdit.Utils.nextUnitId()
    ---@type WeUnit
    local summon = WeObjEdit.Unit.Unit.new(id.unit, base_id)
    summon:setModelFile('war3mapImported\\units\\SwordNya.mdx')
    summon:setNormalAbilities('Avul,Aloc')
    summon:setSpeedBase(0)
    return id
end


--
-- Ability data
--
local ability_name = 'Summon Crystal Swordman'
local ability_tooltip = ''
local range = 500
local area = 150
local base_cooldown = 10

local abil_id = generateAbility(ability_name, ability_tooltip, range, area)
--
--
--
---@type Ability
local SummonCrystalSwordmanAbility = Ability.new(abil_id)

---@type table<Unit, Unit>
local SlaveToMaster = {}
---@type table<Unit, Unit[]>
local MasterToSlaves = {}

---@type AbilityFinishCallback
local finish = function(caster, target, x, y, full_time)
    local owner = caster:getOwningPlayerIndex()
    local unit = Unit.new(owner, id.unit, x, y, caster:getFacing())
    unit:setVertexColor(1, 1, 1, 0.35)
    unit:applyTimedLife(10)

    SlaveToMaster[unit] = owner
    if MasterToSlaves[owner] == nil then MasterToSlaves[owner] = {} end
    table.insert(MasterToSlaves[owner], 1, unit)

    print(#MasterToSlaves[owner])

    unit.parameter:setAttacksPerSec(1)
end
SummonCrystalSwordmanAbility:setCallback(finish, "finish")
SummonCrystalSwordmanAbility:setName('Summon Crystal Swordman')
SummonCrystalSwordmanAbility:setCastTime(2)

function SummonCrystalSwordmanAbility.init()
    UnitEvent.death_trigger:addAction(function()
            ---@type Unit
            local unit = GetDyingUnit()
            local dying_id = unit:getId()
            if dying_id == ID(id.unit) then
                local master = SlaveToMaster[unit]
                local slaves = MasterToSlaves[master]
                local changed_slaves = {}
                for i = 1, #slaves do
                    if slaves[i] ~= unit then
                        table.insert(changed_slaves, 1, slaves[i])
                    end
                end
                SlaveToMaster[unit] = nil
                if #changed_slaves > 0 then
                    MasterToSlaves[master] = changed_slaves
                else
                    MasterToSlaves[master] = nil
                end
            end
        end)
end


return SummonCrystalSwordmanAbility