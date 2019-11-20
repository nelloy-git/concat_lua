--=========
-- Include
--=========

---@type ActionClass
local Action = require('Class.Action')
---@type AbilityInstanceClass
local AbilityInstance = require('Class.Ability.AbilityInstance')
---@type BetterTimerClass
local BetterTimer = require('Class.BetterTimer')
---@type DataBaseClass
local DataBase = require('utils.DataBase')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

---@type AbilityTypeClass
local AbilityType = newClass('AbilityType')

---@class AbilityType
local public = AbilityType.public
---@class AbilityTypeClass
local static = AbilityType.static
---@type table
local override = AbilityType.override
---@type table(Ability, table)
local private = {}

private.DB = DataBase.new('number', getClassName(AbilityType))
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
end

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return AbilityType
function static.new(id, instance_data)
    local instance = instance_data or newInstanceData(AbilityType)
    local priv = {
        id = ID(id),

        can_move = false,
        can_attack = false,

        casting_time = nil,

        start_action = nil,
        cancel_action = nil,
        casting_action = nil,
        finish_action = nil,
        interrupt_action = nil,
    }
    private[instance] = priv
    private.DB:set(ID(id), instance)

    return instance
end

---@return AbilityType
function static.get(id)
    return private.DB:get(id)
end

---@return number
function public:getId()
    local priv = private[self]
    return priv.id
end

---@param func fun(caster:unit):number | number
function public:setCastingTime(func)
    local priv = private[self]
    priv.casting_time = func
end

---@param caster unit
---@return number
function public:getCastingTime(caster)
    local priv = private[self]

    if type(priv.casting_time) == 'function' then
        return priv.casting_time(caster)
    elseif type(priv.casting_time) == 'number' then
        return priv.casting_time
    end
    return 0
end

---@param action Action
function public:setStartAction(action)
    local priv = private[self]
    priv.start_action = action
end

---@param action Action
function public:setCancelAction(action)
    local priv = private[self]
    priv.cancel_action = action
end

---@param action Action
function public:setCastingAction(action)
    local priv = private[self]
    priv.casting_action = action
end

---@param action Action
function public:setFinishAction(action)
    local priv = private[self]
    priv.finish_action = action
end

---@param action Action
function public:setInterruptAction(action)
    local priv = private[self]
    priv.interrupt_action = action
end

--- Default returns true
---@param self AbilityType
---@return boolean
function private.runStartAction(self)
    local priv = private[self]
    return private.runActionSavety(priv.start_action)
end

--- Default returns true
---@param self AbilityType
---@return boolean
function private.runCancelAction(self)
    local priv = private[self]
    return private.runActionSavety(priv.cancel_action)
end

--- Default returns true
---@param self AbilityType
---@return boolean
function private.runCastingAction(self)
    local priv = private[self]
    return private.runActionSavety(priv.casting_action)
end

--- Default returns true
---@param self AbilityType
---@return boolean
function private.runFinishAction(self)
    local priv = private[self]
    return private.runActionSavety(priv.finish_action)
end

--- Default returns true
---@param self AbilityType
---@return boolean
function private.runInterruptAction(self)
    local priv = private[self]
    return private.runActionSavety(priv.interrupt_action)
end

---@return boolean
function private.runActionSavety(action)
    if not action then
        return true
    end

    local success = action:run()
    if type(success) == 'boolean' then
        return success
    end

    return true
end

function private.onSpellEffect()
    local id = GetSpellAbilityId()
    local abil_type = private.DB:get(id)
    
    -- If is not in DB then do nothing
    if not abil_type then return nil end
    
    local caster = GetSpellAbilityUnit()

    private.cancelCastingAbility(abil_type, caster)


    -- Cancel current casting.
    caster:cancelCasting()
    -- Start new casting.
    caster:startCasting(abil_type, getSpellTarget())

    if Settings.Events.VerboseAbilityCasting then
        Debug("Casting started.")
    end
end

---@param self AbilityType
---@param caster unit
function private.cancelCastingAbility(self, caster)
    local abil_instance = AbilityInstance.getCurrent(caster)
    if abil_instance ~= nil then
        private.runCancelAction(self)
        abil_instance:free()
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

---@param data table
mainLoop = function(data)
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

return AbilityEvent



return AbilityType