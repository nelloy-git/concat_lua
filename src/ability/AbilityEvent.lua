---@type Ability
local Ability = require('ability.Ability')
---@type UnitEvent
local UnitEvent = require('utils.trigger.events.UnitEvents')
---@type PlayerEvent
local PlayerEvent = require('utils.trigger.events.PlayerEvents')
---@type SpellData
local SpellData = require('ability.SpellData')
---@type DataBase
local DataBase = require('utils.DataBase')
---@type Settings
local Settings = require('utils.Settings')

---@alias AbilityEventName string
---| '"startTargeting"'     #Callback is called when player starts targeting ability.
---| '"targeting"'          #Callback is called every timer period while player is targeting.
---| '"finishTargeting"'    #Callback is called when player cancel targeting ability.
---| '"start"'              #Callback is called when unit starts casting.
---| '"casting"'            #Callback is called every loop of timer while unit is casting an ability.
---| '"cancel"'             #Callback is called when player cancels ability.
---| '"interrupt"'          #Callback is called when unit interrupted casting.
---| '"finish"'             #Callback is called if casting was not interrupted and cast time passed.

---@class AbilityEvent
local AbilityEvent = {
    __targeting_db = DataBase.new('userdata', 'Ability')
}

local cancel_btn_frame
local normal_btn_alpha
local changed_btn_alpha

local initialized = false
function AbilityEvent.init()
    if initialized then return nil end
    UnitEvent.init()
    UnitEvent.getTrigger("AnyUnitStartChannelAbility"):addAction(AbilityEvent.unitUsesAbility)
    UnitEvent.getTrigger("AnyUnitIssuedAnyOrder"):addAction(AbilityEvent.unitIssuedOrder)

    AbilityEvent.__cast_timer = glTimer
    AbilityEvent.__cast_timer_period = glTimer:getPeriod()

    cancel_btn_frame = BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, 11)
    normal_btn_alpha = BlzFrameGetAlpha(cancel_btn_frame)
    if normal_btn_alpha > 127 then
        changed_btn_alpha = math.floor(normal_btn_alpha - 5)
    else
        changed_btn_alpha = math.floor(normal_btn_alpha + 5)
    end

    initialized = true
end

---Calls this function when any unit starts casting ability.
function AbilityEvent.unitUsesAbility()
    local id = GetSpellAbilityId()
    local caster = GetSpellAbilityId()
    local ability = Ability.get(id)
    local caster_data = SpellData.get(caster)

    --- Cancel previous ability.
    if caster_data ~= nil then
        AbilityEvent.cancelCastingAbility(caster_data)
    end

    --- new data
    caster_data = SpellData.new(ability, caster)

    ---Unit used dummy ability -> start targeting loop.
    if id == ability:getUI_Id() then
        AbilityEvent.startTargetingLoop(caster_data)
    ---Unit used main ability -> start casting loop.
    elseif id == ability:getId() then
        AbilityEvent.startCastingLoop(caster_data)
    end
end

--- =========
---  Cancel.
--- =========

---@param caster_data SpellData
function AbilityEvent.cancelCastingAbility(caster_data)
    caster_data:cancel()
end

--- ============
---  Targeting.
--- ============

---@param caster_data SpellData
function AbilityEvent.startTargetingLoop(caster_data)
    local owner = GetOwningPlayer(caster_data:getCaster())

    SetPlayerAbilityAvailable(owner, ability:getUI_Id(), false)
    SetPlayerAbilityAvailable(owner, ability:getId(), true)
    ForceUIKeyBJ(owner, caster_data:getAbility():getHotkey())

    caster_data:getAbility():getHotkey():runCallback('startTargeting', caster_data)

    if owner == GetLocalPlayer() then
        BlzFrameSetAlpha(cancel_btn_frame, changed_btn_alpha)
        local action = PlayerEvent.getTrigger("LocalPlayerMouseMove"):addAction(AbilityEvent.cursorCatcher, caster_data)
        caster_data:setMouseAction(action)
        AbilityEvent.__cast_timer:addAction(0, AbilityEvent.targetingLoop, caster_data)
    end

    if Settings.Events.VerboseAbility then
        Debug("Targeting started")
    end
end

---@param spell_data SpellData
function AbilityEvent.cursorCatcher(spell_data)
    spell_data:setMousePos(Vec2.new(BlzGetTriggerPlayerMouseX(), BlzGetTriggerPlayerMouseX()))
end

---@param caster_data SpellData
function AbilityEvent.targetingLoop(caster_data)
    if BlzFrameGetAlpha(cancel_btn_frame) ~= normal_btn_alpha then
        caster_data:getAbility():runCallback("targeting", caster_data)
        AbilityEvent.__cast_timer:addAction(0, AbilityEvent.targetingLoop, caster_data)
    else
        AbilityEvent.finishTargetingAbility(data.unit, data.ability)
    end
end

---@param caster_data SpellData
function AbilityEvent.finishTargetingAbility(caster_data)
    local owner = GetOwningPlayer(caster)

    PlayerEvent.getTrigger("LocalPlayerMouseMove"):removeAction(caster_data:getMouseAction())
    SetPlayerAbilityAvailable(owner, ability:getId(), false)
    SetPlayerAbilityAvailable(owner, ability:getUI_Id(), true)

    caster_data:getAbility():runCallback('finishTargeting', caster_data)

    if Settings.Events.VerboseAbility then
        Debug("Targeting finished")
    end
end

--- =========
---  Casting
--- =========

---@param caster_data SpellData
---@return SpellData | nil
function AbilityEvent.startCastingLoop(caster_data)
    caster_data:setTargetPos(GetSpellTargetPos())
    caster_data:setTarget(AbilityEvent.getSpellTarget())
    caster_data:setCastingTime(caster_data:getAbility():getCastingTime(caster_data))

    --- Try start casting.
    local success = caster_data:getAbility():runCallback("start", caster_data)
    if not success then
        caster_data:destroy()
        return nil
    end

    AbilityEvent.__cast_timer:addAction(0, AbilityEvent.castingLoop, caster_data)

    if Settings.Events.VerboseAbility then
        Debug(string.format("Casting started - %b", continue))
    end
end

---@param caster_data SpellData
function AbilityEvent.castingLoop(caster_data)
    if caster_data:cancel() then
        caster_data:getAbility():runCallback("cancel")
        caster_data:destroy()
        return nil
    end

    --- Is casting time passed?
    caster_data:addElapsedTime(AbilityEvent.__cast_timer_period)
    if caster_data:isFinished() then
        caster_data:getAbility():runCallback("finish", caster_data)
        caster_data:destroy()

        if Settings.Events.VerboseAbility then
            Debug("Casting finished.")
        end
        return nil
    end

    --- Should unit continue casting or its interrupted.
    local continue = caster_data:getAbility():runCallback('casting', caster_data)
    if continue then
        AbilityEvent.__cast_timer:addAction(0, AbilityEvent.castingLoop, caster_data)
    else
        caster_data:getAbility():runCallback("interrupt", caster_data)
        caster_data:destroy()

        if Settings.Events.VerboseAbility then
            Debug("Casting interrupted.")
        end
    end
end

---@return unit|item|destructable|nil
function AbilityEvent.getSpellTarget()
    local target = GetSpellTargetUnit()
    if not target then target = GetSpellTargetItem() end
    if not target then target = GetSpellTargetDestructable() end
    return target
end

return AbilityEvent