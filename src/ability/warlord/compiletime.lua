local WarlordCompiletime = {}

function WarlordCompiletime.generateSummonSpearmanAbility(name, tooltip, range, area, cast_time, cooldown, hot_key)
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilId()
    local order = WeObjEdit.Utils.nextOrderId()

    ---@type ChannelWeAbility
    local abil = WeObjEdit.Preset.Channel.new(id, order, 1, 'point',
                                              true, true, false, false, false)
    abil:setTooltipNormal(name, 1)
    abil:setTooltipNormalExtended(tooltip, 1)
    abil:setCastRange(range, 1)
    abil:setAreaofEffect(area, 1)

    abil:setCastingTime(0, 1)
    abil:setFollowThroughTime(cast_time, 1)
    abil:setArtDuration(cast_time, 1)

    abil:setCooldown(cooldown, 1)
    abil:setHotkeyNormal(hot_key)

    return id
end

return WarlordCompiletime