---@type Ability
local Ability = require('baseClasses.Ability.AbilityData')
---@type DataBase
local DataBase = require('utils.DataBase')
---@type Unit
local Unit = require('baseClasses.Unit')
---@type Item
local Item = require('baseClasses.Item')
---@type Destructable
local Destructable = require('baseClasses.Destructable')
---@type Settings
local Settings = require('utils.Settings')

---@class AbilityEvent
local AbilityEvent = {
    __casters_db = DataBase.new('Unit', 'table')
}

--- Predefined
local mainLoop
local unitStartsCasting
local cancelCasting
local getSpellTarget
local unitIssuedAnyOrder

local casting_timer
local timer_period

local initialized = false
function AbilityEvent.init()
    if initialized then return nil end

    local any_unti_finish_casting_trigger = Unit.getTrigger(EVENT_PLAYER_UNIT_SPELL_EFFECT)
    any_unti_finish_casting_trigger:addAction(runFuncInDebug, unitStartsCasting)

    local any_unit_issued_notarget_order = Unit.getTrigger(EVENT_PLAYER_UNIT_ISSUED_ORDER)
    any_unit_issued_notarget_order:addAction(runFuncInDebug, unitIssuedAnyOrder)

    local any_unit_issued_point_order = Unit.getTrigger(EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    any_unit_issued_point_order:addAction(runFuncInDebug, unitIssuedAnyOrder)

    local any_unit_issued_target_order = Unit.getTrigger(EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    any_unit_issued_target_order:addAction(runFuncInDebug, unitIssuedAnyOrder)

    local any_unit_issued_unit_order = Unit.getTrigger(EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    any_unit_issued_unit_order:addAction(runFuncInDebug, unitIssuedAnyOrder)
    --UnitEvent.init()
    --UnitEvent.getTrigger("AnyUnitStartCastingAbility"):addAction(AbilityEvent.unitStartsCasting)
    --UnitEvent.getTrigger("AnyUnitIssuedAnyOrder"):addAction(unitIssuedAnyOrder)

    casting_timer = glTimer
    timer_period = glTimer:getPeriod()

    initialized = true
end

--- Parameter function should return full casting time of ability. Default: 3.
---@param func fun(caster:Unit, target:Unit|Item|Destructable|Vec2):number
function Ability:setCastingTimeFunction(func)
    if not self.__casting_callbacks then
        self.__casting_callbacks = {}
    end
    self.__casting_callbacks.getTimeout = func
end

---@param caster Unit
---@param target Unit|Item|Destructable|Vec2
---@return number
function Ability:getCastingTime(caster, target)
    if type(self.__casting_callbacks.getTimeout) == 'function' then
        return self.__casting_callbacks.getTimeout(caster, target)
    end
    return 3
end

--- Callback should return true if casting started successfully. Default: true.
---@param callback fun(caster:Unit, target:Unit|Item|Destructable|Vec2):boolean
function Ability:setStartCallback(callback)
    if not self.__casting_callbacks then
        self.__casting_callbacks = {}
    end
    self.__casting_callbacks.start = callback
end

---@param caster Unit
---@param target Unit|Item|Destructable|Vec2
---@return boolean
function Ability:runStartCallback(caster, target)
    if type(self.__casting_callbacks.start) == 'function' then
        return self.__casting_callbacks.start(caster, target)
    end
    return true
end

---@param callback fun(caster:Unit, target:Unit|Item|Destructable|Vec2, elapsed_time:number, timeout:number):nil
function Ability:setCancelCallback(callback)
    if not self.__casting_callbacks then
        self.__casting_callbacks = {}
    end
    self.__casting_callbacks.cancel = callback
end

---@param caster Unit
---@param target Unit|Item|Destructable|Vec2
---@param elapsed_time number
---@param timeout number
function Ability:runCancelCallback(caster, target, elapsed_time, timeout)
    if type(self.__casting_callbacks.cancel) == 'function' then
        self.__casting_callbacks.finish(caster, target, elapsed_time, timeout)
    end
end

---@param callback fun(caster:Unit, target:Unit|Item|Destructable|Vec2, timeout:number):nil
function Ability:setFinishCallback(callback)
    if not self.__casting_callbacks then
        self.__casting_callbacks = {}
    end
    self.__casting_callbacks.finish = callback
end

---@param caster Unit
---@param target Unit|Item|Destructable|Vec2
---@param timeout number
function Ability:runFinishCallback(caster, target, timeout)
    if type(self.__casting_callbacks.finish) == 'function' then
        self.__casting_callbacks.finish(caster, target, timeout)
    end
end

--- Callback should return false if casting interrupted. Default: true.
---@param callback fun(caster:Unit, target:Unit|Item|Destructable|Vec2, elapsed_time:number, timeout:number):nil
function Ability:setCastingCallback(callback)
    if not self.__casting_callbacks then
        self.__casting_callbacks = {}
    end
    self.__casting_callbacks.casting = callback
end

---@param caster Unit
---@param target Unit|Item|Destructable|Vec2
---@param elapsed_time number
---@param timeout number
function Ability:runCastingCallback(caster, target, elapsed_time, timeout)
    if type(self.__casting_callbacks.casting) == 'function' then
        return self.__casting_callbacks.casting(caster, target, elapsed_time, timeout)
    end
    return true
end

---@param callback fun(caster:Unit, target:Unit|Item|Destructable|Vec2, elapsed_time:number, timeout:number):nil
function Ability:setInterruptCallback(callback)
    if not self.__casting_callbacks then
        self.__casting_callbacks = {}
    end
    self.__casting_callbacks.interrupt = callback
end

---@param caster Unit
---@param target Unit|Item|Destructable|Vec2
---@param elapsed_time number
---@param timeout number
function Ability:runInterruptCallback(caster, target, elapsed_time, timeout)
    if type(self.__casting_callbacks.interrupt) == 'function' then
        return self.__casting_callbacks.interrupt(caster, target, elapsed_time, timeout)
    end
    return true
end

unitStartsCasting = function()
    local ability = Ability.GetSpellAbility()
    if not ability then return nil end

    local caster = Unit.GetSpellAbilityUnit()
    local target = getSpellTarget()
    Debug(target)

    local prev_data = AbilityEvent.__casters_db:get(caster)
    if prev_data then
        AbilityEvent.__casters_db:remove(caster)
        caster:addMoveSpeed(0, 10^6, 0)
        UnitRemoveAbility(caster:getObj(), ID('Abun'))
        runFuncInDebug(prev_data.ability.runCancelCallback, ability, prev_data.caster, prev_data.target)

        if Settings.Events.VerboseAbilityCasting then
            Debug("Casting canceled.")
        end
    end

    ---@class CasterData
    local data = {
        caster = caster,
        ability = ability,
        elapsed_time = 0,
        timeout = ability:getCastingTime(caster, target),
        target = target
    }

    caster:addMoveSpeed(0, -10^6, 0)
    UnitAddAbility(caster:getObj(), ID('Abun'))
    runFuncInDebug(ability.runStartCallback, ability, caster, target)

    AbilityEvent.__casters_db:add(caster, data)
    casting_timer:addAction(0, mainLoop, data)

    if Settings.Events.VerboseAbilityCasting then
        Debug("Casting started.")
    end
end

---@param data table
mainLoop = function(data)
    if data ~= AbilityEvent.__casters_db:get(data.caster) then
        return nil
    end
    --- Is casting time passed?
    data.elapsed_time = data.elapsed_time + timer_period
    if data.timeout <= data.elapsed_time then
        AbilityEvent.__casters_db:remove(data.caster)
        data.caster:addMoveSpeed(0, 10^6, 0)
        UnitRemoveAbility(data.caster:getObj(), ID('Abun'))
        runFuncInDebug(data.ability.runFinishCallback, data.ability, data.caster, data.target, data.timeout)

        if Settings.Events.VerboseAbilityTargeting then
            Debug("Casting finished.")
        end
        return nil
    end

    --- Should unit continue casting or it is interrupted.
    local continue = runFuncInDebug(data.ability.runCastingCallback, data.ability, data.caster, data.target, data.elapsed_time, data.timeout)
    if continue then
        casting_timer:addAction(0, mainLoop, data)
    else
        AbilityEvent.__casters_db:remove(data.caster)
        data.caster:addMoveSpeed(0, 10^6, 0)
        UnitRemoveAbility(data.caster:getObj(), ID('Abun'))
        data.ability:runInterruptCallback(data.caster, data.target, data.elapsed_time, data.timeout)

        if Settings.Events.VerboseAbilityTargeting then
            Debug("Casting interrupted.")
        end
    end
end

unitIssuedAnyOrder = function()
    if GetIssuedOrderId() == 851983 then return nil end
    local caster = Unit.GetOrderedUnit()
    local data = AbilityEvent.__casters_db:get(caster)
    if not data then return nil end

    data.ability:runCancelCallback(data.caster, data.target)
    AbilityEvent.__casters_db:remove(caster)
    caster:addMoveSpeed(0, 10^6, 0)
    UnitRemoveAbility(caster:getObj(), ID('Abun'))

    if Settings.Events.VerboseAbilityCasting then
        Debug("Casting canceled.")
    end
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

return AbilityEvent