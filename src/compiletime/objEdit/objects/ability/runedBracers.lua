local RunedBracers = {}

local WeField = require(CurrentLib..'.weField')
local WeEveryAbility = require(CurrentLib..'.objects.ability.every')
setmetatable(RunedBracers, {__index = WeEveryAbility})

function RunedBracers.new(id)
    local we_ability = WeEveryAbility.new(id, 'AIsr')
    setmetatable(we_ability, {__index = RunedBracers})
    return we_ability
end

function RunedBracers:setDamageBonus(real_data, lvl)
    self:addField(WeField.new("isr1", 'unrealm', lvl, 1, real_data))
end

function RunedBracers:setDamageReduction(real_data, lvl)
    self:addField(WeField.new("isr2", 'unreal', lvl, 2, real_data))
end

return RunedBracers
