---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeUnit
local AnyWeUnit = require('compiletime.objEdit.objects.unit.anyWeUnit')

---@class WeHero : AnyWeUnit
local WeHero = {}
setmetatable(WeHero, {__index = AnyWeUnit})

---@param id string
---@param base_id string
---@return WeHero
function WeHero.new(id, base_id)
    local we_unit = AnyWeUnit.new(id, base_id)
    setmetatable(we_unit, {__index = WeHero})
    return we_unit
end

---@param data integer
function WeHero:setTransportedSize(data) self:addField(WeField.new("ucar", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setLevel(data) self:addField(WeField.new("ulev", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setGroupSeparationPriority(data) self:addField(WeField.new("urpr", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setGroupSeparationParameter(data) self:addField(WeField.new("urpp", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setGroupSeparationGroupNumber(data) self:addField(WeField.new("urpg", 'int', nil, nil, data)) end
---@param data string
function WeHero:setGroupSeparationEnabled(data) self:addField(WeField.new("urpo", 'bool', nil, nil, data)) end
---@param data integer
function WeHero:setFormationRank(data) self:addField(WeField.new("ufor", 'int', nil, nil, data)) end
---@param data string
function WeHero:setStructuresBuilt(data) self:addField(WeField.new("ubui", 'string', nil, nil, data)) end
---@param data boolean
function WeHero:setHideHeroDeathMsg(data) self:addField(WeField.new("uhhd", 'bool', nil, nil, data)) end
---@param data boolean
function WeHero:setHideHeroInterfaceIcon(data) self:addField(WeField.new("uhhb", 'bool', nil, nil, data)) end
---@param data boolean
function WeHero:setHideHeroMinimapDisplay(data) self:addField(WeField.new("uhhm", 'bool', nil, nil, data)) end
---@param data string
function WeHero:setTooltipRevive(data) self:addField(WeField.new("utpr", 'string', nil, nil, data)) end
---@param data string
function WeHero:setTooltipAwaken(data) self:addField(WeField.new("uawt", 'string', nil, nil, data)) end
---@param data number
function WeHero:setStrengthPerLevel(data) self:addField(WeField.new("ustp", 'real', nil, nil, data)) end
---@param data integer
function WeHero:setStartingStrength(data) self:addField(WeField.new("ustr", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setStartingIntelligence(data) self:addField(WeField.new("uint", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setStartingAgility(data) self:addField(WeField.new("uagi", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setProperNamesUsed(data) self:addField(WeField.new("upru", 'int', nil, nil, data)) end
---@param data string
function WeHero:setProperNames(data) self:addField(WeField.new("upro", 'string', nil, nil, data)) end
---@param data string
function WeHero:setPrimaryAttribute(data) self:addField(WeField.new("upra", 'string', nil, nil, data)) end
---@param data number
function WeHero:setIntelligencePerLevel(data) self:addField(WeField.new("uinp", 'real', nil, nil, data)) end
---@param data string
function WeHero:setHeroRevivalLocations(data) self:addField(WeField.new("urva", 'string', nil, nil, data)) end
---@param data string
function WeHero:setHeroAbilities(data) self:addField(WeField.new("uhab", 'string', nil, nil, data)) end
---@param data number
function WeHero:setAgilityPerLevel(data) self:addField(WeField.new("uagp", 'real', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier1(data) self:addField(WeField.new("urq0", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier2(data) self:addField(WeField.new("urq1", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier3(data) self:addField(WeField.new("urq2", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier4(data) self:addField(WeField.new("urq3", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier5(data) self:addField(WeField.new("urq4", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier6(data) self:addField(WeField.new("urq5", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier7(data) self:addField(WeField.new("urq6", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier8(data) self:addField(WeField.new("urq7", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRequierementsForTier9(data) self:addField(WeField.new("urq8", 'string', nil, nil, data)) end
---@param data string
function WeHero:setUpgradesTo(data) self:addField(WeField.new("uupt", 'string', nil, nil, data)) end
---@param data string
function WeHero:setUnitsTrained(data) self:addField(WeField.new("utra", 'string', nil, nil, data)) end
---@param data string
function WeHero:setRevivesDeadHeros(data) self:addField(WeField.new("urev", 'bool', nil, nil, data)) end
---@param data string
function WeHero:setResearchesAvailable(data) self:addField(WeField.new("ures", 'string', nil, nil, data)) end
---@param data number
function WeHero:setPlacementRequiresWaterRadius(data) self:addField(WeField.new("upaw", 'real', nil, nil, data)) end
---@param data string
function WeHero:setPlacementRequires(data) self:addField(WeField.new("upap", 'string', nil, nil, data)) end
---@param data string
function WeHero:setPlacementPreventedBy(data) self:addField(WeField.new("upar", 'string', nil, nil, data)) end
---@param data string
function WeHero:setPathingMap(data) self:addField(WeField.new("upat", 'string', nil, nil, data)) end
---@param data string
function WeHero:setNeutralBuildingValidAsRandomBuilding(data) self:addField(WeField.new("unbr", 'bool', nil, nil, data)) end
---@param data string
function WeHero:setNeutralBuildingShowsMinimapIcon(data) self:addField(WeField.new("unbm", 'bool', nil, nil, data)) end
---@param data string
function WeHero:setItemsMade(data) self:addField(WeField.new("umki", 'string', nil, nil, data)) end
---@param data string
function WeHero:setGroundTexture(data) self:addField(WeField.new("uubs", 'string', nil, nil, data)) end
---@param data string
function WeHero:setConstructionSound(data) self:addField(WeField.new("ubsl", 'string', nil, nil, data)) end
---@param data string
function WeHero:setTooltipRevive(data) self:addField(WeField.new("utpr", 'string', nil, nil, data)) end
---@param data string
function WeHero:setTooltipAwaken(data) self:addField(WeField.new("uawt", 'string', nil, nil, data)) end
---@param data number
function WeHero:setStrengthPerLevel(data) self:addField(WeField.new("ustp", 'real', nil, nil, data)) end
---@param data integer
function WeHero:setStartingStrength(data) self:addField(WeField.new("ustr", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setStartingIntelligence(data) self:addField(WeField.new("uint", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setStartingAgility(data) self:addField(WeField.new("uagi", 'int', nil, nil, data)) end
---@param data integer
function WeHero:setProperNamesUsed(data) self:addField(WeField.new("upru", 'int', nil, nil, data)) end
---@param data string
function WeHero:setProperNames(data) self:addField(WeField.new("upro", 'string', nil, nil, data)) end
---@param data string
function WeHero:setPrimaryAttribute(data) self:addField(WeField.new("upra", 'string', nil, nil, data)) end
---@param data number
function WeHero:setIntelligencePerLevel(data) self:addField(WeField.new("uinp", 'real', nil, nil, data)) end
---@param data string
function WeHero:setHeroRevivalLocations(data) self:addField(WeField.new("urva", 'string', nil, nil, data)) end
---@param data string
function WeHero:setHeroAbilities(data) self:addField(WeField.new("uhab", 'string', nil, nil, data)) end
---@param data number
function WeHero:setAgilityPerLevel(data) self:addField(WeField.new("uagp", 'real', nil, nil, data)) end

return WeHero