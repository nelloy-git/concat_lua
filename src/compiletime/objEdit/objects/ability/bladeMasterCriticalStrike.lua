local criticalStrike = {}

local WeField = require(CurrentLib..'.we_field')
local WeEveryAbility = require(CurrentLib..'.objects.ability.every')
setmetatable(criticalStrike, {__index = WeEveryAbility})

function criticalStrike.new(id)
    local we_ability = WeEveryAbility.new(id, 'AOcr')
    setmetatable(we_ability, {__index = criticalStrike})
    return we_ability
end

function criticalStrike:setDamageMultiplier(real_data, lvl)
    self:addField(WeField.new("Ocr2", 'unreal', lvl, 2, real_data))
end

function criticalStrike:setChancetoCriticalStrike(real_data, lvl)
    self:addField(WeField.new("Ocr1", 'unreal', lvl, 1, real_data))
end

function criticalStrike:setDamageBonus(real_data, lvl)
    self:addField(WeField.new("Ocr3", 'unreal', lvl, 3, real_data))
end

function criticalStrike:setChancetoEvade(real_data, lvl)
    self:addField(WeField.new("Ocr4", 'unreal', lvl, 4, real_data))
end

function criticalStrike:setNeverMiss(bool_data, lvl)
    self:addField(WeField.new("Ocr5", 'bool', lvl, 5, bool_data))
end


return criticalStrike
