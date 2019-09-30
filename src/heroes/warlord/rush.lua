---@type Ability
local Ability = require('ability.ability')
---@type Ability
local SummonSwordman = require('ability.warlord.summon')
---@type Unit
local Unit = require('unit.Unit')
----@type PlayerEvent
local PlayerEvent = require('player.playerEvent')

---This function initialize targeting for real ability. It is needed to get ability targeting event.
---@param name string
---@param tooltip string
---@param hot_key string
local function generateDummyAbility(name, tooltip, hot_key)
    local id = WeObjEdit.Utils.nextAbilityId()
    local order = WeObjEdit.Utils.nextOrderId()

    ---@type ChannelWeAbility
    local abil = WeObjEdit.Preset.Channel.new(id, order, 1, 'none',
                                              true, false, false, false, false)

    abil:setTooltipNormal(name, 1)
    abil:setTooltipNormalExtended(tooltip, 1)
    --abil:setIconNormal(icon)
    abil:setHotkeyNormal(hot_key)

    abil:setCastingTime(0, 1)
    abil:setFollowThroughTime(0, 1)
    abil:setArtDuration(0, 1)
    return id
end

---Function creates main ability.
---@param range number
---@param cast_time number
---@param hot_key string
local function generateAbility(range, cast_time, hot_key)
    local id = WeObjEdit.Utils.nextAbilityId()
    local order = WeObjEdit.Utils.nextOrderId()

    ---@type ChannelWeAbility
    local abil = WeObjEdit.Preset.Channel.new(id, order, 1, 'point',
                                              true, false, false, false, false)
    abil:setCastRange(range, 1)
    abil:setHotkeyNormal(hot_key)

    abil:setCastingTime(0, 1)
    abil:setFollowThroughTime(cast_time, 1)
    abil:setArtDuration(cast_time, 1)

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
local hot_key = 'Z'
local dummy_id = compiletime(generateDummyAbility(ability_name, ability_tooltip, hot_key))
local abil_id = compiletime(generateAbility(range, cast_time, hot_key))
local moveSpeed = 3
local movePeriod = 0.03125
local skillAnimationBaseTime = 1
local positios_range = 100

---Contains raletive positions of units after command.
local pos_offsets = {
    [1] = {x = 0, y = 0},
    [2] = {x = 0, y = positios_range},
    [3] = {x = 0, y = -positios_range},
    [4] = {x = positios_range, y = 0},
    [5] = {x = positios_range, y = positios_range},
    [6] = {x = positios_range, y = -positios_range},
    [7] = {x = 2 * positios_range, y = 0},
    [8] = {x = 2 * positios_range, y = positios_range},
    [9] = {x = 2 * positios_range, y = -positios_range},
}

local dummySpiritRush = Ability.new(dummy_id)
local SpiritRush = Ability.new(abil_id)

local circle_model = 'Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl'
local function createCircles(count, x, y, caster_x, caster_y)
    local dx = x - caster_x
    local dy = y - caster_y
    local r = (dx*dx + dy*dy)^0.5
    local cos = dx / r
    local sin = -dy / r
    local effects = {}
    for i = 1, count do
        local pos_x = x + pos_offsets[i].x * cos + pos_offsets[i].y * sin
        local pos_y = y + pos_offsets[i].x * sin + pos_offsets[i].y * cos
        effects[i] = AddSpecialEffect(circle_model, pos_x, pos_y)
    end
    return effects
end

---@param caster Unit
local function trackingTarget(caster, effects)
    local mouse_x = BlzGetTriggerPlayerMouseX()
    local mouse_y = BlzGetTriggerPlayerMouseY()
    local slaves = SummonSwordman.getSlaves(caster)
    local count = 0
    if slaves ~= nil then
        count = #slaves
    end

    local x, y = caster:getPos()
    local new_circles = createCircles(count, mouse_x, mouse_y, x, y)

    for i = 1, #effects do
        BlzSetSpecialEffectPosition(effects[i], 0, 0, -5000)
        DestroyEffect(effects[i])
    end
    for i = 1, #new_circles do
        effects[i] = new_circles[i]
    end
    for i = #new_circles + 1, #effects do
        effects[i] = nil
    end
end

---@param caster Unit
---@param target Unit|userdata|nil
---@param x number
---@param y number
local function startTargeting(caster, target, x, y)
    Debug('Tracking started')
    local owner_index = caster:getOwningPlayerIndex()
    caster:removeAbility(dummySpiritRush)
    caster:addAbility(SpiritRush)
    --glTimer.addAction(0, function() Debug('Key pressed') Players.forceUIKey(owner_index, hot_key) end, nil)
    local slaves = SummonSwordman.getSlaves(caster)
    local caster_x, caster_y = caster:getPos()
    local circles = createCircles(#slaves, 0, 0, caster_x, caster_y)
    PlayerEvent.localPlayer_mouseMove:addAction(function()
            trackingTarget(caster, circles)
        end)
    Debug('Tracking started')
end

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
        glTimer.addAction(movePeriod, moveUnit, data)
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
        glTimer.addAction(movePeriod, moveUnit, data)
    end
end

SpiritRush:setCallback(finish, 'finish')
SpiritRush:setName(ability_name)
SpiritRush:setCastingTime(cast_time)

dummySpiritRush:setCallback(startTargeting, 'finish')

return dummySpiritRush