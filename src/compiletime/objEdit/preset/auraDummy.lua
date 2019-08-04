local AuraDummy = {}

local WeAuraSlow = require('compiletime.objEdit.objects.ability.auraSlow')
local WeBuff = require('compiletime.objEdit.objects.buff.buff')

function AuraDummy.new(ability_id, buff_id,
                       name, tooltip, icon_path, effect_path, attachment_point)
    local buff = WeBuff.new(buff_id, 'Bas1')
    buff:setName(name)
    buff:setTooltipNormal(name)
    buff:setTooltipNormalExtended(tooltip)
    buff:setIconNormal(icon_path)

    local abil = WeAuraSlow.new(ability_id)
    abil:setName("Aura Dummy: "..name)
    abil:setMovementSpeedFactor(0, 1)
    abil:setBuffs(buff_id, 1)
    abil:setIconNormal(icon_path)
    abil:setArtTarget("")
    abil:setTargetsAllowed("self", 1)
    abil:setArtTarget(effect_path)
    abil:setTargetAttachmentPoint(attachment_point)
end

return AuraDummy