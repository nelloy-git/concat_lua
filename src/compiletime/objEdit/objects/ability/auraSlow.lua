local WeAuraSlow = {}

local WeField = require(CurrentLib..'.we_field')
local WeEveryAbility = require(CurrentLib..'.objects.ability.every')
setmetatable(WeAuraSlow, {__index = WeEveryAbility})

function WeAuraSlow.new(id)
    local we_ability = WeEveryAbility.new(id, 'Aasl')
    setmetatable(we_ability, {__index = WeAuraSlow})
    return we_ability
end

function WeAuraSlow:setMovementSpeedFactor(real_data, lvl)
    self:addField(WeField.new("Slo1", 'unreal', lvl, 1, real_data))
end

function WeAuraSlow:setAlwaysAutocast(bool_data, lvl)
    self:addField(WeField.new("Slo3", 'bool', lvl, 3, bool_data))
end

function WeAuraSlow:setAttackSpeedFactor(real_data, lvl)
    self:addField(WeField.new("Slo2", 'unreal', lvl, 2, real_data))
end

return WeAuraSlow
