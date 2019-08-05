---@type Unit
local Unit = require('unit.unit')
---@type Ability
local Ability = require('ability.ability')

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

---@class SummonCrystalSwordmanAbility : Ability
local SummonCrystalSwordmanAbility = Ability.new(id.abil)

--- Do nothing.
---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
---@return boolean
function SummonCrystalSwordmanAbility.start(caster, target, x, y)
    return true
end

--- Do nothing.
---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
---@param cur_time number
---@param full_time number
---@return boolean
function SummonCrystalSwordmanAbility.casting(caster, target, x, y, cur_time, full_time)
    return true
end

--- Print 'Interrupt'
---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
---@param cur_time number
---@param full_time number
function SummonCrystalSwordmanAbility.interrupt(caster, target, x, y, cur_time, full_time)
    print('Interrupt')
end

--- Summon crystall swordman.
---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
---@param full_time number
function SummonCrystalSwordmanAbility.finish(caster, target, x, y, full_time)
    local owner = caster:getOwningPlayerIndex()
    local unit = Unit.new(owner, id.unit, x, y, caster:getFacing())
    unit:setVertexColor(1, 1, 1, 0.35)
    unit.parameter:setAttacksPerSec(1)
end

function SummonCrystalSwordmanAbility.getName()
    return 'Summon crystal swordman'
end

function SummonCrystalSwordmanAbility.getCastTime()
    return 3
end

return SummonCrystalSwordmanAbility