--=========
-- Include
--=========

--region Include
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Trigger = UtilsLib.Handle.Trigger

--========
-- Module
--========

local DamageEvent = {}

function DamageEvent.Init()
    if IsCompiletime() then
        return
    end

    local trigger = Trigger.new()
    for i = 1, bj_MAX_PLAYER_SLOTS do
        trigger:addPlayerEvent(EVENT_PLAYER_UNIT_DAMAGING, Player(i))
    end
    trigger:addAction(function()
        local dmg = GetEventDamage()
        local damager = GetEventDamageSource()
        local target = BlzGetEventDamageTarget()
        local dmg_type = BlzGetEventDamageType()
    end)
end

return DamageEvent