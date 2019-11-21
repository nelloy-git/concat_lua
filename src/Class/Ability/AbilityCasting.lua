--=========
-- Include
--=========

---@type AbilityTypeClass
local AbilityType = require('Class.Ability.AbilityType')
---@type ActionClass
local Action = require('Class.Action')
---@type BetterTimerClass
local BetterTimer = require('Class.BetterTimer')
---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')
---@type UnitParametersContainerClass
local UnitParameterContainer = require('Class.Unit.UnitParametersContainer')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

---@type AbilityCastingClass
local AbilityCasting = newClass('AbilityCasting')

---@class AbilityCasting
local public = AbilityCasting.public
---@class AbilityCastingClass
local static = AbilityCasting.static
---@type table
local override = AbilityCasting.override
---@type table(AbilityCasting, table)
local private = {}

private.DB = DataBase.new('userdata', getClassName(AbilityCasting))
private.ms_const = 10^10
private.disable_attack_id = ID('Abun')
private.timer = BetterTimer.getGlobalTimer()
private.period = private.glTimer:getPeriod()

if not is_compiletime then
    private.wc3_spell_effect_trigger = Trigger.new()
    private.wc3_unit_issued_order_trigger = Trigger.new()
    private.wc3_unit_issued_point_order_trigger = Trigger.new()
    private.wc3_unit_issued_target_order_trigger = Trigger.new()
    private.wc3_unit_issued_unit_order_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        local pl = Player(i)
        private.wc3_spell_effect_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, pl)
        private.wc3_unit_issued_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_ORDER, pl)
        private.wc3_unit_issued_point_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, pl)
        private.wc3_unit_issued_target_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, pl)
        private.wc3_unit_issued_unit_order_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER, pl)
    end

    --private.wc3_spell_effect_trigger:addAction(Action.new(private.onSpellEffect))
end

--=========
-- Methods
--=========

---@param caster unit
---@param target any
---@param abil_type AbilityType
function static.start(caster, target, abil_type)
    -- Cancel current casting ability
    private.cancelCurrent(caster)

    -- Check if ability started
    local success = private.runWithGetters(caster, target, abil_type, abil_type.runStartAction, abil_type)
    if not success then
        return nil
    end
    -- Applies flags to caster
    private.runWithGetters(abil_type.flags.applyFlagsToCaster, abil_type.flags, caster)
    -- Adds casting to timer
    private.timer:addAction(0, function() private.timerLoop() end)

    private.startCastingAbility(caster, target, abil_type)
end

---@return AbilityCasting | nil
function static.getCurrent(caster)
    return private.DB:get(caster)
end

function public:free()
    private.stop(self)
    private[self] = nil
    freeInstanceData(self)
end

function private.new(caster, target, abil_type, instance_data)
    ---@type AbilityCasting
    local instance = instance_data or newInstanceData(AbilityCasting)
    instance.full_time = abil_type:getCastingTime(caster)
    instance.time_left = instance.time_full
    local priv = {
        caster = caster,
        target = target,
        abil_type = abil_type,
    }
    private[instance] = priv

    return instance
end

---@param caster unit
function private.cancelCurrent(caster)
    local abil_instance = private.DB:get(caster)
    if abil_instance ~= nil then
        local priv = private[abil_instance]
        local abil_type = priv.abil_type
        abil_type:runCancelAction()
        abil_instance:free()
    end
end

---@param self AbilityCasting
function private.applyAbilityFlags(self)
    local priv = private[self]
    if not priv.is_running then
        Debug(string.format("%s error: can not stop. Is not running.", getClassName(AbilityCasting)))
        return nil
    end

    if not priv.can_move then
        local params = UnitParameterContainer.get(priv.caster)
        params:addMult(ParameterType.MS, private.ms_const)
    end

    if not priv.can_attack then
        UnitRemoveAbility(priv.caster, private.disable_attack_id)
    end
end

---@param self AbilityCasting
---@param caster unit
function private.start(self, caster)
    local priv = private[self]

    priv.caster = caster
    private.DB:set(caster, self)

    if priv.is_running then
        Debug(string.format("%s error: can not run. Already running.", getClassName(AbilityCasting)))
        return nil
    end

    priv.is_running = true

    if not can_move then
        local params = UnitParameterContainer.get(caster)
        params:addMult(ParameterType.MS, -private.ms_const)
        priv.can_move = false
    end

    if not can_attack then
        UnitAddAbility(caster, private.disable_attack_id)
        priv.can_attack = false
    end
end

    local success =  runFuncInDebug(ability.runStartCallback, ability, self, target)
    if success then
        ---@class CasterData
        local data = {
            caster = self,
            ability = ability,
            elapsed_time = 0,
            timeout = ability:getCastingTime(self, target),
            target = target
        }

        -- Disable moving
        self:addMoveSpeed(0, -10^6, 0)
        -- Disable attacks
        UnitAddAbility(self:getObj(), ID('Abun'))

        AbilityEvent.__casters_db:add(self, data)
        casting_timer:addAction(0, mainLoop, data)
    else
        if Settings.Events.VerboseAbilityCasting then
            Debug("Casting canceled.")
        end
    end
end

