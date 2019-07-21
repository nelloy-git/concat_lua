local WeHero = {}

local WeField = require('compiletime.objEdit.we_field')
local WeObject = require('compiletime.objEdit.objects.we_object')
local WeEveryUnit = require('compiletime.objEdit.objects.unit.every')
setmetatable(WeHero, {__index = WeEveryUnit})

function WeHero.new(id, base_id)
    local we_unit = WeObject.new(id, base_id, 'unit')
    setmetatable(we_unit, {__index = WeHero})
    return we_unit
end

function WeHero:setTransportedSize(int_data)
    self:addField(WeField.new("ucar", 'int', nil, nil, int_data))
end

function WeHero:setLevel(int_data)
    self:addField(WeField.new("ulev", 'int', nil, nil, int_data))
end

function WeHero:setGroupSeparationPriority(int_data)
    self:addField(WeField.new("urpr", 'int', nil, nil, int_data))
end

function WeHero:setGroupSeparationParameter(int_data)
    self:addField(WeField.new("urpp", 'int', nil, nil, int_data))
end
function WeHero:setGroupSeparationGroupNumber(int_data)
    self:addField(WeField.new("urpg", 'int', nil, nil, int_data))
end

function WeHero:setGroupSeparationEnabled(bool_data)
    self:addField(WeField.new("urpo", 'bool', nil, nil, bool_data))
end

function WeHero:setFormationRank(int_data)
    self:addField(WeField.new("ufor", 'int', nil, nil, int_data))
end

function WeHero:setStructuresBuilt(string_data)
    self:addField(WeField.new("ubui", 'string', nil, nil, string_data))
end

function WeHero:hideHeroDeathMsg(bool_flag)
    self:addField(WeField.new("uhhd", 'bool', nil, nil, bool_flag))
end

function WeHero:hideHeroInterfaceIcon(bool_flag)
    self:addField(WeField.new("uhhb", 'bool', nil, nil, bool_flag))
end

function WeHero:hideHeroMinimapDisplay(bool_flag)
    self:addField(WeField.new("uhhm", 'bool', nil, nil, bool_flag))
end

function WeHero:setTooltipRevive(string_data)
    self:addField(WeField.new("utpr", 'string', nil, nil, string_data))
end

function WeHero:setTooltipAwaken(string_data)
    self:addField(WeField.new("uawt", 'string', nil, nil, string_data))
end

function WeHero:setStrengthPerLevel(real_data)
    self:addField(WeField.new("ustp", 'real', nil, nil, real_data))
end

function WeHero:setStartingStrength(int_data)
    self:addField(WeField.new("ustr", 'int', nil, nil, int_data))
end

function WeHero:setStartingIntelligence(int_data)
    self:addField(WeField.new("uint", 'int', nil, nil, int_data))
end

function WeHero:setStartingAgility(int_data)
    self:addField(WeField.new("uagi", 'int', nil, nil, int_data))
end

function WeHero:setProperNamesUsed(int_data)
    self:addField(WeField.new("upru", 'int', nil, nil, int_data))
end

function WeHero:setProperNames(string_data)
    self:addField(WeField.new("upro", 'string', nil, nil, string_data))
end

function WeHero:setPrimaryAttribute(string_data)
    self:addField(WeField.new("upra", 'string', nil, nil, string_data))
end

function WeHero:setIntelligencePerLevel(real_data)
    self:addField(WeField.new("uinp", 'real', nil, nil, real_data))
end

function WeHero:setHeroRevivalLocations(string_data)
    self:addField(WeField.new("urva", 'string', nil, nil, string_data))
end

function WeHero:setHeroAbilities(string_data)
    self:addField(WeField.new("uhab", 'string', nil, nil, string_data))
end

function WeHero:setAgilityPerLevel(real_data)
    self:addField(WeField.new("uagp", 'real', nil, nil, real_data))
end

function WeHero:setRequierementsForTier1(string_data)
    self:addField(WeField.new("urq0", 'string', nil, nil, string_data))
end

function WeHero:setRequierementsForTier2(string_data)
    self:addField(WeField.new("urq1", 'string', nil, nil, string_data))
end

function WeHero:setRequierementsForTier3(string_data)
    self:addField(WeField.new("urq2", 'string', nil, nil, string_data))
end

function WeHero:setRequierementsForTier4(string_data)
    self:addField(WeField.new("urq3", 'string', nil, nil, string_data))
