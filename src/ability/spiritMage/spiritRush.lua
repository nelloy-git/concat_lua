---@type Ability
local Ability = require('ability.ability')
---@type Ability
local SummonSwordman = require('ability.spiritMage.summonSwordman')
---@type Unit
local Unit = require('unit.unit')
---@type Timer
local Timer = require('utils.timer')

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

    abil:setHotkeyNormal('Z')
    
    return id
end

--
-- Ability data
--
local ability_name = 'Spirit rush'
local ability_tooltip = 'Sends all summons to target.\n'
local range = 500
local area = 150
local cast_time = 0
local base_cooldown = 0
local abil_id = compiletime(generateAbility(ability_name, ability_tooltip, range, area, cast_time, base_cooldown))

local function finish(caster, target, x, y, full_time)
    ---@type Unit[]
    local summons = SummonSwordman.getSlaves(caster)
    print(#summons)
    for i = 1, #summons do
        ---@type Unit
        local u = summons[i]
        u:pause()
        u:playAnimation('Attack Spell Slam')
    end
end

local SpiritRush = Ability.new(abil_id)
SpiritRush:setCallback(finish, 'finish')
SpiritRush:setName(ability_name)
SpiritRush:setCastTime(cast_time)

return SpiritRush