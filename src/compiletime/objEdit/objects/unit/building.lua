local WeBuilding = {}

local WeField = require(CurrentLib..'.we_field')
local WeObject = require(CurrentLib..'.objects.we_object')
local WeEveryUnit = require(CurrentLib..'.objects.unit.every')
setmetatable(WeBuilding, {__index = WeEveryUnit})

function WeBuilding.new(id, base_id)
    local we_unit = WeEveryUnit.new(id, base_id, 'unit')
    setmetatable(we_unit, {__index = WeBuilding})
    return we_unit
end

function WeBuilding:setUpgradesTo(string_data)
    self:addField(WeField.new("uupt", 'string', nil, nil, string_data))
end

function WeBuilding:setUnitsTrained(string_data)
    self:addField(WeField.new("utra", 'string', nil, nil, string_data))
end

function WeBuilding:setRevivesDeadHeros(bool_data)
    self:addField(WeField.new("urev", 'bool', nil, nil, bool_data))
end

function WeBuilding:setResearchesAvailable(string_data)
    self:addField(WeField.new("ures", 'string', nil, nil, string_data))
end

function WeBuilding:setPlacementRequiresWaterRadius(real_data)
    self:addField(WeField.new("upaw", 'real', nil, nil, real_data))
end

function WeBuilding:setPlacementRequires(string_data)
    self:addField(WeField.new("upap", 'string', nil, nil, string_data))
end

function WeBuilding:setPlacementPreventedBy(string_data)
    self:addField(WeField.new("upar", 'string', nil, nil, string_data))
end

function WeBuilding:setPathingMap(string_data)
    self:addField(WeField.new("upat", 'string', nil, nil, string_data))
end

function WeBuilding:setNeutralBuildingValidAsRandomBuilding(bool_data)
    self:addField(WeField.new("unbr", 'bool', nil, nil, bool_data))
end

function WeBuilding:setNeutralBuildingShowsMinimapIcon(bool_data)
    self:addField(WeField.new("unbm", 'bool', nil, nil, bool_data))
end

function WeBuilding:setItemsMade(string_data)
    self:addField(WeField.new("umki", 'string', nil, nil, string_data))
end

function WeBuilding:setGroundTexture(string_data)
    self:addField(WeField.new("uubs", 'string', nil, nil, string_data))
end

function WeBuilding:setConstructionSound(string_data)
    self:addField(WeField.new("ubsl", 'string', nil, nil, string_data))
end

function WeBuilding:setUpgradesTo(string_data)
    self:addField(WeField.new("uupt", 'string', nil, nil, string_data))
end

function WeBuilding:setUnitsTrained(string_data)
    self:addField(WeField.new("utra", 'string', nil, nil, string_data))
end

function WeBuilding:setRevivesDeadHeros(bool_data)
    self:addField(WeField.new("urev", 'bool', nil, nil, bool_data))
end

function WeBuilding:setResearchesAvailable(string_data)
    self:addField(WeField.new("ures", 'string', nil, nil, string_data))
end

function WeBuilding:setPlacementRequiresWaterRadius(real_data)
    self:addField(WeField.new("upaw", 'real', nil, nil, real_data))
end

function WeBuilding:setPlacementRequires(string_data)
    self:addField(WeField.new("upap", 'string', nil, nil, string_data))
end

function WeBuilding:setPlacementPreventedBy(string_data)
    self:addField(WeField.new("upar", 'string', nil, nil, string_data))
end

function WeBuilding:setPathingMap(string_data)
    self:addField(WeField.new("upat", 'string', nil, nil, string_data))
end

function WeBuilding:setNeutralBuildingValidAsRandomBuilding(bool_data)
    self:addField(WeField.new("unbr", 'bool', nil, nil, bool_data))
end

function WeBuilding:setNeutralBuildingShowsMinimapIcon(bool_data)
    self:addField(WeField.new("unbm", 'bool', nil, nil, bool_data))
end

function WeBuilding:setItemsMade(string_data)
    self:addField(WeField.new("umki", 'string', nil, nil, string_data))
end

function WeBuilding:setGroundTexture(string_data)
    self:addField(WeField.new("uubs", 'string', nil, nil, string_data))
end

function WeBuilding:setConstructionSound(string_data)
    self:addField(WeField.new("ubsl", 'string', nil, nil, string_data))
end

function WeBuilding:setTooltipRevive(string_data)
    self:addField(WeField.new("utpr", 'string', nil, nil, string_data))
end

function WeBuilding:setTooltipAwaken(string_data)
    self:addField(WeField.new("uawt", 'string', nil, nil, string_data))
end

function WeBuilding:setStrengthPerLevel(real_data)
    self:addField(WeField.new("ustp", 'real', nil, nil, real_data))
end

function WeBuilding:setStartingStrength(int_data)
    self:addField(WeField.new("ustr", 'int', nil, nil, int_data))
end

function WeBuilding:setStartingIntelligence(int_data)
    self:addField(WeField.new("uint", 'int', nil, nil, int_data))
end

function WeBuilding:setStartingAgility(int_data)
    self:addField(WeField.new("uagi", 'int', nil, nil, int_data))
end

function WeBuilding:setProperNamesUsed(int_data)
    self:addField(WeField.new("upru", 'int', nil, nil, int_data))
end

function WeBuilding:setProperNames(string_data)
    self:addField(WeField.new("upro", 'string', nil, nil, string_data))
end

function WeBuilding:setPrimaryAttribute(string_data)
    self:addField(WeField.new("upra", 'string', nil, nil, string_data))
end

function WeBuilding:setIntelligencePerLevel(real_data)
    self:addField(WeField.new("uinp", 'real', nil, nil, real_data))
end

function WeBuilding:setHeroRevivalLocations(string_data)
    self:addField(WeField.new("urva", 'string', nil, nil, string_data))
end

function WeBuilding:setHeroAbilities(string_data)
    self:addField(WeField.new("uhab", 'string', nil, nil, string_data))
end

function WeBuilding:setAgilityPerLevel(real_data)
    self:addField(WeField.new("uagp", 'real', nil, nil, real_data))
end

return WeBuilding