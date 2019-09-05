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
---@type SpellTargetingData
local SpellTargetingData= require('ability.events.SpellCastingData')

---@class DummyAbilityEvent
local DummyAbilityEvent = {}

local is_local_player_targeting = false

local initialized = false
function DummyAbilityEvent.init()
    if initialized then return nil end

    UnitEvent.init()
    UnitEvent.getTrigger("AnyUnitFinishCastingAbility", DummyAbilityEvent.startTargeting)
    UnitEvent.getTrigger('AnyUnitDeselected', function()
        local unit = GetTriggerUnit()
        if GetOwningPlayer(unit) ~= GetLocalPlayer() then return nil end

        if not is_local_player_targeting then return nil end

        local data = SpellTargetingData.get(unit)
        if data then data:cancel() end
        is_local_player_targeting = false

        if Settings.Events.VerboseAbility then
            Debug("Targeting canceled.")
        end
    end)

    PlayerEvent.init()
    PlayerEvent.getTrigger("LocalPlayerEscDown"):addAction(DummyAbilityEvent.cancelTargeting())
    PlayerEvent.getTrigger("LocalPlayerMouseDown"):addAction(function()
        if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT then
            DummyAbilityEvent.cancelTargeting()
        end
    end)

    initialized = true
end


function DummyAbilityEvent.startTargeting()
    local id = GetSpellAbilityId()
    local ability = Ability.get(id)
    local caster = GetSpellAbilityUnit()

    if id ~= ability:getUiId() then
        local data = SpellTargetingData.get(caster)
        if data then
            data:cancel()

            if Settings.Events.VerboseAbility then
                Debug("Targeting canceled bugged.")
            end
        end
        is_local_player_targeting = false
        return nil
    end
    if GetLocalPlayer() ~= GetOwningPlayer(caster) then return nil end

    is_local_player_targeting = true
    SpellTargetingData.new(ability, caster)

    if Settings.Events.VerboseAbility then
        Debug("Targeting started")
    end
end

function DummyAbilityEvent.cancelTargeting()
    if not is_local_player_targeting then return nil end

    local selected = SelectedUnits.get(GetLocalPlayer())
    for i = 1, #selected do
        local data = SpellTargetingData.get(selected[i])
        if data then data:cancel() end
    end

    is_local_player_targeting = false

    if Settings.Events.VerboseAbility then
        Debug("Targeting canceled.")
    end
end

return DummyAbilityEvent