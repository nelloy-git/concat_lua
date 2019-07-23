WeChannelAbility = {}

local WeField = require(CurrentLib..'.we_field')
local WeObject = require(CurrentLib..'.objects.we_object')
local WeEveryAbility = require(CurrentLib..'.objects.ability.every')
setmetatable(WeChannelAbility, {__index = WeEveryAbility})

function WeChannelAbility.new(id)
    local we_ability = WeEveryAbility.new(id, 'ANcl', 'ability')
    setmetatable(we_ability, {__index = WeChannelAbility})
    return we_ability
end

function WeChannelAbility:setArtDuration(unreal_data, lvl)
    self:addField(WeField.new("Ncl4", 'unreal', lvl, 4, unreal_data))
end

function WeChannelAbility:setBaseOrderID(string_data, lvl)
    self:addField(WeField.new("Ncl6", 'string', lvl, 6, string_data))
end

function WeChannelAbility:setDisableOtherAbilities(int_data, lvl)
    self:addField(WeField.new("Ncl5", 'int', lvl, 5, int_data))
end

function WeChannelAbility:setFollowThroughTime(unreal_data, lvl)
    self:addField(WeField.new("Ncl1", 'unreal', lvl, 1, unreal_data))
end

function WeChannelAbility:setTargetType(int_data, lvl)
    self:addField(WeField.new("Ncl2", 'int', lvl, 2, int_data))
end

function WeChannelAbility:setOptions(int_data, lvl)
    self:addField(WeField.new("Ncl3", 'int', lvl, 3, int_data))
end


return WeChannelAbility