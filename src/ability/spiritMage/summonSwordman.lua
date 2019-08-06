---@type Unit
local Unit = require('unit.unit')
---@type UnitEvent
local UnitEvent = require('unit.unitEvent')
---@type Ability
local Ability = require('ability.ability')

--
-- Ability data
--
local Name = 'Summon Crystal Swordman'
local Cooldown = 10

--
--
--

local id = compiletime(
    function()
        local id = {
            abil = WeObjEdit.Utils.nextAbilId(),
            order = WeObjEdit.Utils.nextOrderId(),
            unit = WeObjEdit.Utils.nextUnitId()
        }

        ---@type WeUnit
        local summon = WeObjEdit.Unit.Unit.new(id.unit, 'hfoo')
        summon:setModelFile('war3mapImported\\units\\SwordNya.mdx')
        summon:setNormalAbilities('Avul,Aloc')

        ---@type ChannelWePreset
        local abil = WeObjEdit.Preset.Channel.new(id.abil, id.order,
                                                  1, 'point', true, false, false, false, false)
        abil:setAreaofEffect(200, 1)
        abil:setTooltipNormal('Summon crystal warrior.', 1)
        abil:setCastingTime(0, 1)
        abil:setFollowThroughTime(3, 1)
        abil:setArtDuration(3, 1)
        abil:setCastRange(200, 1)
        abil:setCooldown(5, 1)
        return id
    end)

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

---@type Ability
local SummonCrystalSwordmanAbility = Ability.new(id.abil)
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