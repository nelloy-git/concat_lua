---@type Unit
local Unit = require('unit.unit')
---@type Ability
local Ability = require('unit.abilities.ability')

local id =
    compiletime(
        function()
            local id = {
                abil = WeObjEdit.Utils.nextAbilId(),
                order = WeObjEdit.Utils.nextOrderId(),
                unit = WeObjEdit.Utils.nextUnitId()
            }
            ---@type WeUnit
            local elemental = WeObjEdit.Unit.Unit.new(id.unit, 'hfoo')
            elemental:setModelFile('war3mapImported\\units\\SwordNya.mdx')
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

local function finish(caster, full_casting_time, target_x, target_y, target)
    local owner = caster:getOwningPlayerIndex()
    local unit = Unit.new(owner, id.unit, target_x, target_y, caster:getFacing())
    print('Finish')
    unit:setVertexColor(1, 1, 1, 0.35)
    print('Finish')
    unit.parameter:setAttacksPerSec(1)
    print('Finish')
end

local function interrupt()
    print('Interrupted.')
end

---@class SummonCrystalSwordmanAbility : Ability
local SummonCrystalSwordmanAbility = Ability.new(id.abil, nil, nil, interrupt, finish)

function SummonCrystalSwordmanAbility.getName()
    return 'Summon crystal swordman'
end

function SummonCrystalSwordmanAbility.getCastTime()
    return 3
end

return SummonCrystalSwordmanAbility