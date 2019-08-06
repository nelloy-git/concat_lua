---@type Unit
local Unit = require('unit.unit')
---@type Ability
local Ability = require('ability.ability')

--
-- Ability data
--
local Name = 'Summon Crystal Swordman'

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


---@type AbilityFinishCallback
local finish = function(caster, target, x, y, full_time)
    local owner = caster:getOwningPlayerIndex()
    local unit = Unit.new(owner, id.unit, x, y, caster:getFacing())
    unit:setVertexColor(1, 1, 1, 0.35)
    unit.parameter:setAttacksPerSec(1)
end

---@type Ability
local SummonCrystalSwordmanAbility = Ability.new(id.abil)
SummonCrystalSwordmanAbility:setCallback(finish, "finish")
SummonCrystalSwordmanAbility:setName('Summon Crystal Swordman')
SummonCrystalSwordmanAbility:s


return SummonCrystalSwordmanAbility