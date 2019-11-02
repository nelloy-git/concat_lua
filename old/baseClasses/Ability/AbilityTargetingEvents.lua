local Ability = require('baseClasses.Ability.AbilityData')
local Unit = require('baseClasses.Unit')
local PlayerUtils = require('baseClasses.PlayerUtils')
---@type Settings
local Settings = require('utils.Settings')

local DummyAbilityEvent = {}

-- ============
--  Predefined
-- ============
---@type fun():nil
local startTargeting
---@type fun():nil
local cancelTargeting
---@type fun():nil
local shiftPressed
---@type fun():nil
local escapePressed
---@type fun():nil
local mousePressed
---@type fun():nil
local mouseMoved

local local_targeting_data

local initialized = false
function DummyAbilityEvent.init()
    if initialized then return nil end

    local finish_casting_trigger = Unit.getTrigger(EVENT_PLAYER_UNIT_SPELL_FINISH)
    finish_casting_trigger:addAction(runFuncInDebug, startTargeting)

    local any_player_press_lshift = PlayerUtils.getKeyTrigger(OSKEY_LSHIFT)
    any_player_press_lshift:addAction(runFuncInDebug, shiftPressed)

    local any_player_press_rshift = PlayerUtils.getKeyTrigger(OSKEY_RSHIFT)
    any_player_press_rshift:addAction(runFuncInDebug, shiftPressed)

    local any_player_press_escape = PlayerUtils.getKeyTrigger(OSKEY_ESCAPE)
    any_player_press_escape :addAction(runFuncInDebug, escapePressed)

    local any_player_press_mouse = PlayerUtils.getTrigger(EVENT_PLAYER_MOUSE_DOWN)
    any_player_press_mouse:addAction(runFuncInDebug, mousePressed)

    local any_player_mouse_move = PlayerUtils.getTrigger(EVENT_PLAYER_MOUSE_MOVE)
    any_player_mouse_move:addAction(runFuncInDebug, mouseMoved)

    initialized = true
end

startTargeting = function()
    local id = GetSpellAbilityId()
    local ability = Ability.get(id)
    local caster = Unit.GetSpellAbilityUnit()

    if GetLocalPlayer() ~= GetOwningPlayer(caster) then return nil end

    cancelTargeting()
    if id ~= ability:getDummyId() then return nil end

    local_targeting_data = {
        ability = ability,
        caster = caster
    }

    ability:runCallback("StartTargeting", caster)

    if Settings.Events.VerboseAbilityTargeting then
        Debug("Targeting started")
    end
end

shiftPressed = function()
    if GetTriggerPlayer() ~= GetLocalPlayer() then return nil end
    if not BlzGetTriggerPlayerIsKeyDown() then return nil end

    local player = GetTriggerPlayer()
    local selected = Unit.getSelectedByPlayer(player)

    for i = 1, #selected do
        SelectUnit(selected[i]:getObj(), false)
    end

    cancelTargeting()

    if Settings.Events.VerboseAbilityTargeting then
        Debug("Shift pressed")
    end
end

escapePressed = function()
    if GetTriggerPlayer() ~= GetLocalPlayer() then return nil end
    if not BlzGetTriggerPlayerIsKeyDown() then return nil end
    cancelTargeting()

    if Settings.Events.VerboseAbilityTargeting then
        Debug("Escape pressed")
    end
end

mousePressed = function()
    if GetTriggerPlayer() ~= GetLocalPlayer() then return nil end
    if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT then
        cancelTargeting()
    end
    -- TODO Left mouse button.
end

mouseMoved = function()
    if GetTriggerPlayer() ~= GetLocalPlayer() then return nil end
    if not local_targeting_data then return nil end

    local_targeting_data.ability:runCallback("TargetingMouseMove", local_targeting_data.caster)
end

cancelTargeting = function()
    if local_targeting_data then
        local_targeting_data.ability:runCallback("FinishTargeting", local_targeting_data.caster)
        local_targeting_data = nil
    end
end

---Compiletime only
---@param src ChannelCompiletimeData
---@return number
function Ability.generateDummyAbility(src)
    local WeObjEdit = require('compiletime.objEdit.objEdit')
    local Channel = WeObjEdit.Preset.Channel

    ---@type ChannelCompiletimeData
    local ability = Channel.new(src)
    ability:setField('Name', src['Name'])
    ability:setField('TooltipNormal', src['TooltipNormal'])
    ability:setField('Options', Channel.option.is_visible)
    ability:setField('TargetType', 'none')
    ability:setField('Cooldown', 0.1) -- Ability event need at least 0.05 sec cooldown
    return ability:generate()
end

return DummyAbilityEvent