unitStartsCasting = function()
    local ability = AbilityType.GetSpellAbility()
    if not ability then return nil end
    local caster = Unit.GetSpellAbilityUnit()

    -- Cancel current casting.
    caster:cancelCasting()
    -- Start new casting.
    caster:startCasting(ability, getSpellTarget())

    if Settings.Events.VerboseAbilityCasting then
        Debug("Casting started.")
    end
end

function Unit:cancelCasting()
    local data = AbilityEvent.__casters_db:get(self)
    if data then
        AbilityEvent.__casters_db:remove(self)

        -- Enable moving
        self:addMoveSpeed(0, 10^6, 0)
        -- Enable attacks
        UnitRemoveAbility(self:getObj(), ID('Abun'))

        runFuncInDebug(data.ability.runCancelCallback, data.ability, data.caster, data.target)

        if Settings.Events.VerboseAbilityCasting then
            Debug("Casting canceled.")
        end
    end
end

function Unit:interruptCasting()
    local data = AbilityEvent.__casters_db:get(self)
    if data then
        AbilityEvent.__casters_db:remove(self)

        -- Enable moving
        self:addMoveSpeed(0, 10^6, 0)
        -- Enable attacks
        UnitRemoveAbility(data.caster:getObj(), ID('Abun'))

        runFuncInDebug(data.ability.runInterruptCallback, data.ability, data.caster, data.target, data.elapsed_time, data.timeout)

        if Settings.Events.VerboseAbilityTargeting then
            Debug("Casting interrupted.")
        end
    end
end

---@param ability Ability
---@param target Unit|Item|Destructable|Vec2
function Unit:startCasting(ability, target)
    local success = runFuncInDebug(ability.runStartCallback, ability, self, target)
    if success then
        ---@class CasterData
        local data = {
            caster = self,
            ability = ability,
            elapsed_time = 0,
            timeout = ability:getCastingTime(self, target),
            target = target
        }

        -- Disable moving
        self:addMoveSpeed(0, -10^6, 0)
        -- Disable attacks
        UnitAddAbility(self:getObj(), ID('Abun'))

        AbilityEvent.__casters_db:add(self, data)
        casting_timer:addAction(0, mainLoop, data)
    else
        if Settings.Events.VerboseAbilityCasting then
            Debug("Casting canceled.")
        end
    end
end

function Unit:finishCasting()
    local data = AbilityEvent.__casters_db:get(self)
    if data then
        AbilityEvent.__casters_db:remove(data.caster)

        -- Enable moving
        self:addMoveSpeed(0, 10^6, 0)
        -- Enable attacks
        UnitRemoveAbility(data.caster:getObj(), ID('Abun'))

        runFuncInDebug(data.ability.runFinishCallback, data.ability, data.caster, data.target, data.timeout)

        if Settings.Events.VerboseAbilityTargeting then
            Debug("Casting finished.")
        end
    end
end

function private.timerLoop(ability_instance)
    if ability_instance.time_left <= 0 then

    ability_instance.time_left = ability_instance.time_left - private.timer_period

    runFuncInDebug(function()
        if data ~= AbilityEvent.__casters_db:get(data.caster) then
            return nil
        end
        --- Is casting time passed?
        data.elapsed_time = data.elapsed_time + timer_period
        if data.timeout <= data.elapsed_time then
            data.caster:finishCasting()
            return nil
        end

        --- Should unit continue casting or it is interrupted by ability itself.
        local success = runFuncInDebug(data.ability.runCastingCallback, data.ability, data.caster, data.target, data.elapsed_time, data.timeout)
        if success then
            casting_timer:addAction(0, mainLoop, data)
        else
            data.caster:interruptCasting()
        end
    end)
end

unitIssuedAnyOrder = function()
    if GetIssuedOrderId() == 851983 then return nil end
    local caster = Unit.GetOrderedUnit()
    caster:cancelCasting()
end

---@return Unit|Item|Destructable|Vec2|nil
getSpellTarget = function()
    local target = Unit.GetSpellTargetUnit()
    if target then return target end
    target = Item.GetSpellTargetItem()
    if target then return target end
    target = Destructable.GetSpellTargetDestructable()
    if target then return target end
    target = GetSpellTargetPos()
    return target
end


function private.onSpellEffect()
    local id = GetSpellAbilityId()
    local self = private.DB:get(id)
    if not self then return nil end
    local priv = private[self]
    local caster = GetSpellAbilityUnit()

    private.cancelCurrent(self, caster)
    private.startCastingAbility(self, caster)
end

function static.getCaster()
    return nil
end

function static.getTarget()
    return nil
end

function static.getAbilityType()
    return nil
end

---@param caster unit
---@param target any
---@param abil_type AbilityType
---@param func fun(vararg:any):any
---@return any
function private.runWithGetters(caster, target, abil_type, func, ...)
    local prev_getCaster = static.getCaster
    local prev_getTarget = static.getTarget
    local prev_getAbilityType = static.getAbilityType

    static.getCaster = function() return caster end
    static.getTarget = function() return target end
    static.getAbilityType = function() return abil_type end

    local res = func(...)

    static.getCaster = prev_getCaster
    static.getTarget = prev_getTarget
    static.getAbilityType = prev_getAbilityType

    return res
end

return AbilityCasting