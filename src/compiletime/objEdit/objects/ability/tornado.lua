WeTornadoAbility = {}

local WeField = require(CurrentLib..'.we_field')
local WeObject = require(CurrentLib..'.objects.we_object')
local WeEveryAbility = require(CurrentLib..'.objects.ability.every')
setmetatable(WeTornadoAbility, {__index = WeEveryAbility})

function WeTornadoAbility.new(id)
    local we_ability = WeEveryAbility.new(id, 'Atsp', 'ability')
    setmetatable(we_ability, {__index = WeTornadoAbility})
    return we_ability
end

function WeTornadoAbility:setMinimumHitIntervalseconds(real_data, lvl)
    self:addField(WeField.new("Tsp2", 'unreal', lvl, 2, real_data))
end

function WeTornadoAbility:setAirTimeseconds(real_data, lvl)
    self:addField(WeField.new("Tsp1", 'unreal', lvl, 1, real_data))
end

return WeTornadoAbility