end

function WeHero:setRequierementsForTier5(string_data)
    self:addField(WeField.new("urq4", 'string', nil, nil, string_data))
end

function WeHero:setRequierementsForTier6(string_data)
    self:addField(WeField.new("urq5", 'string', nil, nil, string_data))
end

function WeHero:setRequierementsForTier7(string_data)
    self:addField(WeField.new("urq6", 'string', nil, nil, string_data))
end

function WeHero:setRequierementsForTier8(string_data)
    self:addField(WeField.new("urq7", 'string', nil, nil, string_data))
end

function WeHero:setRequierementsForTier9(string_data)
    self:addField(WeField.new("urq8", 'string', nil, nil, string_data))
end

function WeHero:setUpgradesTo(string_data)
    self:addField(WeField.new("uupt", 'string', nil, nil, string_data))
end

function WeHero:setUnitsTrained(string_data)
    self:addField(WeField.new("utra", 'string', nil, nil, string_data))
end

function WeHero:setRevivesDeadHeros(bool_data)
    self:addField(WeField.new("urev", 'bool', nil, nil, bool_data))
end

function WeHero:setResearchesAvailable(string_data)
    self:addField(WeField.new("ures", 'string', nil, nil, string_data))
end

function WeHero:setPlacementRequiresWaterRadius(real_data)
    self:addField(WeField.new("upaw", 'real', nil, nil, real_data))
end

function WeHero:setPlacementRequires(string_data)
    self:addField(WeField.new("upap", 'string', nil, nil, string_data))
end

function WeHero:setPlacementPreventedBy(string_data)
    self:addField(WeField.new("upar", 'string', nil, nil, string_data))
end

function WeHero:setPathingMap(string_data)
    self:addField(WeField.new("upat", 'string', nil, nil, string_data))
end

function WeHero:setNeutralBuildingValidAsRandomBuilding(bool_data)
    self:addField(WeField.new("unbr", 'bool', nil, nil, bool_data))
end

function WeHero:setNeutralBuildingShowsMinimapIcon(bool_data)
    self:addField(WeField.new("unbm", 'bool', nil, nil, bool_data))
end

function WeHero:setItemsMade(string_data)
    self:addField(WeField.new("umki", 'string', nil, nil, string_data))
end

function WeHero:setGroundTexture(string_data)
    self:addField(WeField.new("uubs", 'string', nil, nil, string_data))
end

function WeHero:setConstructionSound(string_data)
    self:addField(WeField.new("ubsl", 'string', nil, nil, string_data))
end

function WeHero:setTooltipRevive(string_data)
    self:addField(WeField.new("utpr", 'string', nil, nil, string_data))
end

function WeHero:setTooltipAwaken(string_data)
    self:addField(WeField.new("uawt", 'string', nil, nil, string_data))
end

function WeHero:setStrengthPerLevel(real_data)
    self:addField(WeField.new("ustp", 'real', nil, nil, real_data))
end

function WeHero:setStartingStrength(int_data)
    self:addField(WeField.new("ustr", 'int', nil, nil, int_data))
end

function WeHero:setStartingIntelligence(int_data)
    self:addField(WeField.new("uint", 'int', nil, nil, int_data))
end

function WeHero:setStartingAgility(int_data)
    self:addField(WeField.new("uagi", 'int', nil, nil, int_data))
end

function WeHero:setProperNamesUsed(int_data)
    self:addField(WeField.new("upru", 'int', nil, nil, int_data))
end

function WeHero:setProperNames(string_data)
    self:addField(WeField.new("upro", 'string', nil, nil, string_data))
end

function WeHero:setPrimaryAttribute(string_data)
    self:addField(WeField.new("upra", 'string', nil, nil, string_data))
end

function WeHero:setIntelligencePerLevel(real_data)
    self:addField(WeField.new("uinp", 'real', nil, nil, real_data))
end

function WeHero:setHeroRevivalLocations(string_data)
    self:addField(WeField.new("urva", 'string', nil, nil, string_data))
end

function WeHero:setHeroAbilities(string_data)
    self:addField(WeField.new("uhab", 'string', nil, nil, string_data))
end

function WeHero:setAgilityPerLevel(real_data)
    self:addField(WeField.new("uagp", 'real', nil, nil, real_data))
end

return WeHero