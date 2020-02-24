--=========
-- Include
--=========

---@type UnitAPI
local UnitAPI = require('Unit.API')
local Unit = UnitAPI.Unit
---@type AbilityAPI
local AbilityAPI = require('Ability.API')
local AbilityType = AbilityAPI.Type
local Ability = AbilityAPI.Ability
local AbilityCastInstance = AbilityAPI.CastInstance
local AbilityStatus = AbilityAPI.Status
---@type Timer
local Timer = require('Timer.Timer')
---@type Trigger
local Trigger = require('Utils.Trigger')
---@type InterfaceAPI
local InterfaceAPI = require('Interface.API')

--=================
-- Ability casting
--=================

local AbilityCasting = {}

AbilityCasting.casting_period = 0.1
AbilityCasting.casters = {}
AbilityCasting.spell_order_id = AbilityType.getOrderId()

function AbilityCasting.onSpellEffect()
    local caster = Unit.getInstance(GetSpellAbilityUnit())
    local ability = Ability.getLastOrdered(caster)
    local ability_type = AbilityType.getInstance(GetSpellAbilityId())
    local target = ability_type:getEventTarget()

    if ability:getType() ~= ability_type then
        Log.error('AbilityCastingEvent', 'error in casting system. Current ability != last ordered ability.', 1)
    end

    AbilityCastInstance.new(caster, target, ability_type, ability:getLevel())
    table.insert(AbilityCasting.casters, caster)
end

function AbilityCasting.castingLoop()
    local new_list = {}
    for i = 1, #AbilityCasting.casters do
        local caster = AbilityCasting.casters[i]
        local cast = AbilityCastInstance.getInstance(caster)

        local status = cast:casting(AbilityCasting.casting_period)
        if status == AbilityStatus.OK then
            table.insert(new_list, caster)

            InterfaceAPI.CastingBar:setText(string.format('%.1f', cast:getTimeLeft()))
            InterfaceAPI.CastingBar:setStatus(1, 100 * (1 - cast:getTimeLeft() / cast:getFullTime()) )
        end

        if status == AbilityStatus.FINISH then
            InterfaceAPI.CastingBar:setText('Finished')
        end

    end
    AbilityCasting.casters = new_list
end

if not IsCompiletime() then
    AbilityCasting.timer = Timer.new()
    AbilityCasting.timer:start(AbilityCasting.casting_period, true, AbilityCasting.castingLoop)

    AbilityCasting.spell_effect_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        AbilityCasting.spell_effect_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, Player(i))
    end
    AbilityCasting.spell_effect_trigger:addAction(AbilityCasting.onSpellEffect)
end

--=================
-- Ability control
--=================

local AbilityControl = {}

AbilityControl.mouse_x = 0
AbilityControl.mouse_y = 0

function AbilityControl.keyCallback()
    local key = BlzGetTriggerPlayerKey()
    local pos = AbilityControl.pos[key]
    if not pos then
        return
    end

    local is_down = BlzGetTriggerPlayerIsKeyDown()
    if is_down then
        return
    end

    local unit = InterfaceAPI.getTarget()
    if not unit or unit:getOwner() ~= GetLocalPlayer() then
        return
    end

    local abil = unit:getAbilities():get(pos)
    if not abil then
        return
    end

    local target_unit_obj = BlzGetMouseFocusUnit()
    local target
    if target_unit_obj then
        target = AbilityAPI.TargetUnit.new(target_unit_obj)
    else
        target = AbilityAPI.TargetPoint.new(AbilityControl.mouse_x, AbilityControl.mouse_y)
    end

    abil:use(target)
end

function AbilityControl.mouseCallback()
    AbilityControl.mouse_x = BlzGetTriggerPlayerMouseX()
    AbilityControl.mouse_y = BlzGetTriggerPlayerMouseY()
end

function AbilityControl.cooldownLoop()
    InterfaceAPI.AbilityBar:updateCooldown()
end

if not IsCompiletime() then
    AbilityControl.pos = {
        [OSKEY_Q] = 1,
        [OSKEY_W] = 2,
        [OSKEY_E] = 3,
        [OSKEY_R] = 4,
        [OSKEY_T] = 5,
    }

    AbilityControl.key_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        for key,_ in pairs(AbilityControl.pos) do
            AbilityControl.key_trigger:addPlayerKeyEvent(Player(i), key, 0, true)
            AbilityControl.key_trigger:addPlayerKeyEvent(Player(i), key, 0, false)
        end
    end
    AbilityControl.key_trigger:addAction(AbilityControl.keyCallback)

    AbilityControl.mouse_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        AbilityControl.mouse_trigger:addPlayerEvent(EVENT_PLAYER_MOUSE_MOVE, Player(i))
    end
    AbilityControl.mouse_trigger:addAction(AbilityControl.mouseCallback)

    AbilityControl.cooldown_timer = Timer.new()
    AbilityControl.cooldown_timer:start(1 / 32, true, AbilityControl.cooldownLoop)
end