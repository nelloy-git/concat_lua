---@type Ability
local Ability = require('ability.ability')
---@type Ability
local SummonSwordman = require('ability.spiritMage.summonSwordman')
---@type Unit
local Unit = require('unit.unit')
---@type AbilityEvent
local AbilityEvent = require('ability.abilityEvent')
---@type Timer
local timer = AbilityEvent.CastingTimer

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
local moveSpeed = 30
local movePeriod = 0.03125
local skillAnimationBaseTime = 1

local function moveUnit(data)
    local speed = moveSpeed
    local x, y = data.unit:getPos()
    if speed >= data.r then
        speed = data.r
        local u = data.unit
        u:setPos(x - data.cos * speed, y - data.sin * speed)
        u:unpause()
        u:playAnimation('stand')
        u:setAnimationSpeed(1)
    else
        data.unit:setPos(x - data.cos * speed, y - data.sin * speed)
        data.r = data.r - speed
        timer:addAction(movePeriod, moveUnit, data)
    end
end

local function finish(caster, target, x, y, full_time)
    ---@type Unit[]
    local summons = SummonSwordman.getSlaves(caster)
    for i = 1, #summons do
        ---@type Unit
        local u = summons[i]
        u:pause()
        u:setFacingTo(x, y)
        u:playAnimation('Attack Spell Slam')
        local u_x, u_y = u:getPos()
        local dx = u_x - x
        local dy = u_y - y
        local r = (dx*dx + dy*dy)^0.5
        local anim_time = r/moveSpeed * movePeriod
        u:setAnimationSpeed(skillAnimationBaseTime / anim_time)
        local data = {
            unit = u,
            sin = dy/r,
            cos = dx/r,
            r = r
        }
        timer:addAction(movePeriod, moveUnit, data)
    end
end

local SpiritRush = Ability.new(abil_id)
SpiritRush:setCallback(finish, 'finish')
SpiritRush:setName(ability_name)
SpiritRush:setCastTime(cast_time)

return SpiritRush