--=========
-- Include
--=========

---@type UnitAPI
local UnitAPI = require('Unit.API')
local Unit = UnitAPI.Unit
---@type AbilityOldAPI
local AbilityOldAPI = require('AbilityOld.API')
local AbilityOldTypeOld = AbilityOldAPI.Type
local AbilityOld = AbilityOldAPI.AbilityOld
local AbilityOldCastInstance = AbilityOldAPI.CastInstance
local AbilityOldStatus = AbilityOldAPI.Status
---@type Timer
local Timer = require('Timer.Timer')
---@type Trigger
local Trigger = require('Utils.Trigger')
---@type InterfaceAPI
local InterfaceAPI = require('Interface.API')

--=================
-- AbilityOld casting
--=================

local AbilityOldCasting = {}

AbilityOldCasting.casting_period = 0.1
AbilityOldCasting.casters = {}

--=================
-- AbilityOld control
--=================

local AbilityOldControl = {}

AbilityOldControl.mouse_x = 0
AbilityOldControl.mouse_y = 0

function AbilityOldControl.keyCallback()
    local key = BlzGetTriggerPlayerKey()
    local pos = AbilityOldControl.pos[key]
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
        target = AbilityOldAPI.TargetUnit.new(target_unit_obj)
    else
        target = AbilityOldAPI.TargetPoint.new(AbilityOldControl.mouse_x, AbilityOldControl.mouse_y)
    end

    abil:use(target)
end

function AbilityOldControl.mouseCallback()
    AbilityOldControl.mouse_x = BlzGetTriggerPlayerMouseX()
    AbilityOldControl.mouse_y = BlzGetTriggerPlayerMouseY()
end

function AbilityOldControl.timerLoop()
    InterfaceAPI.AbilityOldBar:updateCooldown()

    local target = InterfaceAPI.getTarget()
    local cur_cast_time = AbilityOldAPI.getCastingTimeLeft(target)
    if cur_cast_time < 0 then
        return
    end
    local full_cast_time = AbilityOldAPI.getCastingTimeFull(target)
    if full_cast_time < 0 then
        return
    end

    InterfaceAPI.CastingBar:setStatus(1, 100 * cur_cast_time / full_cast_time)
end

if not IsCompiletime() then
    AbilityOldControl.pos = {
        [OSKEY_Q] = 1,
        [OSKEY_W] = 2,
        [OSKEY_E] = 3,
        [OSKEY_R] = 4,
        [OSKEY_T] = 5,
    }

    AbilityOldControl.key_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        for key,_ in pairs(AbilityOldControl.pos) do
            AbilityOldControl.key_trigger:addPlayerKeyEvent(Player(i), key, 0, true)
            AbilityOldControl.key_trigger:addPlayerKeyEvent(Player(i), key, 0, false)
        end
    end
    AbilityOldControl.key_trigger:addAction(AbilityOldControl.keyCallback)

    AbilityOldControl.mouse_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        AbilityOldControl.mouse_trigger:addPlayerEvent(EVENT_PLAYER_MOUSE_MOVE, Player(i))
    end
    AbilityOldControl.mouse_trigger:addAction(AbilityOldControl.mouseCallback)

    AbilityOldControl.cooldown_timer = Timer.new()
    AbilityOldControl.cooldown_timer:start(1 / 32, true, AbilityOldControl.timerLoop)
end