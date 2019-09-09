---@type Ability
local Ability = require('ability.Ability')
---@type UnitEvent
local UnitEvent = require('utils.trigger.events.UnitEvents')
---@type PlayerEvent
local PlayerEvent = require('utils.trigger.events.PlayerEvents')
---@type SelectedUnits
local SelectedUnits = require('utils.trigger.events.SelectedUnits')
---@type Settings
local Settings = require('utils.Settings')

---@class DummyAbilityEvent
local DummyAbilityEvent = {}

---@type SpellTargetingData
local local_targeting_data = require('ability.events.SpellTargetingData')

local initialized = false
function DummyAbilityEvent.init()
    if initialized then return nil end

    UnitEvent.init()
    UnitEvent.getTrigger("AnyUnitFinishCastingAbility"):addAction(DummyAbilityEvent.startTargeting)
    UnitEvent.getTrigger('AnyUnitDeselected'):addAction(DummyAbilityEvent.deselectCaster)

    PlayerEvent.init()
    --- Order stack can break system so block shift.
    PlayerEvent.getTrigger("LocalPlayerShiftDown"):addAction(DummyAbilityEvent.blockShift)

    PlayerEvent.getTrigger("LocalPlayerEscDown"):addAction(DummyAbilityEvent.cancelTargeting)
    PlayerEvent.getTrigger("LocalPlayerMouseDown"):addAction(function()
        if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT then
            DummyAbilityEvent.cancelTargeting()
        end
    end)

    Debug("Dummy ability initialized")

    initialized = true
end

function DummyAbilityEvent.startTargeting()
    local id = GetSpellAbilityId()
    local ability = Ability.get(id)
    if not ability then return nil end

    local caster = GetSpellAbilityUnit()
    if GetLocalPlayer() ~= GetOwningPlayer(caster) then return nil end

    if id ~= ability:getDummyId() then
        DummyAbilityEvent.cancelTargeting()
        return nil
    end

    local_targeting_data.start(ability, caster)

    if Settings.Events.VerboseAbility then
        Debug("Targeting started")
    end
end

function DummyAbilityEvent.deselectCaster()
    if GetTriggerPlayer() ~= GetLocalPlayer() then return nil end
    if local_targeting_data.getCaster() ~= GetTriggerUnit() then return nil end

    DummyAbilityEvent.cancelTargeting()
end

function DummyAbilityEvent.blockShift()
    local player = GetTriggerPlayer()
    if player ~= GetLocalPlayer() then return nil end

    local selected = SelectedUnits.get(player)
    for i = 1, #selected do
        SelectUnit(selected[i], false)
    end

    if local_targeting_data then local_targeting_data:cancel() end
end

function DummyAbilityEvent.cancelTargeting()
    local_targeting_data.finish()

    if Settings.Events.VerboseAbility then
        Debug("Targeting canceled.")
    end
end

return DummyAbilityEvent